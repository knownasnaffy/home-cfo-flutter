import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        showBackButton: true, // Ensuring it has a back button since it's reachable via Settings / Dashboard
        showSync: true,
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB8lfb-7Rg1ilD4gul0KAQCdgilkIpzQw2y_pEc7xVp2ch4oGhZWET7kTfXj4KF7IyYus4DhhEh_RDGWo_-Ea0dkcgagtehsBhFf-McCNzGuxhh_rBTS0F9ise5AghqbJdY2SbsO-WeGhejqq5KM3iSWJNrLzKDjlDmJu4KJxajdnyU9YSRgUa66Xmri9UOzxwVDKs51rPXnmn1L7K9JHtDYF_DNJNjB7Mip3mEKjvquZv3FBVejDMftAiXCExVRqe2c1DOZCCK9Uk',
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
        onPressed: () {},
        backgroundColor: AppTheme.primaryContainer,
        foregroundColor: Colors.white,
        child: const Icon(Symbols.add, size: 32),
      ),
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildBentoCard(
                context: context,
                icon: Symbols.bolt,
                iconColor: AppTheme.secondary,
                badgeText: '+4.2% YoY',
                badgeBgColor: AppTheme.secondaryContainer,
                badgeTextColor: AppTheme.secondary,
                title: 'Electricity Avg.',
                value: '₹0.138',
                valueSuffix: '/kWh',
                height: 128,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildBentoCard(
                context: context,
                icon: Symbols.iron,
                iconColor: AppTheme.onPrimaryContainer,
                badgeText: 'Stable',
                badgeBgColor: AppTheme.surfaceContainer,
                badgeTextColor: AppTheme.onPrimaryContainer,
                title: 'Ironing Rate',
                value: '₹2.50',
                valueSuffix: '/item',
                height: 128,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 128,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
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
                    const Icon(Symbols.calendar_today, color: AppTheme.tertiaryFixedDim),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Next Scheduled Review',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Oct 15, 2024',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHistoryItem(
          context: context,
          icon: Symbols.check_circle,
          iconBgColor: AppTheme.secondaryContainer,
          iconColor: AppTheme.secondary,
          iconFilled: true,
          title: 'Standard Residential',
          isActive: true,
          dateRange: 'Effective: Jan 01, 2024 – Present',
          price: '₹0.142',
          priceSuffix: 'per kWh',
        ),
        const SizedBox(height: 16),
        _buildHistoryItem(
          context: context,
          icon: Symbols.history,
          iconBgColor: AppTheme.surfaceContainer,
          iconColor: AppTheme.onSurfaceVariant,
          title: 'Standard Residential',
          dateRange: 'Effective: Jun 15, 2023 – Dec 31, 2023',
          price: '₹0.135',
          priceSuffix: 'per kWh',
          isDimmed: true,
        ),
        const SizedBox(height: 16),
        _buildHistoryItem(
          context: context,
          icon: Symbols.history,
          iconBgColor: AppTheme.surfaceContainer,
          iconColor: AppTheme.onSurfaceVariant,
          title: 'Standard Residential',
          dateRange: 'Effective: Jan 01, 2023 – Jun 14, 2023',
          price: '₹0.128',
          priceSuffix: 'per kWh',
          isDimmed: true,
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            'IRONING SERVICE HISTORY',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppTheme.onPrimaryContainer,
              letterSpacing: 2.0,
            ),
          ),
        ),
        _buildHistoryItem(
          context: context,
          icon: Symbols.iron,
          iconBgColor: AppTheme.surfaceContainerHigh,
          iconColor: AppTheme.primary,
          iconFilled: true,
          title: 'Standard Pressing',
          dateRange: 'Effective: Aug 10, 2023 – Present',
          price: '₹2.50',
          priceSuffix: 'per garment',
        ),
      ],
    );
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
