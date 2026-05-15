import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import '../utils/currency_formatter.dart';
import 'new_reading_screen.dart';
import 'reading_detail_screen.dart';
import 'history_screen.dart';
import '../providers/app_providers.dart';

class ElectricityHomeScreen extends ConsumerWidget {
  const ElectricityHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readingsAsync = ref.watch(electricityReadingsProvider);

    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: false,
        showSync: false,
        avatarUrl: '',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLatestReadingSection(context, readingsAsync),
            const SizedBox(height: 16),
            _buildAnalyticsVisual(context),
            const SizedBox(height: 24),
            _buildPastReadingsList(context, readingsAsync),
            const SizedBox(height: 24),
            _buildStewardshipTipCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestReadingSection(BuildContext context, AsyncValue<dynamic> readingsAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest Meter Reading',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surfaceContainerHigh),
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
              readingsAsync.when(
                data: (readings) {
                  if (readings.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('No readings yet.'),
                        const SizedBox(height: 16),
                        _buildAddReadingButton(context),
                      ],
                    );
                  }
                  final latestReading = readings.last;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'READING DATE',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppTheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                latestReading.readingDate,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppTheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Symbols.bolt, color: AppTheme.primaryContainer, size: 32, fill: 1.0),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CURRENT VALUE',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${latestReading.meterValue}',
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: AppTheme.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'kWh',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.only(top: 16),
                        decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: AppTheme.surfaceContainerHigh)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Symbols.trending_down, size: 14, color: AppTheme.onSecondaryContainer),
                                const SizedBox(width: 8),
                                Text(
                                  '-12% vs last month',
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppTheme.onSecondaryContainer,
                                  ),
                                ),
                              ],
                            ),
                            _buildAddReadingButton(context),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => const Text('Error loading latest reading'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddReadingButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewReadingScreen())),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryContainer,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        'Add New Reading',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildAnalyticsVisual(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryContainer.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.secondaryContainer.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AVG DAILY',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '14.2 kWh',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.onSecondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.tertiaryFixed,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EST. BILL',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.onTertiaryFixedVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  formatCurrency(142.50),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.onTertiaryFixed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPastReadingsList(BuildContext context, AsyncValue<dynamic> readingsAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Past Readings',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.onSurface,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Symbols.chevron_right, size: 16, color: AppTheme.onPrimaryContainer),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.surfaceContainerHigh),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: readingsAsync.when(
            data: (readings) {
              if (readings.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No past readings.'),
                );
              }
              return Column(
                children: List.generate(readings.length, (index) {
                  final r = readings[index];
                  // Delta from consecutive readings
                  String deltaText = '—';
                  if (index > 0) {
                    final prev = readings[index - 1];
                    final delta = r.meterValue - prev.meterValue;
                    deltaText = '+${delta.toStringAsFixed(1)}';
                  }

                  return Column(
                    children: [
                      _buildReadingRow(
                        context: context,
                        date: r.readingDate,
                        reading: '${r.meterValue} kWh',
                        delta: deltaText,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReadingDetailScreen(reading: r))),
                      ),
                      if (r != readings.last) const Divider(height: 1, color: AppTheme.surfaceContainerHigh),
                    ],
                  );
                }).reversed.toList(),
              );
            },
            loading: () => const Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()),
            error: (err, stack) => const Padding(padding: EdgeInsets.all(16), child: Text('Error loading readings')),
          ),
        ),
      ],
    );
  }

  Widget _buildReadingRow({
    required BuildContext context,
    required String date,
    required String reading,
    required String delta,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reading,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    delta,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'kWh delta',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
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

  Widget _buildStewardshipTipCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 128,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            top: -32,
            right: 32,
            child: Icon(
              Symbols.lightbulb,
              size: 120,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'STEWARDSHIP TIP',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.secondaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Peak hours start at 6PM. Use heavy appliances late at night to save up to 15%.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
