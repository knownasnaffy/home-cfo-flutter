import 'package:intl/intl.dart';

String formatCurrency(num amount) {
  // Use 'INR' as the currency symbol (rupee)
  // According to the requirement, decimals shouldn't be included as they are multiples of a rupee.
  return NumberFormat.currency(name: 'INR', symbol: '₹', decimalDigits: 0).format(amount);
}
