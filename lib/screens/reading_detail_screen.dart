import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';

class ReadingDetailScreen extends StatelessWidget {
  const ReadingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: true,
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBCh74b7eJgbMojTfNgDXQUPTd85YVl_ZrLPtBab2Rt1NZ8jfBWQJI8gXtwV4BBJDwnnZOm-0yjN0VVgqNBrqGexpPma6AmeDioLX4yhhU2Xzp-KFgwEJBOm7iD-hKyi7u3B7crP8lYhneFDchWDE6JEDZsP6_1hG1cwLAigiMmHIZPVT_WqEeYOg23nEMKr1S_1xwY423kDTiuvGnEmVXJkFSDNpdaZDpeujHZjxkTjZrcGx3JyLN_B2Qgqf1yNmtqISFJ7A6HerI',
        title: 'Reading Detail',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            _buildHeroCard(context),
            const SizedBox(height: 16),
            _buildDetailGrid(context),
            const SizedBox(height: 24),
            _buildConsumptionComparison(context),
            const SizedBox(height: 24),
            _buildNotesSection(context),
            const SizedBox(height: 24),
            _buildHistoryButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceContainer),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            color: AppTheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MAIN ELECTRICITY METER',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppTheme.onPrimaryContainer,
                        letterSpacing: 2.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.secondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'VERIFIED',
                        style: TextStyle(
                          fontFamily: 'Public Sans',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '42,891.50',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'kWh',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Recorded on Oct 24, 2023 • 09:42 AM',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.onPrimaryContainer.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: AppTheme.surfaceContainer)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Net Consumption',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppTheme.outline,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '452.20',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith( // 2xl is 24px usually
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'kWh',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith( // roughly 10-11px
                              color: AppTheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'vs Prior Reading',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppTheme.outline,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Symbols.trending_up, color: AppTheme.error, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '+12.4%',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.error,
                              fontWeight: FontWeight.w700,
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
        ],
      ),
    );
  }

  Widget _buildDetailGrid(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surfaceContainer),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Billing Context',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              _buildContextRow(context, 'Cycle Name', 'Q4 Autumn Fiscal'),
              const SizedBox(height: 16),
              _buildContextRow(context, 'Period', 'Sep 25 - Oct 24'),
              const SizedBox(height: 16),
              _buildContextRow(context, 'Rate Class', 'Residential Peak-Saver'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surfaceContainer),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Symbols.qr_code_scanner, color: AppTheme.secondary, size: 36),
              const SizedBox(height: 8),
              Text(
                'Manual Entry',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.secondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Source ID: CFO-9921',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.outlineVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContextRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.outline,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildConsumptionComparison(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceContainer),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consumption Comparison',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          _buildBarChartRow(
            context: context,
            label: 'Previous (Sep)',
            labelColor: AppTheme.outline,
            value: '402.15 kWh',
            valueColor: AppTheme.primary,
            barColor: AppTheme.outlineVariant,
            barHeight: 12,
            percentage: 0.75,
          ),
          const SizedBox(height: 16),
          _buildBarChartRow(
            context: context,
            label: 'Current (Oct)',
            labelColor: AppTheme.primary,
            value: '452.20 kWh',
            valueColor: AppTheme.primary,
            barColor: AppTheme.secondary,
            barHeight: 16,
            percentage: 0.85,
            isBold: true,
          ),
          const SizedBox(height: 16),
          Text(
            'The higher consumption correlates with the recorded temperature drop of 8°C in this billing period.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.outline,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChartRow({
    required BuildContext context,
    required String label,
    required Color labelColor,
    required String value,
    required Color valueColor,
    required Color barColor,
    required double barHeight,
    required double percentage,
    bool isBold = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: labelColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: valueColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: barHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(9999),
          ),
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceContainer),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Symbols.notes, color: AppTheme.outline, size: 24),
              const SizedBox(width: 4),
              Text(
                'Steward Notes',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Reading taken manually. Meter face was clear of obstruction. No signs of tampering or damage to the seal. Compared value against smart hub app, variance within expected 0.5% margin. Note: Outdoor heating system activated on Oct 15.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Symbols.history, color: AppTheme.outline),
        label: const Text('View Meter History'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.outline,
          side: const BorderSide(color: AppTheme.outlineVariant),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
