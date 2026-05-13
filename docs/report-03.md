# Report 03 — UI-to-Backend Connection Audit

This report documents every file where the UI is not properly connected to the backend (repository layer / Riverpod providers). Problems are grouped by file. Issues are classified as **Critical** (data is silently dropped or never saved), **Incorrect** (wrong value shown or wrong logic applied), or **Missing** (feature exists in spec but is absent from the UI).

---

## `lib/screens/new_ironing_transaction_screen.dart`

### [Critical] Save button does not persist data

`_buildSaveAction` calls `Navigator.pop(context)` on the "Save Transaction" button (`onPressed: () => Navigator.pop(context)`, line 417). No call is made to `IroningRepository.addTransaction()`. The transaction is silently discarded on every submission.

### [Critical] No form state captured

There are no `TextEditingController` instances or a `GlobalKey<FormState>`. The amount field and description field values are never read. Even if the save button were wired up, there would be no data to pass to the repository.

### [Incorrect] Transaction type toggle maps to wrong labels

The toggle uses `_transactionType = 0` for "Debt" and `1` for "Credit". According to `docs/backend.md` §3.5, the `direction` field values must be `'credit'` or `'debit'`. The label "Debt" is the inverted naming of "Debit" and could cause confusion, but more importantly there is no mapping from this integer state to the string values the repository requires.

### [Incorrect] Date is hardcoded

The date selector displays the hardcoded string `'Today, Oct 24'` (line 305). The "Change Date" button's `onPressed` is `() {}` (line 313) — it opens no date picker. No user-set date is stored, so the transaction date cannot be correctly recorded.

---

## `lib/screens/new_ironing_transaction_summary_screen.dart`

### [Critical] Confirm button does not persist data

`_buildActions` calls `Navigator.pop(context)` on the "Confirm Transaction" button (line 388). No call is made to `IroningRepository.addTransaction()`. The regular transaction is silently discarded.

### [Critical] Price per item is hardcoded, not resolved from backend

The "Price per item" box shows the hardcoded value `'₹1.50'` (line 159). Per `docs/backend.md` §3.1, the active price must be resolved via `IroningRepository.getActivePrice(today)` at the time the form opens. The hardcoded price means `price_snapshot` would be wrong in any real transaction.

### [Critical] No form state captured

There are no `TextEditingController` instances. The cloth count field has `initialValue: '12'` (line 103) and the amount paid field has `initialValue: '20.00'` (line 219), but these values are never read from the widgets — they cannot be passed to the repository.

### [Incorrect] Transaction summary shows hardcoded computed values

`_buildTransactionSummary` shows `'12 items × ₹1.50'`, `'₹18'`, and `'+₹2'` as static strings (lines 311–354). These are not computed from the form fields and will not update as the user changes inputs.

### [Incorrect] Cloth count stepper buttons are non-functional

Both `+` and `-` stepper buttons have `onTap: () {}` (line 277). They do not update the cloth count field.

### [Incorrect] "Clear" button for amount paid is non-functional

The suffix `TextButton` for clearing the amount paid field has `onPressed: () {}` (line 247). It does not clear the field.

---

## `lib/screens/reset_transaction_screen.dart`

### [Critical] Confirm button does not persist data

`_buildActions` calls `Navigator.pop(context)` on the "Confirm Balance Reset" button (line 250). No call is made to `IroningRepository.addTransaction()` with `type: 'reset'`. The reset transaction is silently discarded.

### [Incorrect] Current balance is hardcoded

`_buildBalanceSummaryCard` displays the hardcoded value `'142.50'` (line 83). The real current balance must be read from `ironingBalanceProvider` (via `IroningRepository.getCurrentBalance()`). The user is shown a stale/fake balance before confirming the reset.

### [Missing] Reason text field value is not captured

The reason `TextFormField` has no `TextEditingController`. Even if the save button were wired up, the optional reason text could not be passed to the repository as `reason` on the reset transaction.

### [Incorrect] Clear button for reason field is non-functional

The suffix `IconButton` has `onPressed: () {}` (line 197). It does not clear the text field.

