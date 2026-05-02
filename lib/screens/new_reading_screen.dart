import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';

class NewReadingScreen extends StatefulWidget {
  const NewReadingScreen({super.key});

  @override
  State<NewReadingScreen> createState() => _NewReadingScreenState();
}

class _NewReadingScreenState extends State<NewReadingScreen> {
  int _selectedBillingCycle = 0; // 0 for Actual, 1 for Estimate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: true,
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAo_KDd6EaDBADJ49GQyulhz_v4dDhDr8H-eOccv8UmtjwmgXhir3Ff38gpPZb8ZnZGlcl4WIeIJFNAtCzUcqa3tumIGQseWnbZYeZenEJThnsOyzaWfbOrGVVeyo1Byv5QMJLek5WxvX6OCcHRlJXn5ecDYcw0Byw83Oeo5JUyKGXqYLLIhdGtR-zc9H-BiWet2iVgF5V75Lz0DUf8e5rFFt29H_pmzQMv9K62LFiSYsFR3z7P1OJXWPiZmynQOb8XxcjfFZ8Xx-Q',
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
            color: AppTheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Log your current electricity consumption for billing accuracy.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildContextCards(BuildContext context) {
    return Column(
      children: [
        _buildContextCard(
          context: context,
          icon: Symbols.history,
          iconColor: AppTheme.secondary,
          title: 'Previous Reading',
          value: '12,450.00',
          valueSuffix: 'kWh',
          valueColor: AppTheme.primary,
          footerText: 'Recorded on Oct 12, 2023',
          bgColor: Colors.white,
          borderColor: AppTheme.surfaceVariant,
          titleColor: AppTheme.onSurfaceVariant,
          footerColor: AppTheme.onSurfaceVariant,
        ),
        const SizedBox(height: 16),
        _buildContextCard(
          context: context,
          icon: Symbols.trending_up,
          iconColor: AppTheme.tertiaryFixedDim,
          title: 'Estimated Cost',
          value: '--.--',
          valueSuffix: 'USD',
          valueColor: AppTheme.onPrimary,
          footerText: 'Based on new input',
          bgColor: AppTheme.primaryContainer,
          borderColor: AppTheme.onPrimaryContainer,
          titleColor: AppTheme.onPrimaryContainer,
          footerColor: AppTheme.onPrimaryContainer,
          isItalicFooter: true,
        ),
      ],
    );
  }

  Widget _buildContextCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String valueSuffix,
    required Color valueColor,
    required String footerText,
    required Color bgColor,
    required Color borderColor,
    required Color titleColor,
    required Color footerColor,
    bool isItalicFooter = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
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
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: titleColor,
                  letterSpacing: 1.0,
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
                value,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: valueColor,
                  fontSize: 28,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                valueSuffix,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            footerText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: footerColor,
              fontStyle: isItalicFooter ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            context: context,
            label: 'Current Meter Reading (kWh)',
            child: TextFormField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: Theme.of(context).textTheme.titleMedium,
              decoration: _buildInputDecoration(
                context,
                hint: '000000.00',
                suffixIcon: Symbols.bolt,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildFormField(
                  context: context,
                  label: 'Reading Date',
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: _buildInputDecoration(context),
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
                      color: AppTheme.surfaceContainerLow,
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
                                'Actual',
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
                                'Estimate',
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
                          '0',
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
                    const SizedBox(height: 4),
                    Text(
                      'Avg. 14.2 kWh / day',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
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
              widthFactor: 0.05,
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
        onPressed: () => Navigator.pop(context),
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
