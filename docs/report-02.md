# Home CFO — Completion Report

## Executive Summary

The project has a solid foundation: the data layer (Drift schema, all 5 tables, 3 repositories, Riverpod providers) is well-designed and largely spec-compliant. The UI exists as high-fidelity mockups. However, almost every screen is **disconnected from the database**, the **sync system is 100% unimplemented**, and **no form submission actually writes data**. The Hono backend API doesn't exist in this repo at all.

## 1. Critical — Forms Don't Write Any Data

Every "save" or "submit" button just calls `Navigator.pop()`. No data is ever persisted from the UI.

### 1.1 New Regular Ironing Transaction (`NewIroningTransactionSummaryScreen`)
- The cloth count stepper `+`/`–` buttons have empty `onTap: () {}` handlers — they do nothing
- Price per cloth is hardcoded `₹1.50` (not fetched from `IroningRepository.getActivePrice()`)
- All summary values (subtotal, total, change due) are static strings
- "Confirm Transaction" pops but never calls `IroningRepository.addTransaction()`
- After saving, the `ironingBalanceProvider` / `recentIroningTransactionsProvider` are never invalidated, so the UI would not refresh anyway

### 1.2 New Custom Ironing Transaction (`NewIroningTransactionScreen`)
- Amount, description, and direction fields collect input but it is never read
- Date selector displays "Today, Oct 24" (hardcoded); "Change Date" button has an empty handler
- "Save Transaction" pops but never calls `IroningRepository.addTransaction()`

### 1.3 Reset Ironing Transaction (`ResetTransactionScreen`)
- Current balance is hardcoded `₹142.50` (not read from `IroningRepository.getCurrentBalance()`)
- Reason field collects text but it is never read
- "Confirm Balance Reset" pops but never calls `IroningRepository.addTransaction()` with `type: 'reset'`

### 1.4 New Electricity Reading (`NewReadingScreen`)
- Previous reading context card shows hardcoded `12,450.00 kWh / Oct 12, 2023`
- Estimated cost shows `--.--, USD` (not fetched from `ElectricityRepository.getActiveRate()`)
- Consumption preview always shows `0 kWh` regardless of input
- Billing cycle toggle uses "Actual"/"Estimate" labels but the schema has `monthly`/`bimonthly` values — a mismatch
- Date field is a plain `TextFormField` with no date picker wired up
- "SUBMIT READING" pops but never calls `ElectricityRepository.addReading()`

## 2. Critical — Screens Show Hardcoded/Placeholder Data

### 2.1 `IroningHomeScreen`
- "Current Batch" card shows hardcoded `42 Items`
- "Last Payment" shows hardcoded `12 Oct`
- Stats bento: "Monthly Count" = `128 Items`, "Avg. Price/pc" = `₹10 Fixed` — all hardcoded

### 2.2 `ElectricityHomeScreen`
- Latest reading section: date `Oct 24, 2023`, value `12,458.2 kWh`, trend `-12% vs last month` — all hardcoded
- Analytics cards: `14.2 kWh` avg daily, `€142.50` est. bill (also uses `€` not `₹`) — hardcoded
- Past readings list: consumption delta column shows literal `'...'` string for every row
- Readings tap to `const ReadingDetailScreen()` — no reading data is passed

### 2.3 `ReadingDetailScreen`
- Accepts no parameters; all data is hardcoded: `42,891.50 kWh`, `452.20 kWh` net, `+12.4%`, `402.15 kWh` previous, date `Oct 24, 2023 • 09:42 AM`, etc.
- Billing context shows fictional values: `Q4 Autumn Fiscal`, `Sep 25 - Oct 24`, `Residential Peak-Saver`
- Notes section has a completely fictional paragraph

### 2.4 `TransactionHistoryScreen`
- Stats bento shows hardcoded `₹284` monthly spend, `₹1,420` balance status, `Weekly / Every Tuesday & Friday` ironing frequency
- "Filters" and "Export" buttons have empty `onTap: () {}`
- Insights cards at the bottom — need to check but likely hardcoded too

### 2.5 `HistoryScreen` (Price/Rate History)
- Entire list is hardcoded (3 electricity rates, 1 ironing rate with static dates/values)
- FAB "Add" button has an empty `onPressed: () {}`
- Tab switching has no effect on displayed content — both tabs show the same hardcoded list
- No form to add new ironing price or electricity rate entries

### 2.6 `SettingsScreen`
- "Last Synced" shows hardcoded `Today, 10:45 AM`
- Cloud Sync toggle (`_syncEnabled`) is local widget state only — changes nothing in the system
- "Ironing Price History" and "Electricity Rate History" both navigate to the same `HistoryScreen` (same destination)

### 2.7 `SyncSetupScreen`
- "Last Synced" shows hardcoded `Oct 24, 14:32 / 2 minutes ago`
- Cloud Sync toggle is local widget state only
- Passphrase field has hardcoded initial value `••••••••••••••••`
- "Save Sync Preferences" button has empty `onPressed: () {}`
- "View Sync Logs" button has empty `onPressed: () {}`

### 2.8 `DashboardScreen`
- Partially connected: balance and recent transactions come from providers
- But the electricity section and several stat tiles are likely hardcoded (large file, not fully reviewed, but based on pattern)

## 3. Critical — Riverpod Providers Not Invalidated After Mutations

