import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import 'history_screen.dart';
import '../db/database.dart';

class ReadingDetailScreen extends StatelessWidget {
  final ElectricityReading reading;

  const ReadingDetailScreen({super.key, required this.reading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: true,
        avatarUrl: '',
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        'Verified',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${reading.meterValue} kWh',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppTheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Recorded on ${reading.readingDate}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                    border: Border(
                      right: BorderSide(color: AppTheme.surfaceContainer),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Est. Cost',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppTheme.outline,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'N/A', // Compute properly if needed, but for now N/A or stub
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
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
                            'N/A',
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
              _buildContextRow(context, 'Cycle Name', reading.billingCycle.toUpperCase()),
              const SizedBox(height: 16),
              _buildContextRow(context, 'Period', 'N/A'),
              const SizedBox(height: 16),
              _buildContextRow(context, 'Rate Class', 'Residential'),
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
                'Source ID: ${reading.id.toString().length >= 8 ? reading.id.toString().substring(0, 8) : reading.id.toString().toUpperCase()}',
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
            label: 'Previous',
            labelColor: AppTheme.outline,
            value: 'N/A',
            valueColor: AppTheme.primary,
            barColor: AppTheme.outlineVariant,
            barHeight: 12,
            percentage: 0.75,
          ),
          const SizedBox(height: 16),
          _buildBarChartRow(
            context: context,
            label: 'Current',
            labelColor: AppTheme.primary,
            value: 'N/A',
            valueColor: AppTheme.primary,
            barColor: AppTheme.secondary,
            barHeight: 16,
            percentage: 0.85,
            isBold: true,
          ),
          const SizedBox(height: 16),
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
            reading.note?.isNotEmpty == true ? reading.note! : 'No notes recorded for this reading.',
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
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
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
