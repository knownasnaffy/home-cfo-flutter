# Comprehensive Audit Report: Home CFO App Integration & UI Issues

This report details all the files and components within the Home CFO application that are currently misconfigured, containing hardcoded data, missing functionality, or lacking backend integration. It consolidates findings from codebase exploration, previous reports, and design requirements.

## 1. Missing or Misconfigured Functionality (Form Wiring & Backend Operations)

### `lib/screens/new_ironing_transaction_summary_screen.dart` (New Regular Ironing Transaction)
- **Form Actions Empty:** The stepper `+`/`-` buttons have empty `onTap: () {}` handlers and do not change the state.
- **Save Action Missing:** The "Confirm Transaction" button pops the screen but does not call `IroningRepository.addTransaction()`.
- **State Invalidation Missing:** The `ironingBalanceProvider` and `recentIroningTransactionsProvider` are not invalidated upon form save, so the UI will not reflect any changes.
- **Hardcoded Values:** Price per cloth is hardcoded to `₹1.50` instead of fetching from `IroningRepository.getActivePrice()`. The Subtotal, Total, and Change Due values are also static strings.

### `lib/screens/new_ironing_transaction_screen.dart` (New Custom Ironing Transaction)
- **Data Ignored:** Amount, description, and direction fields are rendered, but their values are never captured or used.
- **Hardcoded Date:** The date selector displays `"Today, Oct 24"` permanently, and the "Change Date" button lacks functionality.
- **Save Action Missing:** "Save Transaction" pops the screen but fails to call `IroningRepository.addTransaction()`.

### `lib/screens/reset_transaction_screen.dart` (Reset Ironing Transaction)
- **Hardcoded Values:** The "Current Balance" is hardcoded to `₹142.50` rather than resolving from `IroningRepository.getCurrentBalance()`.
- **Data Ignored:** The "Reason" text field collects input that is never utilized.
- **Save Action Missing:** "Confirm Balance Reset" pops the screen but fails to issue a reset transaction (`type: 'reset'`).

### `lib/screens/new_reading_screen.dart` (New Electricity Reading)
- **Hardcoded Values:** The previous reading context card displays statically `12,450.00 kWh / Oct 12, 2023`. Estimated cost is hardcoded to `--.--, USD` (not fetched from `ElectricityRepository.getActiveRate()`).
- **Logic Missing:** The consumption preview always shows `0 kWh` regardless of the user input.
- **Mismatch in Options:** The billing cycle toggle uses "Actual"/"Estimate", whereas the schema expects `monthly`/`bimonthly`.
- **Incomplete Components:** The date field is a standard `TextFormField` with no date picker.
- **Save Action Missing:** The "SUBMIT READING" button pops the screen without calling `ElectricityRepository.addReading()`.

## 2. Hardcoded UI Elements & Placeholder Data Across Screens

### `lib/screens/ironing_home_screen.dart`
- **Balance Card:** Shows statically `"42 Items"` for the Current Batch and `"12 Oct"` for Last Payment.
- **Stats Bento Grid:** "Monthly Count" is hardcoded to `128 Items` and "Avg. Price/pc" to `₹10 Fixed`.

### `lib/screens/electricity_home_screen.dart`
- **Latest Reading Section:** The date `"Oct 24, 2023"`, value `"12,458.2 kWh"`, and trend `"-12% vs last month"` are all statically typed.
- **Analytics Cards:** The average daily usage is hardcoded to `"14.2 kWh"` and estimated bill to `"€142.50"`. Notably, the Euro symbol (`€`) is incorrectly used instead of Rupee (`₹`).
- **Readings List:** The consumption delta column is hardcoded with the literal string `'...'` instead of computed consumption. Furthermore, tapping on a reading routes to `const ReadingDetailScreen()` without passing the required reading data.

### `lib/screens/reading_detail_screen.dart`
- **Completely Hardcoded:** The entire screen is currently a `StatelessWidget` that accepts no parameters. All data displayed—`42,891.50 kWh`, net consumption `452.20 kWh`, billing context ("Q4 Autumn Fiscal"), and placeholder notes—are completely static.
- **Edit Functionality Missing:** Despite `docs/backend.md` specifying that electricity readings are editable, there is no edit UI or wiring to `ElectricityRepository.updateReading()`.

### `lib/screens/dashboard_screen.dart`
- **Electricity Module:** Passes hardcoded strings like `"12,482"`, `"+342"`, and `"Nov 01, 2023"` into the module card.
- **Ironing Module:** "Last Transaction" date is hardcoded to `"Oct 24, 2023"`. Also, the module balance color is fixed to `AppTheme.error` (red), regardless of whether it's a credit or debt.
- **Mislabelled Items:** The "Reports" action navigates redundantly to the `TransactionHistoryScreen` (duplicate of the "History" action).
- **Recent Ledger Presentation:** Reset transactions improperly display as `'-₹0.00'` due to faulty handling of `null` amounts, and their title incorrectly falls back to `"Custom Transaction"`.

