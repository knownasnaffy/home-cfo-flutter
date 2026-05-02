import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';

class ResetTransactionScreen extends StatelessWidget {
  const ResetTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: true,
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBcDKg-JdGYEI34DchY3RRmGEzck7_YlDnihi3NUsXLmYVWwab9-YO9MFFi_OW1I-u3j4okdSZ16dSD9OhgDwq3AP_5-9i5GCbazq5VOaFnFGEyLhsaoLQ8BEKO84ztFk-a4l3exxzJm32UdR8iN6Y8Sntc2BCy_ofvtBTLoPVQFvPXghgVl1nvw4zzvouyOeVdfoz5hCTaZSmXHrJQymF2y4lz7iKa4OEAqBERqlMtghp3nBxVGBIaEZAOnDYamLRPdo7ksH3H0kQ',
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '\$',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.onSurface,
                  fontSize: 28,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '142.50',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.onSurface,
                  fontSize: 28,
                ),
              ),
            ],
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
                    onPressed: () {},
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
                              text: 'This action will permanently clear the balance to \$0.00. This cannot be undone.',
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
            onPressed: () {},
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
            onPressed: () {},
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