---

## `lib/screens/new_reading_screen.dart`

### [Critical] Submit button does not persist data

`_buildSubmitButton` calls `Navigator.pop(context)` on the "SUBMIT READING" button (line 485). No call is made to `ElectricityRepository.addReading()`. The reading is silently discarded.

### [Critical] Billing cycle values do not match the schema

The "Billing Cycle" toggle presents the labels `'Actual'` and `'Estimate'` (lines 253, 273). The `electricity_reading` schema (`docs/backend.md` §2) requires `billing_cycle` to be either `'monthly'` or `'bimonthly'`. The UI values are incompatible with the backend.

### [Critical] No form state captured

There are no `TextEditingController` instances for the meter value, reading date, or note fields. The form values cannot be passed to the repository.

### [Incorrect] Previous reading context card is hardcoded

The "Previous Reading" card shows `'12,450.00'` and `'Recorded on Oct 12, 2023'` (lines 73–81). It should display the latest reading from `ElectricityRepository.getReadings()`.

### [Incorrect] Estimated cost shows wrong currency symbol

The "Estimated Cost" card shows the suffix `'USD'` (line 90). The app tracks costs in rupees (₹). It should also be computed dynamically using the active rate from `ElectricityRepository.getActiveRate()`, not left as `'--.--'`.

### [Incorrect] Consumption preview is hardcoded

`_buildConsumptionPreview` shows a hardcoded `'0'` kWh (line 389) and a hardcoded `'Target: 450 kWh'` (line 468). These are not derived from the input field or the previous reading.

---

## `lib/screens/electricity_home_screen.dart`

### [Incorrect] "Latest Reading" section is entirely hardcoded

`_buildLatestReadingSection` shows the hardcoded date `'Oct 24, 2023'` (line 85) and meter value `'12,458.2'` (line 112). These should be read from the most recent entry returned by `ElectricityRepository.getReadings()` (already available via `electricityReadingsProvider`).

### [Incorrect] Analytics visual shows hardcoded values and wrong currency

`_buildAnalyticsVisual` displays `'14.2 kWh'` for average daily usage and `'€142.50'` for estimated bill (lines 198, 227). The currency symbol is `€` (euro) instead of `₹` (rupee), and both values are hardcoded rather than computed from backend data.

### [Incorrect] Consumption delta in readings list shows placeholder `'...'`

In `_buildPastReadingsList`, the `delta` argument passed to each reading row is the string `'...'` (line 301). The comment acknowledges that `getConsumptionForReading` should be called. Per `docs/backend.md` §4.1, consumption must be derived at read time as `current.meter_value - previous.meter_value`. The first reading should display `'—'`, not `'...'`.

### [Critical] Navigation to `ReadingDetailScreen` passes no data

`_buildPastReadingsList` navigates to `const ReadingDetailScreen()` (line 302) without passing the reading object. `ReadingDetailScreen` accepts no constructor parameter, so it can only show hardcoded demo data regardless of which row is tapped.

---

## `lib/screens/reading_detail_screen.dart`

### [Critical] Entire screen is hardcoded — no reading data accepted or displayed

`ReadingDetailScreen` is a `StatelessWidget` with no constructor parameters (line 7). It cannot receive a reading object from the caller. Every value on screen is hardcoded demo data: meter value `'42,891.50'` (line 97), net consumption `'452.20'` (line 147), percentage vs prior `'+12.4%'` (line 181), billing context rows (lines 229–233), bar chart data (lines 319–338), and notes (lines 440–444).

Per `docs/backend.md` §4.1 and §4.3, this screen should display data from a passed `ElectricityReading` object and derive consumption by calling `ElectricityRepository.getConsumptionForReading(id)`.

### [Missing] Edit functionality not wired up

Per `docs/backend.md` §4.3, electricity readings are editable. There is no edit button or action on this screen, and `ElectricityRepository.updateReading()` is never called from anywhere in the UI.

---

## `lib/screens/dashboard_screen.dart`

