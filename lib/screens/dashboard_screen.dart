import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import 'new_reading_screen.dart';
import 'new_ironing_transaction_screen.dart';
import 'transaction_history_screen.dart';
import 'ironing_home_screen.dart';
import 'electricity_home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: false,
        showSync: false,
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB8lfb-7Rg1ilD4gul0KAQCdgilkIpzQw2y_pEc7xVp2ch4oGhZWET7kTfXj4KF7IyYus4DhhEh_RDGWo_-Ea0dkcgagtehsBhFf-McCNzGuxhh_rBTS0F9ise5AghqbJdY2SbsO-WeGhejqq5KM3iSWJNrLzKDjlDmJu4KJxajdnyU9YSRgUa66Xmri9UOzxwVDKs51rPXnmn1L7K9JHtDYF_DNJNjB7Mip3mEKjvquZv3FBVejDMftAiXCExVRqe2c1DOZCCK9Uk',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildQuickActions(context),
            const SizedBox(height: 32),
            _buildMainModules(context),
            const SizedBox(height: 32),
            _buildRecentLedger(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Household Balance',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: AppTheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '\$2,415.50',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Updated Today',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.onTertiaryContainer,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1,
      children: [
        _buildActionCard(
          context: context,
          icon: Symbols.add_circle,
          label: 'Add Reading',
          backgroundColor: AppTheme.primary,
          foregroundColor: AppTheme.onPrimary,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewReadingScreen())),
        ),
        _buildActionCard(
          context: context,
          icon: Symbols.iron,
          label: 'Log Ironing',
          backgroundColor: AppTheme.secondary,
          foregroundColor: AppTheme.onSecondary,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewIroningTransactionScreen())),
        ),
        _buildActionCard(
          context: context,
          icon: Symbols.receipt_long,
          label: 'History',
          backgroundColor: AppTheme.surfaceContainerLowest,
          foregroundColor: AppTheme.onSurface,
          borderColor: AppTheme.surfaceVariant,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionHistoryScreen())),
        ),
        _buildActionCard(
          context: context,
          icon: Symbols.analytics,
          label: 'Reports',
          backgroundColor: AppTheme.surfaceContainerLowest,
          foregroundColor: AppTheme.onSurface,
          borderColor: AppTheme.surfaceVariant,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionHistoryScreen())),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null ? Border.all(color: borderColor) : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: foregroundColor),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: foregroundColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainModules(BuildContext context) {
    return Column(
      children: [
        _buildModuleCard(
          context: context,
          icon: Symbols.payments,
          iconBg: AppTheme.secondaryContainer,
          iconColor: AppTheme.onSecondaryContainer,
          title: 'Ironing Service',
          valueLabel: 'Current Balance',
          value: '-\$540.00',
          valueColor: AppTheme.error,
          footerLabel: 'Last Transaction',
          footerValue: 'Oct 24, 2023',
          actionText: 'View',
          onActionTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const IroningHomeScreen())),
        ),
        const SizedBox(height: 24),
        _buildModuleCard(
          context: context,
          icon: Symbols.bolt,
          iconBg: AppTheme.tertiaryFixed,
          iconColor: AppTheme.onTertiaryFixed,
          title: 'Electricity',
          isGridValue: true,
          gridVal1Label: 'Meter Reading',
          gridVal1: '12,482',
          gridVal1Suffix: 'kWh',
          gridVal1Color: AppTheme.primary,
          gridVal2Label: 'Consumption',
          gridVal2: '+342',
          gridVal2Suffix: 'kWh',
          gridVal2Color: AppTheme.onSecondaryContainer,
          footerLabel: 'Last Reading Date',
          footerValue: 'Nov 01, 2023',
          actionText: 'History',
          onActionTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ElectricityHomeScreen())),
        ),
      ],
    );
  }

  Widget _buildModuleCard({
    required BuildContext context,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    String? valueLabel,
    String? value,
    Color? valueColor,
    bool isGridValue = false,
    String? gridVal1Label,
    String? gridVal1,
    String? gridVal1Suffix,
    Color? gridVal1Color,
    String? gridVal2Label,
    String? gridVal2,
    String? gridVal2Suffix,
    Color? gridVal2Color,
    required String footerLabel,
    required String footerValue,
    required String actionText,
    required VoidCallback onActionTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              ),
              const Icon(Symbols.more_vert, color: AppTheme.outlineVariant),
            ],
          ),
          const SizedBox(height: 32),
          if (!isGridValue)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valueLabel!.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value!,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: valueColor,
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gridVal1Label!.toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppTheme.onTertiaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            gridVal1!,
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: gridVal1Color,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            gridVal1Suffix!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gridVal2Label!.toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppTheme.onTertiaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            gridVal2!,
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: gridVal2Color,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            gridVal2Suffix!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppTheme.surfaceVariant)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      footerLabel,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppTheme.onTertiaryContainer,
                      ),
                    ),
                    Text(
                      footerValue,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: onActionTap,
                  child: Row(
                    children: [
                      Text(
                        actionText,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppTheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Symbols.chevron_right, color: AppTheme.secondary, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentLedger(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionHistoryScreen())),
              child: Text(
                'See All',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildLedgerRow(
                context: context,
                icon: Symbols.local_laundry_service,
                title: 'Weekly Ironing Service',
                subtitle: 'Service Fee',
                amount: '-\$45.00',
                amountColor: AppTheme.error,
                date: 'Yesterday',
              ),
              const Divider(height: 1, color: AppTheme.surfaceVariant),
              _buildLedgerRow(
                context: context,
                icon: Symbols.receipt,
                title: 'Monthly Settlement',
                subtitle: 'Bank Transfer',
                amount: '+\$1,200.00',
                amountColor: AppTheme.onSecondaryContainer,
                date: 'Oct 28',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLedgerRow({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
    required String date,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppTheme.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppTheme.outline),
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
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: amountColor,
                  fontSize: 18,
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
    );
  }
}
