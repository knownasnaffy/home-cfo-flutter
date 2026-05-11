# Home CFO — Backend Flow Specifications

## 1. Storage Architecture

### Local Database (Primary)
The app uses **SQLite via drift** as the single source of truth. All reads and writes happen locally. The app is fully functional with no network connection.

### Remote Database (Sync Target)
**Neon Postgres** is used exclusively as a sync target. It mirrors the local SQLite schema. It is never queried directly by the app during normal operation — only during sync.

### Rule
> The app never blocks on network. If sync fails, the user is notified but the app continues normally.

---

## 2. Database Schema

### `ironing_price`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT (UUID) | Primary key |
| `price_per_cloth` | REAL | In rupees |
| `effective_from` | TEXT (ISO date) | Date from which this price applies |
| `note` | TEXT | Optional |
| `created_at` | TEXT (ISO datetime) | |
| `updated_at` | TEXT (ISO datetime) | Updated on any mutation |
| `deleted_at` | TEXT (ISO datetime) | Soft delete |
| `synced_at` | TEXT (ISO datetime) | NULL if not yet synced |

### `ironing_transaction`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT (UUID) | Primary key |
| `type` | TEXT | `regular`, `reset`, `custom` |
| `date` | TEXT (ISO date) | Transaction date, user-set |
| `balance_before` | REAL | Balance snapshot at time of entry |
| `balance_after` | REAL | Computed and stored at time of entry |
| `price_snapshot` | REAL | Price per cloth at time of entry (regular only) |
| `cloth_count` | INTEGER | Regular only |
| `total_due` | REAL | Regular only |
| `amount_paid` | REAL | Regular only |
| `direction` | TEXT | Custom only: `credit` or `debit` |
| `amount` | REAL | Custom only |
| `label` | TEXT | Custom only |
| `reason` | TEXT | Reset only, optional |
| `created_at` | TEXT (ISO datetime) | |
| `updated_at` | TEXT (ISO datetime) | |
| `deleted_at` | TEXT (ISO datetime) | Soft delete |
| `synced_at` | TEXT (ISO datetime) | NULL if not yet synced |

### `electricity_reading`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT (UUID) | Primary key |
| `reading_date` | TEXT (ISO date) | User-set |
| `meter_value` | REAL | Raw meter reading in units |
| `billing_cycle` | TEXT | `monthly` or `bimonthly` |
| `note` | TEXT | Optional |
| `created_at` | TEXT (ISO datetime) | |
| `updated_at` | TEXT (ISO datetime) | |
| `deleted_at` | TEXT (ISO datetime) | Soft delete |
| `synced_at` | TEXT (ISO datetime) | NULL if not yet synced |

### `electricity_rate`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT (UUID) | Primary key |
| `rate_per_unit` | REAL | In rupees per unit |
| `effective_from` | TEXT (ISO date) | |
| `note` | TEXT | Optional |
| `created_at` | TEXT (ISO datetime) | |
| `updated_at` | TEXT (ISO datetime) | |
| `deleted_at` | TEXT (ISO datetime) | Soft delete |
| `synced_at` | TEXT (ISO datetime) | NULL if not yet synced |

### `sync_log`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT (UUID) | Primary key |
| `synced_at` | TEXT (ISO datetime) | When sync completed |
| `direction` | TEXT | `push`, `pull`, or `full` |
| `rows_pushed` | INTEGER | |
| `rows_pulled` | INTEGER | |
| `status` | TEXT | `success` or `failed` |
| `error` | TEXT | Optional error message |

---

## 3. Ironing Module Logic

### 3.1 Price Resolution

At any point in time, the active price is the `ironing_price` row whose `effective_from` is the most recent date that is **less than or equal to** the target date.

```
activePrice(date) = MAX(effective_from) WHERE effective_from <= date AND deleted_at IS NULL
```

This is used in two places:
- **New transaction form:** resolve against today's date to pre-fill the price field
- **Historical display:** each transaction stores `price_snapshot` at write time, so no re-resolution is needed for past records

> Price changes never retroactively affect past transactions. `price_snapshot` is immutable once written.

### 3.2 Balance Computation

Balance is a running total. It is **not recomputed from history** — each transaction stores `balance_before` and `balance_after` as snapshots.

**Sign convention:**
- Positive balance → serviceman owes you (your credit)
- Negative balance → you owe serviceman (your debt)
- Zero → settled

**Current balance** is always the `balance_after` of the most recent transaction ordered by `date`, then `created_at`.

### 3.3 Regular Transaction

```
total_due      = cloth_count × price_snapshot
delta          = amount_paid - total_due
balance_after  = balance_before + delta
```

`delta > 0` means you overpaid → your credit increases.
`delta < 0` means you underpaid → your debt increases.

### 3.4 Reset Transaction

```
balance_after = 0
```

`balance_before` is still recorded for audit visibility. Optional `reason` is stored. No other computation.

### 3.5 Custom Transaction

```
direction = 'credit' → balance_after = balance_before + amount
direction = 'debit'  → balance_after = balance_before - amount
```

Examples:
- You paid him extra cash without clothes → `debit`, reduces your balance
- He paid back what he owed → `credit`, increases your balance
- You forgave a debt you were owed → `debit`, written off from your credit

### 3.6 Transaction Immutability

Transactions are never edited after creation. If a mistake was made, the user enters a correcting custom transaction. This preserves a complete, honest audit trail. The UI does not expose an edit action on any transaction.

Deletion is also not exposed in the UI. Soft delete (`deleted_at`) exists only for sync conflict resolution purposes.

---

## 4. Electricity Module Logic

