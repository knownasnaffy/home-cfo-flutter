# AGENTS.md

## Project Overview

**Home CFO** is a local-first personal household finance tracker. It currently has two modules: ironing serviceman balance tracking, and electricity meter reading tracking.

The Flutter app lives at the **repo root**. The Hono sync API location is TBD — likely `./api` or a separate repo.

---

## Repo Structure

```
/                        # Flutter app root
  lib/
    features/            # One folder per module (ironing, electricity)
    db/                  # Drift schema, DAOs, repository layer
    sync/                # Sync logic
    common/              # Shared widgets, utilities, constants
  docs/                  # Specifications (read these before coding)
    backend.md           # Authoritative backend and data flow spec
```

---

## Documentation First

**Always read `docs/backend.md` before touching anything related to:**
- Database schema or migrations
- Transaction or reading logic
- Balance computation
- Sync behavior
- Price/rate resolution

That file is the source of truth for how the app behaves internally. Do not infer behavior from code — if there is a conflict between code and `docs/backend.md`, the doc is correct and the code needs fixing.

---

## Stack

| Layer | Choice |
|---|---|
| Mobile | Flutter, Dart |
| Local DB | drift (SQLite ORM for Dart) |
| HTTP | dio or http package |
| Sync API | Hono on Cloudflare Workers |
| Remote DB | Neon Postgres (sync target only) |
| State management | Riverpod |

---

## Hard Rules

### Data Layer
- **Never query the database directly from a widget.** All DB access goes through the repository layer in `lib/db/repositories/`.
- **Never recompute balance from transaction history.** Current balance is the `balance_after` of the most recent transaction. Trust the snapshot.
- **Never store computed values for electricity consumption.** Consumption is always derived at read time: `current.meter_value - previous.meter_value`.
- **Always use client-generated UUIDs** via the `uuid` package (`const Uuid().v4()`). Never use auto-increment.
- **All datetimes in UTC** as ISO 8601 strings. Format for display only at the UI layer using the `intl` package.
- **Always filter `WHERE deleted_at IS NULL`** on every user-facing query. Soft deletes must never surface in the UI.

### Business Logic
- **Price and rate resolution is always date-scoped.** Use `MAX(effective_from) WHERE effective_from <= target_date`. Never use a single "current price" global.
- **Ironing transactions are immutable.** No edit or delete UI. Corrections go through a new custom transaction.
- **Electricity readings are editable.** Editing a reading must reset `synced_at = NULL` and update `updated_at`.
- **The first electricity reading has null consumption**, not zero. Display as `—`, never `0`.

### Sync
- **Sync never blocks the UI.** Always async, always fire-and-forget from the user's perspective.
- **The Hono API is a dumb relay.** It does not validate business logic, compute balances, or enforce transaction rules. All logic lives in the app.
- **Conflict resolution is last-write-wins** on `updated_at`. Do not build anything smarter than this.

### General
- **Do not add packages without a clear reason.** This is a simple personal app. Prefer solving problems with existing stack tools.
- **Do not expose sync internals to the user** beyond: sync status, last synced timestamp, and error message if failed.

---

## Sign Conventions (Ironing Balance)

- **Positive balance** → serviceman owes you (your credit)
- **Negative balance** → you owe serviceman (your debt)
- **Zero** → settled

Do not invert this. All UI color coding and labels depend on it.

---

## What the Sync API Owns

The Hono API exposes exactly three routes:

- `POST /sync/push` — receive batch upserts from device
- `GET /sync/pull?since=` — return rows updated after a timestamp
- `GET /health` — liveness check

Every request requires `Authorization: Bearer <key_hash>`. Do not add routes outside this surface without discussing first.
