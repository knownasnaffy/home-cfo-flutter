import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import '../utils/currency_formatter.dart';

import '../db/database.dart';

class TransactionDetailScreen extends StatelessWidget {
  final IroningTransaction? transaction;

  const TransactionDetailScreen({super.key, this.transaction});

  @override
  Widget build(BuildContext context) {
    if (transaction == null) {
      return const Scaffold(
        appBar: TopAppBar(
          showBackButton: true,
          showSync: true,
          title: 'Transaction Details',
        ),
        body: Center(child: Text('Transaction not found')),
      );
    }

    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: true,
        title: 'Transaction Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            _buildHeroStatusCard(context, transaction!),
            const SizedBox(height: 16),
            _buildBentoGrid(context, transaction!),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroStatusCard(BuildContext context, IroningTransaction tx) {
    final amount = tx.type == 'regular'
        ? tx.amountPaid ?? 0.0
        : tx.amount ?? 0.0;
    final isCredit =
        tx.direction == 'credit' ||
        (tx.type == 'regular' && (tx.amountPaid ?? 0) > (tx.totalDue ?? 0));
    final formattedAmount = formatCurrency(amount);
    final amountString = '${isCredit ? '+' : '-'}$formattedAmount';
    final amountColor = isCredit ? AppTheme.secondary : AppTheme.error;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 24,
            spreadRadius: -10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppTheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Symbols.check_circle,
              color: AppTheme.onSecondaryContainer,
              size: 36,
              fill: 1.0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Total Amount',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppTheme.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Text(
            amountString,
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(color: amountColor),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              'ID: ${tx.id.substring(0, 8).toUpperCase()}',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppTheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBentoGrid(BuildContext context, IroningTransaction tx) {
    return Column(
      children: [
        _buildInfoCard(context, tx),
        const SizedBox(height: 16),
        _buildImpactCard(context, tx),
        const SizedBox(height: 16),
        _buildCategoryCard(context, tx),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, IroningTransaction tx) {
    String formattedDate = 'Unknown Date';
    String formattedTime = 'Unknown Time';

    try {
      final date = DateTime.parse(tx.date);
      formattedDate = DateFormat.yMMMMd().format(date);
    } catch (_) {}

    try {
      final createdDate = DateTime.parse(tx.createdAt).toLocal();
      formattedTime = DateFormat.jm().format(createdDate);
    } catch (_) {}

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Symbols.calendar_today,
                color: AppTheme.onPrimaryContainer,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Time & Date',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppTheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Timestamp',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              Text(
                '$formattedDate • $formattedTime',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Billing Cycle',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              Text(
                DateFormat(
                  'MMMM yyyy',
                ).format(DateTime.tryParse(tx.date) ?? DateTime.now()),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactCard(BuildContext context, IroningTransaction tx) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Symbols.account_balance_wallet,
                color: AppTheme.onPrimaryContainer,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Financial Impact',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppTheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              Text(
                'Primary Domestic Ledger',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Balance After',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    formatCurrency(tx.balanceAfter.abs()),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w600,
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

  Widget _buildCategoryCard(BuildContext context, IroningTransaction tx) {
    String categoryName = 'REGULAR SERVICE';
    String title = 'Professional Ironing & Pressing';
    String description =
        'Weekly maintenance of formal attire and domestic linens';
    IconData icon = Symbols.iron;

    if (tx.type == 'custom') {
      categoryName = 'CUSTOM TRANSACTION';
      title = tx.label ?? 'Custom Entry';
      description = tx.direction == 'credit'
          ? 'Credited to account'
          : 'Debited from account';
      icon = Symbols.payments;
    } else if (tx.type == 'reset') {
      categoryName = 'BALANCE RESET';
      title = 'Manual Balance Adjustment';
      description = tx.reason ?? 'Account balance was reset to zero';
      icon = Symbols.restart_alt;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Symbols.label,
                    color: AppTheme.onPrimaryContainer,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Categorization',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppTheme.onSurface),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.tertiaryFixed,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    fontFamily: 'Public Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.onTertiaryFixed,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppTheme.onSurface),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (tx.type == 'regular') ...[
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppTheme.surfaceVariant),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Items Processed',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '${tx.clothCount ?? 0} pieces',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rate Applied',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '${formatCurrency(tx.priceSnapshot ?? 0)}/pc',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
