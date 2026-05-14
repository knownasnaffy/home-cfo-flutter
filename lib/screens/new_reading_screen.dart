import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:drift/drift.dart' as drift;
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import '../providers/app_providers.dart';
import '../providers/db_provider.dart';
import '../db/database.dart';
import '../utils/currency_formatter.dart';

class NewReadingScreen extends ConsumerStatefulWidget {
  const NewReadingScreen({super.key});

  @override
  ConsumerState<NewReadingScreen> createState() => _NewReadingScreenState();
}

class _NewReadingScreenState extends ConsumerState<NewReadingScreen> {
  int _selectedBillingCycle = 0; // 0 for monthly, 1 for bimonthly
  DateTime _selectedDate = DateTime.now();
  final _meterValueController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _meterValueController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 24),
            _buildContextCards(context),
            const SizedBox(height: 24),
            _buildForm(context),
            const SizedBox(height: 24),
            _buildConsumptionPreview(context),
            const SizedBox(height: 32),
            _buildSubmitButton(context),
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
          'New Reading',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Log your current electricity meter value to track consumption and estimated costs.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildContextCards(BuildContext context) {
    final readingsAsync = ref.watch(electricityReadingsProvider);
    final previousReading = readingsAsync.whenOrNull(
      data: (readings) => readings.isNotEmpty ? readings.first : null,
    );

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.surfaceVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Symbols.history, size: 16, color: AppTheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      'PREVIOUS',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  previousReading != null ? '${previousReading.meterValue} kWh' : '— kWh',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (previousReading != null)
                  Text(
                    DateFormat('MMM d, yyyy').format(DateTime.parse(previousReading.readingDate)),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.outline,
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
              color: AppTheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Symbols.bolt, size: 16, color: AppTheme.secondaryContainer),
                    const SizedBox(width: 8),
                    Text(
                      'EST. COST',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppTheme.onPrimaryContainer,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Builder(
                  builder: (context) {
                    final enteredValue = double.tryParse(_meterValueController.text);
                    final double consumption = (enteredValue != null && previousReading != null)
                        ? enteredValue - previousReading.meterValue
                        : 0.0;

                    final activeRateAsync = ref.watch(electricityActiveRateProvider(_selectedDate.toUtc().toIso8601String().substring(0, 10)));
                    final rate = activeRateAsync.whenOrNull(data: (r) => r?.ratePerUnit) ?? 0.0;

                    if (rate == 0.0 || consumption <= 0) {
                      return Text(
                        '—',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }

                    final estimatedCost = consumption * rate;
                    return Text(
                      formatCurrency(estimatedCost),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                ),
                Text(
                  'Based on current rate',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    final String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(_selectedDate);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppTheme.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            context: context,
            label: 'Current Meter Value',
            child: TextFormField(
              controller: _meterValueController,
              onChanged: (_) => setState(() {}),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.onSurface,
              ),
              decoration: _buildInputDecoration(
                context,
                hint: '0.00',
                suffixIcon: Symbols.speed,
              ).copyWith(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFormField(
                  context: context,
                  label: 'Reading Date',
                  child: GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              formattedDate,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.onSurface,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Symbols.calendar_today, color: AppTheme.onSurfaceVariant, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFormField(
                  context: context,
                  label: 'Billing Cycle',
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedBillingCycle = 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _selectedBillingCycle == 0 ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: _selectedBillingCycle == 0
                                    ? const [BoxShadow(color: Color(0x0A000000), blurRadius: 2, offset: Offset(0, 1))]
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Monthly',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: _selectedBillingCycle == 0 ? AppTheme.primary : AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedBillingCycle = 1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _selectedBillingCycle == 1 ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: _selectedBillingCycle == 1
                                    ? const [BoxShadow(color: Color(0x0A000000), blurRadius: 2, offset: Offset(0, 1))]
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Bi-monthly',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: _selectedBillingCycle == 1 ? AppTheme.primary : AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildFormField(
            context: context,
            label: 'Reading Note (Optional)',
            child: TextFormField(
              controller: _noteController,
              maxLines: 4,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: _buildInputDecoration(
                context,
                hint: 'Add details about house occupancy or appliance changes...',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required BuildContext context,
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context, {String? hint, IconData? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: AppTheme.surfaceContainerLow,
      hintText: hint,
      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppTheme.outlineVariant,
      ),
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: AppTheme.onSurfaceVariant)
          : null,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppTheme.primaryFixed, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildConsumptionPreview(BuildContext context) {
    final readingsAsync = ref.watch(electricityReadingsProvider);
    final previousReading = readingsAsync.whenOrNull(
      data: (readings) => readings.isNotEmpty ? readings.first : null,
    );

    final enteredValue = double.tryParse(_meterValueController.text);
    final double? consumption = (enteredValue != null && previousReading != null)
        ? enteredValue - previousReading.meterValue
        : null;

    final String displayConsumption = consumption != null ? consumption.toStringAsFixed(1) : '—';
    const double targetConsumption = 450.0; // example target
    final double progress = (consumption ?? 0) / targetConsumption;
    final double boundedProgress = progress > 1.0 ? 1.0 : (progress < 0 ? 0 : progress);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outlineVariant, style: BorderStyle.solid),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consumption Preview',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Usage Since Last Reading',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          displayConsumption,
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: AppTheme.primary,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'kWh',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (consumption != null && consumption > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          'Normal Pace',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.onSecondaryContainer,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(9999),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: boundedProgress,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0 kWh',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              Text(
                'Target: 450 kWh',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () async {
          final double meterValue = double.tryParse(_meterValueController.text) ?? 0.0;
          final String billingCycle = _selectedBillingCycle == 0 ? 'monthly' : 'bimonthly';
          final String note = _noteController.text;

          final repo = ref.read(electricityRepositoryProvider);
          await repo.addReading(ElectricityReadingsCompanion(
            readingDate: drift.Value(_selectedDate.toUtc().toIso8601String().substring(0, 10)),
            meterValue: drift.Value(meterValue),
            billingCycle: drift.Value(billingCycle),
            note: drift.Value(note.isEmpty ? null : note),
          ));

          ref.invalidate(electricityReadingsProvider);

          if (context.mounted) Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: AppTheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
          shadowColor: AppTheme.primary.withValues(alpha: 0.2),
        ),
        child: Text(
          'SUBMIT READING',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.onPrimary,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
