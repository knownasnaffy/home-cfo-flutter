import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import 'new_ironing_transaction_summary_screen.dart';
import 'new_ironing_transaction_screen.dart';
import 'reset_transaction_screen.dart';
import 'transaction_history_screen.dart';
import 'transaction_detail_screen.dart';

class IroningHomeScreen extends StatelessWidget {
  const IroningHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: false,
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB8lfb-7Rg1ilD4gul0KAQCdgilkIpzQw2y_pEc7xVp2ch4oGhZWET7kTfXj4KF7IyYus4DhhEh_RDGWo_-Ea0dkcgagtehsBhFf-McCNzGuxhh_rBTS0F9ise5AghqbJdY2SbsO-WeGhejqq5KM3iSWJNrLzKDjlDmJu4KJxajdnyU9YSRgUa66Xmri9UOzxwVDKs51rPXnmn1L7K9JHtDYF_DNJNjB7Mip3mEKjvquZv3FBVejDMftAiXCExVRqe2c1DOZCCK9Uk',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceSection(context),
            const SizedBox(height: 32),
            _buildQuickActionsGrid(context),
            const SizedBox(height: 32),
            _buildRecentActivity(context),
            const SizedBox(height: 24),
            _buildStatsBento(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewIroningTransactionScreen())),
        backgroundColor: AppTheme.primaryContainer,
        foregroundColor: Colors.white,
        child: const Icon(Symbols.add, size: 32),
      ),
    );
  }

  Widget _buildBalanceSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -16,
            top: -16,
            child: Icon(
              Symbols.payments,
              size: 120,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OUTSTANDING BALANCE',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '₹1,450.00',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Pending',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.secondaryFixedDim,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Batch',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          '42 Items',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Payment',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          '12 Oct',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage Ironing',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _buildActionItem(
              context: context,
              icon: Symbols.check_box,
              iconBg: AppTheme.secondaryContainer,
              iconColor: AppTheme.onSecondaryContainer,
              title: 'New Regular Transaction',
              subtitle: 'Standard 15 clothes batch',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewIroningTransactionSummaryScreen())),
            ),
            const SizedBox(height: 8),
            _buildActionItem(
              context: context,
              icon: Symbols.edit_square,
              iconBg: AppTheme.primaryFixed,
              iconColor: AppTheme.onPrimaryFixed,
              title: 'New Custom Transaction',
              subtitle: 'Manual count entry',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewIroningTransactionScreen())),
            ),
            const SizedBox(height: 8),
            _buildActionItem(
              context: context,
              icon: Symbols.restart_alt,
              iconBg: AppTheme.errorContainer,
              iconColor: AppTheme.onErrorContainer,
              title: 'New Reset Transaction',
              subtitle: 'Clear outstanding balance',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResetTransactionScreen())),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required BuildContext context,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.surfaceVariant),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: iconColor, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppTheme.onSurface,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Symbols.chevron_right, color: AppTheme.outline),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.onSurface,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionHistoryScreen())),
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.secondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surfaceVariant),
            boxShadow: const [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActivityRow(
                context: context,
                icon: Symbols.local_laundry_service,
                title: 'Regular: 15 cloths',
                subtitle: 'Yesterday, 6:45 PM',
                amount: '-₹150.00',
                amountColor: AppTheme.error,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionDetailScreen())),
              ),
              const Divider(height: 1, color: AppTheme.surfaceVariant),
              _buildActivityRow(
                context: context,
                icon: Symbols.payments,
                title: 'Paid: DHBVN',
                subtitle: '18 Oct, 11:20 AM',
                amount: '+₹500.00',
                amountColor: AppTheme.secondary,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionDetailScreen())),
              ),
              const Divider(height: 1, color: AppTheme.surfaceVariant),
              _buildActivityRow(
                context: context,
                icon: Symbols.local_laundry_service,
                title: 'Custom: 22 cloths',
                subtitle: '15 Oct, 9:15 AM',
                amount: '-₹220.00',
                amountColor: AppTheme.error,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionDetailScreen())),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityRow({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppTheme.surfaceContainerLow,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppTheme.onSurfaceVariant, size: 24),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.onSurface,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              amount,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsBento(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.tertiaryFixed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MONTHLY COUNT',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.onTertiaryFixedVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '128',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppTheme.onTertiaryFixed,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Items',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppTheme.onTertiaryFixedVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryFixed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AVG. PRICE/PC',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.onSecondaryFixedVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '₹10',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppTheme.onSecondaryFixed,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Fixed',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppTheme.onSecondaryFixedVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