All data providers (`ironingBalanceProvider`, `recentIroningTransactionsProvider`, `allIroningTransactionsProvider`, `electricityReadingsProvider`) use `FutureProvider`. They are computed once on first watch and cached. After any write, they must be explicitly invalidated via `ref.invalidate(...)` to reflect new data. Currently no screen does this, so even if form submission were wired up, the UI would not update.

## 4. Critical — Sync System Entirely Unimplemented

The `SyncRepository` class has skeleton methods for DB-level operations (marking rows as synced, getting last sync time, writing logs), but the actual sync engine — the thing that calls the Hono API — does not exist anywhere.

Missing pieces:
- **No HTTP client** — no `dio` or `http` package in `pubspec.yaml`
- **No `SyncService` class** — nothing that orchestrates push → pull → log
- **No PBKDF2 key derivation** — no `crypto` or `pointycastle` package
- **No secure key storage** — no `flutter_secure_storage` or equivalent; the derived key hash is never stored anywhere
- **No sync trigger wiring** — no app lifecycle listener for foreground-resume sync (spec §5.6), no background wifi task
- **No Sync button handler** — `TopAppBar`'s `showSync: true` renders a sync icon but it doesn't trigger any action
- **The Hono API backend does not exist in this repository** — the `./api` folder is absent

## 5. Navigation & Routing Problems

- `ReadingDetailScreen` is always constructed as `const ReadingDetailScreen()` — it needs an `ElectricityReading` parameter to display real data
- The dev/debug `Drawer` in `main.dart` (with "All Screens Navigation") should be removed before open-sourcing; it exists only for development convenience and is explicitly noted with a TODO comment
- The `HistoryScreen` is reachable both from Settings and from `ElectricityHomeScreen` but serves a dual purpose (price history + rate history) that isn't clearly scoped
- `NewIroningTransactionScreen` is mislabeled: the home screen calls it "New Custom Transaction" but the screen header says "New Ironing Transaction" — the flow is ambiguous

## 6. Schema/Spec Mismatches in UI

- `NewReadingScreen` billing cycle toggle shows "Actual" / "Estimate" but `ElectricityReadings.billingCycle` stores `monthly` / `bimonthly` (per schema)
- `ElectricityHomeScreen` estimated bill uses `€` (Euro) symbol; the app otherwise uses `₹` (Rupee) consistently — leftover from a design template
- `NewReadingScreen` estimated cost preview uses `USD` as the currency suffix
- App version in `SettingsScreen` is hardcoded `v2.4.0` but `pubspec.yaml` declares `1.0.0+1`
- `SyncSetupScreen` claims "Your local data is encrypted before it leaves this device" and mentions "AES-256 key" — the spec only describes PBKDF2-derived key hash for authentication, not AES-256 encryption of payloads; this copy is either inaccurate or describes a feature not in the spec

## 7. Missing Features Per Spec

| Feature | Status |
|---|---|
| Add new ironing price via UI | ❌ No form exists; `HistoryScreen` FAB does nothing |
| Add new electricity rate via UI | ❌ No form exists |
| Sync on app foreground resume (>1 hour) | ❌ Not wired |
| Background sync on WiFi every 6 hours | ❌ Not wired; no background task package |
| Sync status in settings (in-progress, last synced, last error) | ❌ All hardcoded |
| Manual sync trigger from TopAppBar | ❌ Button renders but has no handler |
| Passphrase → PBKDF2 → key hash → secure storage | ❌ None of this exists |
| Full sync on first passphrase setup | ❌ Not implemented |
| Sync log view screen | ❌ "View Sync Logs" button is a no-op |

## 8. Test Coverage Gaps

The existing tests (`ironing_repository_test.dart`, `electricity_repository_test.dart`) are good and cover core repository logic. What's missing:

- No tests for `SyncRepository`
- No widget tests for any screen
- No integration tests covering the write → read round-trip (e.g., add transaction → verify balance updates on `IroningHomeScreen`)
- No test for the sync service (once built)

## 9. Code Quality / Housekeeping

- Every screen hardcodes the same external Google image URL for `avatarUrl` — this should be replaced with a local asset or a configurable value
- The app has no error boundaries or user-facing error handling (DB errors surface as `Text('Error loading activity')`)
- `NewIroningTransactionScreen` contains a helper method `linearBinding()` that wraps `LinearGradient` for no reason — minor dead weight
- `pubspec.yaml` description is still the default `"A new Flutter project."`
- `README.md` contains only screenshots with no setup instructions, architecture description, or contributing guide — insufficient for open source

## Priority Order for Completion

1. **Wire up form submissions** (all 4 forms: regular transaction, custom transaction, reset, new reading) and **invalidate providers** after writes — this makes the app actually functional
2. **Connect screens to live data** (replace all hardcoded values with DB reads; pass `ElectricityReading` to `ReadingDetailScreen`)
3. **Add forms for new ironing price and electricity rate** (currently no UI path exists)
4. **Fix billing cycle mismatch** (`monthly`/`bimonthly` vs `Actual`/`Estimate`)
5. **Implement the sync engine** (add HTTP client, `SyncService`, PBKDF2 key derivation, secure storage, foreground/background triggers)
6. **Build the Hono API backend** (3 routes: `POST /sync/push`, `GET /sync/pull`, `GET /health`)
7. **Remove dev drawer** from `main.dart`
8. **Write a proper README** with setup, architecture, and contributing guide
9. **Add tests** for `SyncRepository` and the sync service once built