### `lib/screens/transaction_detail_screen.dart`
- **Ignored Parameters:** The `TransactionDetailScreen` completely ignores its `IroningTransaction? transaction` parameter. It relies exclusively on static widgets or does not properly use the object for rendering core details.
- **Currency Inconsistencies:** There are several hardcoded `$` amounts (e.g., `-$45.00` and `$12,450.80`) throughout the mock data.
- **Static Context:** Elements like `"ID: TXN-9921-XF8"`, `"HOUSEHOLD SERVICES"`, mock image URLs, and the "Modify Transaction Record" button (which shouldn't exist due to immutability rules) are all hardcoded.

### `lib/screens/transaction_history_screen.dart`
- **Stats Bento:** Hardcoded values for Monthly Spend (`₹284`), Balance Status (`₹1,420`), and Frequency.
- **Empty Handlers:** Both "Filters" and "Export" header buttons have empty `onTap: () {}` handlers.

### `lib/screens/history_screen.dart` (Price/Rate History)
- **Static List:** The entire list of prices/rates is hardcoded. It fails to call `ElectricityRepository.getRateHistory()` or `IroningRepository.getPriceHistory()`.
- **Summary Bento:** All summary cards exhibit hardcoded values.
- **UI Logic Broken:** Switching between filter tabs has no effect—the same static list is rendered on both tabs.
- **Missing Action:** The "Add" FAB has an empty handler and no UI flow exists to add new prices or rates.

### `lib/screens/settings_screen.dart`
- **Hardcoded Sync Data:** "Last Synced" timestamp is statically set to `"Today, 10:45 AM"`.
- **Sync Toggle Ineffective:** The cloud sync toggle merely changes local widget state (`_syncEnabled`) and doesn't persist preferences or trigger background events.

### `lib/screens/sync_setup_screen.dart`
- **Unwired Actions:** The "Save Sync Preferences" button does nothing (no PBKDF2 processing, no storage, no initial sync). The "View Sync Logs" button is also an empty stub.
- **Fake Values:** The "Last Synced" time is hardcoded, and the passphrase field presents a mock initial value `"••••••••••••••••"`.

## 3. General Architecture & Missing Systems

### Unimplemented Sync Engine
- The entire sync integration mentioned in `SyncRepository` lacks an engine. There are no HTTP clients in `pubspec.yaml`, no orchestrating service (push/pull), no key derivation logic, no secure storage of credentials, and no UI-side sync triggers or lifecycle observers.
- The external backend (Hono API) is not included or built, and manual sync buttons (like the one in `TopAppBar`) do not work.

### Riverpod Integration Flaws (`lib/providers/app_providers.dart` & Others)
- **Missing Invalidation:** Forms that modify database state do not invalidate Riverpod cache (e.g., `ref.invalidate(ironingBalanceProvider)`). Without this, the UI remains stale.
- **Missing Providers:** Several crucial providers do not exist, including:
  - `ironingActivePriceProvider`
  - `electricityActiveRateProvider`
  - `ironingPriceHistoryProvider`
  - `electricityRateHistoryProvider`
  - A provider or utility to fetch electricity consumption deltas per reading.

### Currency Formatting Issues
- While the utility `formatCurrency()` accurately outputs Indian Rupees (₹), many screens and mock datasets bypass this utility, relying on hardcoded US Dollars ($) or Euros (€).

### Navigation Anomalies
- A "Dev Tools" drawer in `main.dart` should be removed for a production release.
- Routing to detail screens often passes no data, creating dead ends or blank mock interfaces.

## 4. Summary & Next Steps Priority

1. **Wiring Up Core Forms:** Connect all input forms (New Ironing Regular/Custom/Reset, New Electricity Reading) to their respective Drift Repository methods and ensure the correct Riverpod cache invalidation.
2. **Replacing Hardcoded Values:** Go screen-by-screen (especially Home screens, Dashboards, and Detail views) to replace placeholder strings with actual `AsyncValue` outputs from the backend.
3. **Completing Incomplete Features:** Provide forms to set Active Prices and Active Rates, and fix the History/Rates screens to dynamically load from the database. Fix currency symbols by consistently utilizing the `currency_formatter.dart` tool.
4. **Detail Screen Rewrites:** Re-implement `TransactionDetailScreen` and `ReadingDetailScreen` to actively consume their passed object models instead of rendering fake widget trees.
5. **Architectural Improvements:** Establish the Sync logic, enforce strictly correct navigation patterns, and eliminate dev artifacts.