### [Incorrect] Electricity module card shows entirely hardcoded data

`_buildMainModules` passes hardcoded strings `'12,482'` for Meter Reading, `'+342'` for Consumption, and `'Nov 01, 2023'` for Last Reading Date into the electricity module card (lines 221–229). These must be read from the latest electricity reading via `electricityReadingsProvider`.

### [Incorrect] Ironing module card "Last Transaction" date is hardcoded

The Ironing module card passes `footerValue: 'Oct 24, 2023'` (line 209). This should be the `date` field of the most recent ironing transaction from `recentIroningTransactionsProvider`.

### [Incorrect] Ironing balance color is always red regardless of sign

`_buildModuleCard` for the Ironing card passes `valueColor: AppTheme.error` (line 207), which is always red. Per `docs/backend.md` §3.2 and `AGENTS.md` sign conventions, a positive balance (credit) should use a green/success color; only a negative balance (debt) should be red.

### [Incorrect] "Reports" quick action navigates to the same screen as "History"

The "Reports" action card uses `onTap: () => Navigator.push(...TransactionHistoryScreen())` (line 137) — identical to the "History" action on line 128. There is no Reports screen; the navigation is a duplicate placeholder.

### [Incorrect] Reset transactions in recent ledger show as `'-₹0.00'` with wrong label

In `_buildRecentLedger`, the amount for non-regular transactions is computed as `tx.amount ?? 0.0` (line 483). For `reset` transactions, `amount` is `null`, so the displayed amount is `₹0.00`. The `isCredit` check (line 485) also evaluates to `false` for reset transactions (they have no `direction`), resulting in the label `'-₹0.00'` which is misleading. Additionally, the title shown is `'Custom Transaction'` for all non-regular transactions (line 492), which does not distinguish reset transactions.

---

## `lib/screens/ironing_home_screen.dart`

### [Incorrect] Stats bento shows hardcoded values

`_buildStatsBento` displays `'128'` for Monthly Count and `'₹10'` for Avg. Price/pc (lines 445, 489). These are not derived from any backend query.

### [Incorrect] Balance card shows hardcoded "Current Batch" and "Last Payment"

Inside `_buildBalanceSection`, the sub-stats show `'42 Items'` for Current Batch (line 132) and `'12 Oct'` for Last Payment (line 159). These are static strings and not connected to any repository call.

### [Incorrect] Reset transactions in recent activity show as `'-₹0.00'` with wrong label

Same issue as in `dashboard_screen.dart`: `_buildRecentActivity` computes amount as `tx.amount ?? 0.0` (line 334), so reset transactions show `₹0.00`. The title falls through to `'Custom Transaction'` for all non-regular, non-reset rows (the reset case is not handled in `title` computation — only type `'regular'` is checked, line 342–343).

---

## `lib/screens/transaction_history_screen.dart`

### [Incorrect] Stats bento shows hardcoded values

`_buildStatsBentoGrid` shows hardcoded `'₹284'` for Monthly Spend (line 141), `'₹1,420'` for Balance Status (line 217), `'Weekly'` for Ironing Frequency (line 189), and `'Every Tuesday & Friday'` (line 197). None of these are derived from the backend.

### [Missing] "Filters" and "Export" header buttons are non-functional

Both header buttons in `_buildHeader` have `onTap: () {}` (line 111). Filtering and exporting are not implemented.

---

## `lib/screens/history_screen.dart`

### [Critical] Entire screen is hardcoded — no backend data displayed

`_buildPriceHistoryList` shows three hardcoded electricity rate entries and one hardcoded ironing price entry (lines 299–357). None of this data comes from the repository. The screen should call `ElectricityRepository.getRateHistory()` and `IroningRepository.getPriceHistory()` to show real history.

### [Incorrect] Summary bento cards show hardcoded values

`_buildBentoGrid` shows `'₹0.138'` for Electricity Avg., `'₹2.50'` for Ironing Rate, and `'Oct 15, 2024'` for Next Scheduled Review (lines 91, 109, 146). These are static strings.

### [Incorrect] Filter tabs switch state but content does not change

