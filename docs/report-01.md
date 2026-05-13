# App Integration and Inconsistencies Report

## 1. Currency Formatting Inconsistencies
The application is supposed to use Rupee (₹) as the currency. While `lib/utils/currency_formatter.dart` is correctly configured to use INR/₹, there are several hardcoded US Dollar ($) instances in the UI that need to be replaced.

**Files with hardcoded `$` symbols:**
* `lib/screens/transaction_detail_screen.dart`:
  * Line 80: Hardcoded `-\$45.00`
  * Line 254: Hardcoded `\$12,450.80`
  * These should use the transaction amount formatted via `formatCurrency()`.

## 2. Hardcoded UI Elements and Mock Data
The `TransactionDetailScreen` contains significant amounts of mock data and hardcoded UI elements instead of displaying actual transaction details.

* **Transaction Details Mismatches (`lib/screens/transaction_detail_screen.dart`):**
  * ID is hardcoded to `'ID: TXN-9921-XF8'`. It should use the actual transaction ID.
  * Categories and text sections such as `'HOUSEHOLD SERVICES'` and `'Professional Ironing & Pressing'` are hardcoded.
  * A dummy mock image URL is used for `'Supporting Documents'` which seems entirely out of scope for the application logic defined in `docs/backend.md`.
  * The `'Modify Transaction Record'` button is hardcoded, which violates the immutability rules of the app as defined in `docs/backend.md` ("Ironing transactions are immutable. No edit or delete UI."). This button should be removed or completely reimagined based on allowed business logic (e.g. creating an offsetting custom transaction).

## 3. General Consistency Review
* `TransactionDetailScreen` needs a complete rewrite to populate its widgets from the passed `IroningTransaction? transaction` parameter. Right now it completely ignores this parameter.
* The application should adhere strictly to the "never recompute balance from transaction history" rule from `backend.md`.
* Ensure that soft deletes (`deleted_at IS NULL`) are being properly respected throughout all queries.
