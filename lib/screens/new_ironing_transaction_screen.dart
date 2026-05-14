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

class NewIroningTransactionScreen extends ConsumerStatefulWidget {
  const NewIroningTransactionScreen({super.key});

  @override
  ConsumerState<NewIroningTransactionScreen> createState() => _NewIroningTransactionScreenState();
}

class _NewIroningTransactionScreenState extends ConsumerState<NewIroningTransactionScreen> {
  int _transactionType = 0; // 0 for Debt (debit), 1 for Credit (credit)
  DateTime _selectedDate = DateTime.now();
  final _amountController = TextEditingController();
  final _labelController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _labelController.dispose();
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
      backgroundColor: AppTheme.surfaceBright,
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: true,
        title: 'Home CFO',
        avatarUrl: '',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildFormCard(context),
            const SizedBox(height: 16),
            _buildDecorativeCard(context),
            const SizedBox(height: 32),
            _buildSaveAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppTheme.primaryContainer,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryContainer.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Symbols.add_card, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          'Custom Ledger Entry',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Manually adjust the ironing balance',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAmountInput(context),
          const SizedBox(height: 24),
          _buildTypeSelector(context),
          const SizedBox(height: 24),
          _buildDescriptionInput(context),
          const SizedBox(height: 24),
          _buildDateSelector(context),
        ],
      ),
    );
  }

  Widget _buildAmountInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AMOUNT',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.onSurfaceVariant,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.onSurface,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.surfaceContainerLow,
            hintText: '0.00',
            hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppTheme.outlineVariant,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Text(
                '₹',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.primaryFixed, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ENTRY TYPE',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.onSurfaceVariant,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _transactionType = 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _transactionType == 0 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: _transactionType == 0
                          ? Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.2))
                          : null,
                      boxShadow: _transactionType == 0
                          ? const [BoxShadow(color: Color(0x0A000000), blurRadius: 2, offset: Offset(0, 1))]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Symbols.arrow_downward, color: AppTheme.secondary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Debt',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _transactionType = 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _transactionType == 1 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: _transactionType == 1
                          ? Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.2))
                          : null,
                      boxShadow: _transactionType == 1
                          ? const [BoxShadow(color: Color(0x0A000000), blurRadius: 2, offset: Offset(0, 1))]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Symbols.arrow_upward, color: AppTheme.onErrorContainer, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Credit',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DESCRIPTION',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.onSurfaceVariant,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _labelController,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.onSurface,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.surfaceContainerLow,
            hintText: 'e.g. Weekly business shirts',
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.outlineVariant,
            ),
            suffixIcon: const Icon(Symbols.edit, color: AppTheme.outlineVariant),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryFixed, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    final String formattedDate = DateFormat('EEE, MMM d').format(_selectedDate);
    final String displayDate = _selectedDate.day == DateTime.now().day &&
            _selectedDate.month == DateTime.now().month &&
            _selectedDate.year == DateTime.now().year
        ? 'Today, $formattedDate'
        : formattedDate;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Symbols.calendar_today, size: 16, color: AppTheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Text(
              displayDate,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: _pickDate,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Change Date',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppTheme.primaryFixedDim,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDecorativeCard(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.secondaryContainer.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.secondaryContainer.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Symbols.verified, color: AppTheme.onSecondaryContainer),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SERVICE STATUS',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.onSecondaryContainer,
                    ),
                  ),
                  Text(
                    'Professional Quality',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSecondaryFixed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: linearBinding(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
              ),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Maintain garment longevity with correct settings',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Gradient linearBinding({required Alignment begin, required Alignment end, required List<Color> colors}) {
     return LinearGradient(begin: begin, end: end, colors: colors);
  }

  Widget _buildSaveAction(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () async {
              final double amount = double.tryParse(_amountController.text) ?? 0.0;
              final direction = _transactionType == 0 ? 'debit' : 'credit';
              final label = _labelController.text;

              final repo = ref.read(ironingRepositoryProvider);

              await repo.addTransaction(IroningTransactionsCompanion(
                date: drift.Value(_selectedDate.toUtc().toIso8601String().substring(0, 10)),
                type: const drift.Value('custom'),
                amount: drift.Value(amount),
                direction: drift.Value(direction),
                label: drift.Value(label.isEmpty ? null : label),
              ));

              ref.invalidate(ironingBalanceProvider);
              ref.invalidate(allIroningTransactionsProvider);
              ref.invalidate(recentIroningTransactionsProvider);

              if (context.mounted) Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryContainer,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Save Transaction',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Symbols.check_circle, fill: 1.0),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'This entry will be synced to your local ledger instantly.',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppTheme.outline,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