The `_selectedTabIndex` state changes between "Electricity Rates" (0) and "Service Fees" (1) in `_buildFilterTabs`, but `_buildPriceHistoryList` renders the same hardcoded list regardless of the selected tab (line 295–359).

### [Missing] FloatingActionButton for adding new price/rate is non-functional

The `FloatingActionButton` has `onPressed: () {}` (line 41). There is no way for the user to add a new electricity rate or ironing price from this screen.

---

## `lib/screens/settings_screen.dart`

### [Incorrect] "Last Synced" timestamp is hardcoded

`_buildSyncSection` displays the hardcoded text `'Today, 10:45 AM'` (line 174). Per `docs/backend.md` §5.6 and the `SyncRepository` interface, this value should come from `SyncRepository.getLastSyncedAt()`.

### [Missing] Cloud sync toggle has no backend effect

The `Switch` widget in `_buildSyncSection` toggles `_syncEnabled` local state (line 147), but this has no effect on whether sync is actually enabled or disabled. The toggle state is not persisted and no sync logic is triggered.

---

## `lib/screens/sync_setup_screen.dart`

### [Critical] "Save Sync Preferences" button does nothing

`_buildActionButtons` has `onPressed: () {}` on the save button (line 350). No passphrase is processed, no PBKDF2 key is derived, no key hash is stored locally, and no initial full sync is triggered — all of which are required per `docs/backend.md` §5.1.

### [Missing] "View Sync Logs" button does nothing

The "View Sync Logs" button has `onPressed: () {}` (line 368). There is no screen to display `sync_log` entries and `SyncRepository.writeSyncLog()` / `getLastSyncedAt()` are never surfaced in the UI.

### [Incorrect] Last synced timestamp is hardcoded

`_buildSystemStatusCard` displays the hardcoded values `'Oct 24, 14:32'` and `'2 minutes ago'` (lines 242–251). This should be read from `SyncRepository.getLastSyncedAt()`.

### [Incorrect] Passphrase field has fake initial value

The `TextFormField` for the passphrase has `initialValue: '••••••••••••••••'` (line 138) — a hardcoded string of bullet characters, not a real masked stored value. The actual PBKDF2 key derivation described in the UI tooltip (line 184) is not implemented.

---

## `lib/providers/app_providers.dart`

### [Missing] No provider for active ironing price

There is no `ironingActivePriceProvider`. The `new_ironing_transaction_summary_screen.dart` needs to resolve the active price via `IroningRepository.getActivePrice(today)` when the form opens.

### [Missing] No provider for active electricity rate

There is no `electricityActiveRateProvider`. The `new_reading_screen.dart` needs this to compute the estimated cost preview.

### [Missing] No providers for price/rate history

There is no `ironingPriceHistoryProvider` or `electricityRateHistoryProvider`. The `history_screen.dart` needs both of these to display real data.

### [Missing] No provider for electricity consumption per reading

There is no provider that calls `ElectricityRepository.getConsumptionForReading()`. The `electricity_home_screen.dart` and `reading_detail_screen.dart` both need consumption data.

---

## Summary Table

| File | Critical | Incorrect | Missing |
|---|:---:|:---:|:---:|
| `new_ironing_transaction_screen.dart` | 2 | 2 | — |
| `new_ironing_transaction_summary_screen.dart` | 3 | 3 | — |
| `reset_transaction_screen.dart` | 1 | 2 | 1 |
| `new_reading_screen.dart` | 3 | 3 | — |
| `electricity_home_screen.dart` | 1 | 3 | — |
| `reading_detail_screen.dart` | 1 | — | 1 |
| `dashboard_screen.dart` | — | 4 | — |
| `ironing_home_screen.dart` | — | 3 | — |
| `transaction_history_screen.dart` | — | 1 | 1 |
| `history_screen.dart` | 1 | 2 | 1 |
| `settings_screen.dart` | — | 1 | 1 |
| `sync_setup_screen.dart` | 1 | 2 | 1 |
| `app_providers.dart` | — | — | 4 |
