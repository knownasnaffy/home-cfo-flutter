import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';

class NewIroningTransactionScreen extends StatefulWidget {
  const NewIroningTransactionScreen({super.key});

  @override
  State<NewIroningTransactionScreen> createState() => _NewIroningTransactionScreenState();
}

class _NewIroningTransactionScreenState extends State<NewIroningTransactionScreen> {
  int _transactionType = 0; // 0 for Debt, 1 for Credit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceBright,
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: true,
        title: 'Home CFO',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD8mJPtJ1C0mJurBU7XbQpk80h6A9TB-oc0zRGZhtUM94aS_R225HYwME6KIZLrgtQCaQPPebZAzg5p2ZkpjjE1y0fFTd2K9fC7meZRyfIj2btZybmQKu1xNrz_iq9nQ0plUrIr7csscsfNpqY8i544bQ9gpHFcAOQnHKOL62BoUfs7XWCFYFlZznYaSADoK4n2BtXifYTmn71Kf30mJWvN5OTTU7sl-Zl9f1YzmAXAQ46I8SvgNNWRAvgUvz5nz0SGrkSXirU0yZQ',
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
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Symbols.iron,
            color: AppTheme.onPrimary,
            size: 36,
            fill: 1.0,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'New Ironing Transaction',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Record a new payment or debt for domestic services',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceVariant),
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
          _buildAmountInput(context),
          const SizedBox(height: 32),
          _buildTransactionTypeToggle(context),
          const SizedBox(height: 32),
          _buildDescriptionInput(context),
          const SizedBox(height: 24),
          const Divider(height: 1, color: AppTheme.surfaceVariant),
          const SizedBox(height: 16),
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
          'TRANSACTION AMOUNT',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.onSurfaceVariant,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: AppTheme.onSurface,
            fontSize: 32,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.surfaceContainerLow,
            hintText: '0.00',
            hintStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppTheme.outlineVariant,
              fontSize: 32,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Text(
                '\$',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.outline,
                  fontSize: 32,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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

  Widget _buildTransactionTypeToggle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TRANSACTION TYPE',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Symbols.calendar_today, size: 16, color: AppTheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Text(
              'Today, Oct 24',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
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
            image: const DecorationImage(
              image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCveXFckx6l_7SLWwVUANKiQT-0vndeFoX9GxUEiZwnFaEYEYTwyYlrx-w0Q774vMWyr8ECBm8qS_iSaLjQA4Z_KcrPbWITdrcwub1jYNpg8QialN3_rMgOpJfDesHM82G4Ov7VWBuVkYtdKcDhajq0Pi5-LiBJRWZep3Q5CLfituiwWSBU1kvaSxpIeMbZuEqHzUZWfI4Yz9QR5b3SJsr85jeHn2goyK4Z1-0Dqn8gnctz8fKj0j1bRxXGlNat1yYzufNCJCSFPGI'),
              fit: BoxFit.cover,
            ),
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
            onPressed: () => Navigator.pop(context),
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
