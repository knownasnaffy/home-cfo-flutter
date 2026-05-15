import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;

import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import '../providers/app_providers.dart';
import '../db/database.dart';
import '../providers/db_provider.dart';
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
    final rateHistoryAsync = ref.watch(electricityRateHistoryProvider);
    final priceHistoryAsync = ref.watch(ironingPriceHistoryProvider);
    final rateAsync = ref.watch(electricityActiveRateProvider(DateFormat('yyyy-MM-dd').format(DateTime.now())));
    final priceAsync = ref.watch(ironingActivePriceProvider(DateFormat('yyyy-MM-dd').format(DateTime.now())));

    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true,
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
            _buildBentoGrid(context, rateAsync, priceAsync),
            const SizedBox(height: 24),
            _buildFilterTabs(context),
            const SizedBox(height: 16),
            _buildPriceHistoryList(context, rateHistoryAsync, priceHistoryAsync),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddForm,
        backgroundColor: AppTheme.primaryContainer,
        foregroundColor: Colors.white,
        child: const Icon(Symbols.add, size: 32),
      ),
    );
  }

  void _showAddForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddPriceForm(isIroning: _selectedTabIndex == 1),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pricing History',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Log of historical rates and service fees.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBentoGrid(BuildContext context, AsyncValue<ElectricityRate?> rateAsync, AsyncValue<IroningPrice?> priceAsync) {
    if (_selectedTabIndex == 0) {
      return rateAsync.when(
        data: (rate) {
          final val = rate != null ? formatCurrency(rate.ratePerUnit) : 'N/A';
          final dateStr = rate != null ? DateFormat('MMM dd, yyyy').format(DateTime.parse(rate.effectiveFrom)) : 'N/A';
          return _buildBentoRow(context, val, '/ kWh', dateStr);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
      );
    } else {
      return priceAsync.when(
        data: (price) {
          final val = price != null ? formatCurrency(price.pricePerCloth) : 'N/A';
          final dateStr = price != null ? DateFormat('MMM dd, yyyy').format(DateTime.parse(price.effectiveFrom)) : 'N/A';
          return _buildBentoRow(context, val, '/ pc', dateStr);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
      );
    }
  }

  Widget _buildBentoRow(BuildContext context, String value, String suffix, String lastChangeDate) {
    return Row(
      children: [
        Expanded(
          child: _buildBentoCard(
            context: context,
            title: 'Active Rate',
            value: value,
            valueSuffix: suffix,
            icon: Symbols.check_circle,
            iconColor: AppTheme.secondary,
            badgeText: 'CURRENT',
            badgeBgColor: AppTheme.secondaryFixed,
            badgeTextColor: AppTheme.onSecondaryFixedVariant,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildBentoCard(
            context: context,
            title: 'Last Change',
            value: lastChangeDate.split(',').first,
            valueSuffix: lastChangeDate.contains(',') ? ',${lastChangeDate.split(',').last}' : '',
            icon: Symbols.update,
            iconColor: AppTheme.primary,
            badgeText: 'RECENT',
            badgeBgColor: AppTheme.surfaceContainerHigh,
            badgeTextColor: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildBentoCard({
    required BuildContext context,
    required String title,
    required String value,
    required String valueSuffix,
    required IconData icon,
    required Color iconColor,
    required String badgeText,
    required Color badgeBgColor,
    required Color badgeTextColor,
  }) {
    return Container(
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

  Widget _buildPriceHistoryList(BuildContext context, AsyncValue<List<ElectricityRate>> rateHistoryAsync, AsyncValue<List<IroningPrice>> priceHistoryAsync) {
    if (_selectedTabIndex == 0) {
      return rateHistoryAsync.when(
        data: (rates) {
          if (rates.isEmpty) {
             return const Padding(
               padding: EdgeInsets.all(24.0),
               child: Text('No rate history found.'),
             );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rates.asMap().entries.map((entry) {
              final index = entry.key;
              final rate = entry.value;
              final isActive = index == 0;
              final dateStr = DateFormat('MMM dd, yyyy').format(DateTime.parse(rate.effectiveFrom));
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildHistoryItem(
                  context: context,
                  icon: isActive ? Symbols.check_circle : Symbols.history,
                  iconBgColor: isActive ? AppTheme.secondaryContainer : AppTheme.surfaceContainer,
                  iconColor: isActive ? AppTheme.secondary : AppTheme.onSurfaceVariant,
                  iconFilled: isActive,
                  title: 'Electricity Rate',
                  isActive: isActive,
                  dateRange: 'Effective: $dateStr – ${isActive ? 'Present' : ''}',
                  price: formatCurrency(rate.ratePerUnit),
                  priceSuffix: 'per kWh',
                  isDimmed: !isActive,
                ),
              );
            }).toList(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
      );
    } else {
      return priceHistoryAsync.when(
        data: (prices) {
          if (prices.isEmpty) {
             return const Padding(
               padding: EdgeInsets.all(24.0),
               child: Text('No price history found.'),
             );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: prices.asMap().entries.map((entry) {
              final index = entry.key;
              final price = entry.value;
              final isActive = index == 0;
              final dateStr = DateFormat('MMM dd, yyyy').format(DateTime.parse(price.effectiveFrom));
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildHistoryItem(
                  context: context,
                  icon: isActive ? Symbols.iron : Symbols.history,
                  iconBgColor: isActive ? AppTheme.surfaceContainerHigh : AppTheme.surfaceContainer,
                  iconColor: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
                  iconFilled: isActive,
                  title: 'Standard Pressing',
                  isActive: isActive,
                  dateRange: 'Effective: $dateStr – ${isActive ? 'Present' : ''}',
                  price: formatCurrency(price.pricePerCloth),
                  priceSuffix: 'per garment',
                  isDimmed: !isActive,
                ),
              );
            }).toList(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
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

class AddPriceForm extends ConsumerStatefulWidget {
  final bool isIroning;

  const AddPriceForm({super.key, required this.isIroning});

  @override
  ConsumerState<AddPriceForm> createState() => _AddPriceFormState();
}

class _AddPriceFormState extends ConsumerState<AddPriceForm> {
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amountController.text);
    if (amount == null) return;

    final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);

    if (widget.isIroning) {
      await ref.read(ironingRepositoryProvider).addPrice(IroningPricesCompanion(
        id: drift.Value(const Uuid().v4()),
        effectiveFrom: drift.Value(dateStr),
        pricePerCloth: drift.Value(amount),
        createdAt: drift.Value(DateTime.now().toUtc().toIso8601String()),
        updatedAt: drift.Value(DateTime.now().toUtc().toIso8601String()),
      ));
      ref.invalidate(ironingPriceHistoryProvider);
      ref.invalidate(ironingActivePriceProvider);
    } else {
      await ref.read(electricityRepositoryProvider).addRate(ElectricityRatesCompanion(
        id: drift.Value(const Uuid().v4()),
        effectiveFrom: drift.Value(dateStr),
        ratePerUnit: drift.Value(amount),
        createdAt: drift.Value(DateTime.now().toUtc().toIso8601String()),
        updatedAt: drift.Value(DateTime.now().toUtc().toIso8601String()),
      ));
      ref.invalidate(electricityRateHistoryProvider);
      ref.invalidate(electricityActiveRateProvider);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isIroning ? 'Add Ironing Price' : 'Add Electricity Rate',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text('Effective Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
              ),
              TextButton(
                onPressed: _pickDate,
                child: const Text('Change'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: widget.isIroning ? 'Price per garment' : 'Rate per kWh',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
