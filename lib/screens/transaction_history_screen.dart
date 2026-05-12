import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../db/database.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import 'transaction_detail_screen.dart';
import 'package:intl/intl.dart';
import '../utils/currency_formatter.dart';

class TransactionHistoryScreen extends ConsumerWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(allIroningTransactionsProvider);
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true, // Enabling back button since this is a sub-screen
        showSync: true,
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB8lfb-7Rg1ilD4gul0KAQCdgilkIpzQw2y_pEc7xVp2ch4oGhZWET7kTfXj4KF7IyYus4DhhEh_RDGWo_-Ea0dkcgagtehsBhFf-McCNzGuxhh_rBTS0F9ise5AghqbJdY2SbsO-WeGhejqq5KM3iSWJNrLzKDjlDmJu4KJxajdnyU9YSRgUa66Xmri9UOzxwVDKs51rPXnmn1L7K9JHtDYF_DNJNjB7Mip3mEKjvquZv3FBVejDMftAiXCExVRqe2c1DOZCCK9Uk',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildStatsBentoGrid(context),
            const SizedBox(height: 32),
            _buildTransactionLedger(context, transactionsAsync),
            const SizedBox(height: 32),
            _buildInsightsCards(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start, // Changed from end to start for better flex wrapping
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'History',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your domestic maintenance records.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeaderButton(
              context: context,
              icon: Symbols.filter_list,
              label: 'Filters',
              backgroundColor: AppTheme.surfaceContainer,
              foregroundColor: AppTheme.onSurface,
              borderColor: AppTheme.outlineVariant,
            ),
            const SizedBox(width: 8),
            _buildHeaderButton(
              context: context,
              icon: Symbols.download,
              label: 'Export',
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.onPrimary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
    Color? borderColor,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: foregroundColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: foregroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsBentoGrid(BuildContext context) {
    // Note: To match web grid design on mobile, it flows column-wise.
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context: context,
                label: 'Monthly Spend',
                value: '₹284',
                subLabel: '12% vs last month',
                subIcon: Symbols.trending_down,
                subIconColor: AppTheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: Icon(
                        Symbols.iron,
                        size: 120,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IRONING FREQUENCY',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onTertiaryContainer,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Weekly',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Every Tuesday & Friday',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.onTertiaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context: context,
                label: 'Balance Status',
                value: '₹1,420',
                subLabel: 'Operational Reserve',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String label,
    required String value,
    required String subLabel,
    IconData? subIcon,
    Color? subIconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceContainerHighest),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppTheme.primary,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (subIcon != null) ...[
                Icon(subIcon, size: 16, color: subIconColor),
                const SizedBox(width: 4),
              ],
              Text(
                subLabel,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: subIcon != null ? subIconColor : AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionLedger(BuildContext context, AsyncValue<List<IroningTransaction>> transactionsAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Symbols.calendar_month, color: AppTheme.primary),
            const SizedBox(width: 8),
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surfaceContainerHighest),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: transactionsAsync.when(
            data: (transactions) {
              if (transactions.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text('No transactions found.'),
                );
              }

              final groupedTransactions = <String, List<IroningTransaction>>{};
              for (var tx in transactions) {
                try {
                  final date = DateTime.parse(tx.date);
                  final monthYear = DateFormat('MMMM yyyy').format(date);
                  groupedTransactions.putIfAbsent(monthYear, () => []).add(tx);
                } catch (e) {
                  groupedTransactions.putIfAbsent('Unknown Date', () => []).add(tx);
                }
              }

              final widgets = <Widget>[];

              for (var month in groupedTransactions.keys) {
                widgets.add(_buildMonthHeader(context, month));
                final monthTransactions = groupedTransactions[month]!;
                for (int i = 0; i < monthTransactions.length; i++) {
                  final tx = monthTransactions[i];
                  final amount = tx.type == 'regular' ? tx.amountPaid ?? 0.0 : tx.amount ?? 0.0;
                  final isCredit = tx.direction == 'credit' || (tx.type == 'regular' && (tx.amountPaid ?? 0) > (tx.totalDue ?? 0));
                  final formattedAmount = formatCurrency(amount);
                  final amountString = '${isCredit ? '+' : '-'}$formattedAmount';
                  final amountColor = isCredit ? AppTheme.secondary : AppTheme.error;

                  IconData icon;
                  String title;
                  String subtitle;

                  if (tx.type == 'regular') {
                    icon = Symbols.iron;
                    title = 'Standard Ironing Service';
                    subtitle = '${tx.clothCount} Items';
                  } else if (tx.type == 'custom') {
                     icon = Symbols.payments;
                     title = 'Custom Transaction';
                     subtitle = tx.label ?? 'Other';
                  } else if (tx.type == 'reset') {
                     icon = Symbols.restart_alt;
                     title = 'Balance Reset';
                     subtitle = 'Account adjustment';
                  } else {
                     icon = Symbols.receipt_long;
                     title = 'Transaction';
                     subtitle = '';
                  }

                  String dateStr = tx.date;
                  try {
                    dateStr = DateFormat('MMM d, yyyy').format(DateTime.parse(tx.date));
                  } catch (e) {}

                  widgets.add(_buildLedgerItem(
                    context: context,
                    icon: icon,
                    title: title,
                    subtitle: subtitle,
                    amount: amountString,
                    amountColor: amountColor,
                    date: dateStr,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TransactionDetailScreen(transaction: tx))),
                  ));

                  if (i < monthTransactions.length - 1) {
                    widgets.add(const Divider(height: 1, color: AppTheme.surfaceContainerHigh));
                  }
                }
              }

              return Column(children: widgets);
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text('Error: $err'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthHeader(BuildContext context, String month) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: AppTheme.surfaceContainerHighest)),
      ),
      child: Text(
        month,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppTheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildLedgerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
    required String date,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: AppTheme.primaryContainer),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            subtitle,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: amountColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInsightsCards(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surfaceContainerHighest),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 160,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  image: DecorationImage(
                    image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCS1X8q6zwj_dOYssplVNki2YrZROge5M9JyfKGOHRHNs9nC-B1XodvSMD9P3hhbDFYmUldzRoVTETqEQZDV73335JyCJ-8ODYeGUBJcfqUgCdwzy1IA-zFAjIAFXgvji9L_2JNauR-QL3Qjh7tp_aF3PDkBVuEKyXxZ2Hl6XuX9z3FVnLPkDaDP-IQdlR8-mhJp6NdHmuKrdRtpHcvstaNWENyiyHz8d28Y8qlt4T0KbchAFB3_obbYFj_n_amzK1sy39HCPMSnMM'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Efficiency Insight',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'By batching 20+ items, you saved an average of 15% on service costs this quarter compared to smaller weekly loads.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryFixed,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        'View Full Report',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppTheme.secondaryFixedDim,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppTheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Symbols.security, size: 48, color: AppTheme.tertiaryFixedDim),
              const SizedBox(height: 16),
              Text(
                'Secure Ledger',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'All transactions are digitally signed and archived for your annual domestic review.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.tertiaryFixedDim,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
