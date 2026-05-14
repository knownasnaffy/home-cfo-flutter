import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:drift/drift.dart' as drift;
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import '../providers/app_providers.dart';
import '../utils/currency_formatter.dart';
import '../db/database.dart';
import '../providers/db_provider.dart';

class ResetTransactionScreen extends ConsumerStatefulWidget {
  const ResetTransactionScreen({super.key});

  @override
  ConsumerState<ResetTransactionScreen> createState() => _ResetTransactionScreenState();
}

class _ResetTransactionScreenState extends ConsumerState<ResetTransactionScreen> {
  String _reason = '';
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: true,
        avatarUrl: '',
        title: 'Reset Transaction',
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - 48), // minus padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _buildBalanceSummaryCard(context),
                      const SizedBox(height: 24),
                      _buildVisualConfirmationSection(context),
                    ],
                  ),
                  _buildActions(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBalanceSummaryCard(BuildContext context) {
    final balanceAsync = ref.watch(ironingBalanceProvider);

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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Ironing Balance',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppTheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          balanceAsync.when(
            data: (balance) {
              final formattedBalance = formatCurrency(balance.abs());
              Color balanceColor = AppTheme.onSurface;
              if (balance > 0) {
                balanceColor = AppTheme.secondary;
              } else if (balance < 0) {
                balanceColor = AppTheme.error;
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    balance < 0 ? '- $formattedBalance' : formattedBalance,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: balanceColor,
                      fontSize: 28,
                    ),
                  ),
                ],
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (e, st) => Text('Error: $e'),
          ),
          const SizedBox(height: 4),
          Text(
            'This balance represents all unbilled ironing services currently logged in the system.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualConfirmationSection(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surfaceVariant),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppTheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Symbols.check_circle,
                  color: AppTheme.onSecondaryContainer,
                  fill: 1.0,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verified Identity',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.onSurface,
                    ),
                  ),
                  Text(
                    'Administrator access confirmed',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset Reason (Optional)',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _reasonController,
                onChanged: (val) {
                  setState(() { _reason = val; });
                },
                maxLines: 4,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.surfaceBright,
                  hintText: 'E.g., Client paid in cash, correction of error...',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.outlineVariant,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppTheme.surfaceVariant, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppTheme.primaryContainer, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  suffixIcon: IconButton(
                    icon: const Icon(Symbols.close, size: 14, color: AppTheme.outlineVariant),
                    onPressed: () {
                      _reasonController.clear();
                      setState(() { _reason = ''; });
                    },
                  ),
                  suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.errorContainer.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.errorContainer.withValues(alpha: 0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Symbols.warning, color: AppTheme.error),
                    const SizedBox(width: 16),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.onErrorContainer,
                          ),
                          children: const [
                            TextSpan(
                              text: 'Warning: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'This action will permanently clear the balance to ₹0. This cannot be undone.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () async {
              final repo = ref.read(ironingRepositoryProvider);
              await repo.addTransaction(IroningTransactionsCompanion(
                date: drift.Value(DateTime.now().toUtc().toIso8601String().substring(0, 10)),
                type: const drift.Value('reset'),
                reason: drift.Value(_reason.isEmpty ? null : _reason),
              ));
              ref.invalidate(ironingBalanceProvider);
              ref.invalidate(allIroningTransactionsProvider);
              ref.invalidate(recentIroningTransactionsProvider);
              if (context.mounted) Navigator.pop(context);
            },
            icon: const Icon(Symbols.history_edu, color: AppTheme.onPrimary),
            label: const Text('Confirm Balance Reset'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.onSurfaceVariant,
              side: const BorderSide(color: AppTheme.outlineVariant),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel Action'),
          ),
        ),
      ],
    );
  }
}