### 4.1 Consumption Calculation

Readings are ordered by `reading_date` ascending. Consumption for a reading is:

```
consumption = current.meter_value - previous.meter_value
```

The **first reading ever entered has no previous** — its consumption is `null`, displayed as `—` in the UI, never as `0`.

Consumption is always **derived at read time**, never stored. This means if a user edits a reading's meter value, consumption for that reading and the next one both update automatically.

### 4.2 Rate Resolution

Same pattern as ironing price:

```
activeRate(date) = MAX(effective_from) WHERE effective_from <= date AND deleted_at IS NULL
```

Cost estimate for a reading:

```
estimated_cost = consumption × rate_at_reading_date
```

If no rate is configured, cost estimate is omitted from the UI entirely — not shown as zero.

### 4.3 Reading Editability

Unlike ironing transactions, electricity readings **can be edited** (meter value, date, cycle, note). Meter readings are factual observations, not financial ledger entries, so correction is appropriate. Editing a reading triggers `updated_at` to be refreshed and `synced_at` to be set to NULL.

---

## 5. Sync System

### 5.1 Enabling Sync

Sync is opt-in. On first enable:
1. User enters a passphrase
2. A PBKDF2-derived key is generated from the passphrase
3. The key hash is stored locally as the sync credential
4. A full push of all local data is performed immediately
5. `sync_log` records the result

The passphrase itself is never stored. Only the derived key hash is kept.

### 5.2 Authentication

Every sync request to the Hono API includes the derived key hash as a Bearer token in the `Authorization` header. The API validates it against the stored hash. No user accounts, no sessions.

### 5.3 Sync Strategy — Last Write Wins

Each row has an `updated_at` timestamp. Conflict resolution is simple:

```
IF remote.updated_at > local.updated_at → remote wins, overwrite local
IF local.updated_at > remote.updated_at → local wins, overwrite remote
IF timestamps equal → no action needed
```

This is sufficient for a 1-2 person household where simultaneous conflicting edits are extremely unlikely.

### 5.4 Sync Flow (Full Sync)

A full sync runs in this order:

**Step 1 — Push**
1. Query all local rows where `synced_at IS NULL` across all tables
2. POST each changed row to `POST /sync/push` as a batch payload
3. API upserts rows into Neon using `id` as the conflict key
4. On success, set `synced_at = now()` locally for all pushed rows

**Step 2 — Pull**
1. Read `last_synced_at` from the most recent successful `sync_log` entry
2. GET `GET /sync/pull?since=<last_synced_at>` from API
3. API returns all rows with `updated_at > since` from Neon
4. For each returned row, apply last-write-wins comparison locally
5. Write incoming rows to local SQLite

**Step 3 — Log**
1. Write a `sync_log` entry with counts and status

### 5.5 Soft Deletes in Sync

Rows are never hard-deleted locally or remotely. When a row needs to be removed (currently only via developer tooling — the UI does not expose delete), `deleted_at` is set. The sync system treats soft-deleted rows the same as any other mutation — they get pushed/pulled and `deleted_at` propagates to both sides.

The app filters `WHERE deleted_at IS NULL` on all user-facing queries.

### 5.6 Sync Triggers

| Trigger | Behavior |
|---|---|
| Manual (user taps Sync) | Full sync runs immediately |
| App foreground resume | Full sync runs if last sync was more than 1 hour ago |
| Background (on wifi) | Optional, user-configurable, runs every 6 hours |

Sync never blocks the UI. It runs asynchronously. The Settings screen shows sync status (in progress, last synced time, last error if any).

### 5.7 API Routes (Hono on Cloudflare Workers)

| Method | Route | Description |
|---|---|---|
| POST | `/sync/push` | Receive batch of changed rows from device |
| GET | `/sync/pull?since=` | Return all rows updated after timestamp |
| GET | `/health` | Liveness check |

All routes require `Authorization: Bearer <key_hash>` header.

The API has no knowledge of business logic. It is a thin persistence layer. It does not compute balances, validate transaction types, or enforce any rules. All logic lives in the app.

---

## 6. ID Strategy

All primary keys are **UUIDs generated on the client** using the `uuid` Dart package (`const Uuid().v4()`). This is essential for a local-first architecture — rows must have stable, globally unique IDs before they ever touch the server.

Auto-increment integers are not used anywhere.

---

## 7. Date and Time Handling

- All dates stored as **ISO 8601 strings** in SQLite (`YYYY-MM-DD` for dates, `YYYY-MM-DDTHH:mm:ss.sssZ` for datetimes)
- All datetimes stored in **UTC**
- Display formatting (local timezone, locale-aware) happens only at the UI layer using `intl`
- `created_at` and `updated_at` are always set in UTC at write time
- `date` fields (transaction date, reading date) are **user-set calendar dates**, not timestamps — they represent "when this happened" as chosen by the user, not when the record was created

---

## 8. Data Layer Interface

The app interacts with SQLite through a repository layer. Each module has its own repository. No widget talks to the database directly.

```
IroningRepository
  getActivePrice(date)
  getPriceHistory()
  addPrice(price)
  getCurrentBalance()
  getRecentTransactions(limit)
  getAllTransactions()
  addTransaction(transaction)

ElectricityRepository
  getActiveRate(date)
  getRateHistory()
  addRate(rate)
  getReadings()
  addReading(reading)
  updateReading(id, fields)
  getConsumptionForReading(id)

SyncRepository
  getUnsyncedRows()
  markAsSynced(table, ids)
  getLastSyncedAt()
  writeSyncLog(entry)
```

This boundary means the sync system, the UI, and the business logic are all independently testable.
