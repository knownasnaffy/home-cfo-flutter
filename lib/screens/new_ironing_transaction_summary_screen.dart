import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';

class NewIroningTransactionSummaryScreen extends StatefulWidget {
  const NewIroningTransactionSummaryScreen({super.key});

  @override
  State<NewIroningTransactionSummaryScreen> createState() => _NewIroningTransactionSummaryScreenState();
}

class _NewIroningTransactionSummaryScreenState extends State<NewIroningTransactionSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true,
        showSync: true,
        title: 'New Ironing Transaction',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB8lfb-7Rg1ilD4gul0KAQCdgilkIpzQw2y_pEc7xVp2ch4oGhZWET7kTfXj4KF7IyYus4DhhEh_RDGWo_-Ea0dkcgagtehsBhFf-McCNzGuxhh_rBTS0F9ise5AghqbJdY2SbsO-WeGhejqq5KM3iSWJNrLzKDjlDmJu4KJxajdnyU9YSRgUa66Xmri9UOzxwVDKs51rPXnmn1L7K9JHtDYF_DNJNjB7Mip3mEKjvquZv3FBVejDMftAiXCExVRqe2c1DOZCCK9Uk',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            _buildServiceDetailsCard(context),
            const SizedBox(height: 24),
            _buildTransactionSummary(context),
            const SizedBox(height: 32),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceDetailsCard(BuildContext context) {
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.surfaceContainerLow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Symbols.iron, color: AppTheme.secondary),
                    const SizedBox(width: 8),
                    Text(
                      'Service Details',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.onSurface,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    'Regular Ironing',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppTheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cloth Count',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: '12',
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppTheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.surfaceBright,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppTheme.surfaceVariant, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppTheme.primary, width: 2),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildStepperButton(Symbols.remove),
                          const SizedBox(width: 4),
                          _buildStepperButton(Symbols.add),
                        ],
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.outlineVariant),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price per item',
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
                                  '\$1.50',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppTheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '/ pc',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppTheme.outlineVariant,
                                  ),
                                ),
                              ],
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
                          color: AppTheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.outlineVariant),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service Type',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: AppTheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Standard',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Amount Paid',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: '20.00',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppTheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.surfaceBright,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: Text(
                        '\$',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppTheme.surfaceVariant, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppTheme.primary, width: 2),
                    ),
                    suffixIcon: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Clear',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppTheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Icon(icon, color: AppTheme.onSurface),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TRANSACTION SUMMARY',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppTheme.onTertiaryContainer,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(context, 'Subtotal (12 items × \$1.50)', '\$18.00'),
          const SizedBox(height: 8),
          _buildSummaryRow(context, 'Express Fee (None)', '\$0.00'),
          const SizedBox(height: 16),
          Divider(height: 1, color: AppTheme.onTertiaryContainer.withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                '\$18.00',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change Due',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.secondaryContainer,
                ),
              ),
              Text(
                '+\$2.00',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.secondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w600,
            fontSize: 16,
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
            onPressed: () => Navigator.pop(context), // Pops back on success
            icon: const Icon(Symbols.save, color: Colors.white, fill: 1.0),
            label: const Text('Confirm Transaction'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
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
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.onSurfaceVariant,
              side: const BorderSide(color: AppTheme.outlineVariant, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel & Clear'),
          ),
        ),
      ],
    );
  }
}
