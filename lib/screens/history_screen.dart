import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import '../providers/app_providers.dart';
import '../providers/db_provider.dart';
import '../db/database.dart';
import '../utils/currency_formatter.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true, // Ensuring it has a back button since it's reachable via Settings / Dashboard
        showSync: true,
        avatarUrl: '',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildBentoGrid(context),
            const SizedBox(height: 24),
            _buildFilterTabs(context),
            const SizedBox(height: 16),
            _buildPriceHistoryList(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRateDialog,
        backgroundColor: AppTheme.primaryContainer,
        foregroundColor: Colors.white,
        child: const Icon(Symbols.add, size: 32),
      ),
    );
  }

  void _showAddRateDialog() {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String rateStr = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(_selectedTabIndex == 0 ? 'Add Electricity Rate' : 'Add Ironing Fee'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: date,
                    decoration: const InputDecoration(labelText: 'Effective From (YYYY-MM-DD)'),
                    onChanged: (val) => date = val,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: _selectedTabIndex == 0 ? 'Rate per kWh' : 'Price per garment',
                    ),
                    onChanged: (val) => rateStr = val,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final amount = double.tryParse(rateStr);
                    if (amount == null) return;

                    if (_selectedTabIndex == 0) {
                      final rate = ElectricityRatesCompanion.insert(
                        ratePerUnit: amount,
                        effectiveFrom: date,
                        createdAt: DateTime.now().toUtc().toIso8601String(),
                        updatedAt: DateTime.now().toUtc().toIso8601String(),
                        id: '', // Will be assigned by repo
                      );
                      await ref.read(electricityRepositoryProvider).addRate(rate);
                      ref.invalidate(electricityActiveRateProvider);
                      ref.invalidate(electricityRateHistoryProvider);
                    } else {
                      final price = IroningPricesCompanion.insert(
                        pricePerCloth: amount,
                        effectiveFrom: date,
                        createdAt: DateTime.now().toUtc().toIso8601String(),
                        updatedAt: DateTime.now().toUtc().toIso8601String(),
                        id: '', // Will be assigned by repo
                      );
                      await ref.read(ironingRepositoryProvider).addPrice(price);
                      ref.invalidate(ironingActivePriceProvider);
                      ref.invalidate(ironingPriceHistoryProvider);
                    }
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          }
        );
      }
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UTILITY MANAGEMENT',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onPrimaryContainer,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'History',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppTheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBentoGrid(BuildContext context) {
    final nowString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final activeRateAsync = ref.watch(electricityActiveRateProvider(nowString));
    final activePriceAsync = ref.watch(ironingActivePriceProvider(nowString));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: activeRateAsync.when(
                data: (rate) => _buildBentoCard(
                  context: context,
                  icon: Symbols.bolt,
                  iconColor: AppTheme.secondary,
                  badgeText: 'Active',
                  badgeBgColor: AppTheme.secondaryContainer,
                  badgeTextColor: AppTheme.secondary,
                  title: 'Electricity Rate',
                  value: rate != null ? formatCurrency(rate.ratePerUnit) : 'N/A',
                  valueSuffix: '/kWh',
                  height: 128,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Text('Error'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: activePriceAsync.when(
                data: (price) => _buildBentoCard(
                  context: context,
                  icon: Symbols.iron,
                  iconColor: AppTheme.primary,
                  badgeText: 'Active',
                  badgeBgColor: AppTheme.surfaceContainerHighest,
                  badgeTextColor: AppTheme.onSurfaceVariant,
                  title: 'Ironing Fee',
                  value: price != null ? formatCurrency(price.pricePerCloth) : 'N/A',
                  valueSuffix: '/item',
                  height: 128,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Text('Error'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBentoCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String badgeText,
    required Color badgeBgColor,
    required Color badgeTextColor,
    required String title,
    required String value,
    required String valueSuffix,
    required double height,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outlineVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  badgeText,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: badgeTextColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
                    value,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppTheme.onSurface,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    valueSuffix,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      fontWeight: FontWeight.w400,
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

  Widget _buildFilterTabs(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.outlineVariant)),
      ),
      child: Row(
        children: [
          _buildTab(context, title: 'Electricity Rates', index: 0),
          const SizedBox(width: 16),
          _buildTab(context, title: 'Service Fees', index: 1),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, {required String title, required int index}) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppTheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isSelected ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildPriceHistoryList(BuildContext context) {
    if (_selectedTabIndex == 0) {
      final historyAsync = ref.watch(electricityRateHistoryProvider);
      return historyAsync.when(
        data: (history) {
          if (history.isEmpty) return const Text('No rates found.');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: history.map((rate) {
              final isActive = history.first == rate; // Simple active check assuming descending order
              return Column(
                children: [
                  _buildHistoryItem(
                    context: context,
                    icon: Symbols.bolt,
                    iconBgColor: isActive ? AppTheme.secondaryContainer : AppTheme.surfaceContainer,
                    iconColor: isActive ? AppTheme.secondary : AppTheme.onSurfaceVariant,
                    iconFilled: isActive,
                    title: 'Standard Residential',
                    isActive: isActive,
                    dateRange: 'Effective: ${rate.effectiveFrom}',
                    price: formatCurrency(rate.ratePerUnit),
                    priceSuffix: 'per kWh',
                    isDimmed: !isActive,
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
      );
    } else {
      final historyAsync = ref.watch(ironingPriceHistoryProvider);
      return historyAsync.when(
        data: (history) {
          if (history.isEmpty) return const Text('No fees found.');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: history.map((price) {
              final isActive = history.first == price;
              return Column(
                children: [
                  _buildHistoryItem(
                    context: context,
                    icon: Symbols.iron,
                    iconBgColor: isActive ? AppTheme.surfaceContainerHigh : AppTheme.surfaceContainer,
                    iconColor: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
                    iconFilled: isActive,
                    title: 'Standard Pressing',
                    isActive: isActive,
                    dateRange: 'Effective: ${price.effectiveFrom}',
                    price: formatCurrency(price.pricePerCloth),
                    priceSuffix: 'per garment',
                    isDimmed: !isActive,
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
      );
    }
  }

  Widget _buildHistoryItem({
    required BuildContext context,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    bool iconFilled = false,
    required String title,
    bool isActive = false,
    required String dateRange,
    required String price,
    required String priceSuffix,
    bool isDimmed = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
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
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    fill: iconFilled ? 1.0 : 0.0,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppTheme.onSurface,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isActive) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.secondary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'ACTIVE',
                                style: TextStyle(
                                  fontFamily: 'Public Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateRange,
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
          Opacity(
            opacity: isDimmed ? 0.7 : 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppTheme.onSurface,
                    fontSize: 28,
                  ),
                ),
                Text(
                  priceSuffix,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
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
