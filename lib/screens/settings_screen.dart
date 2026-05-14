import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import 'history_screen.dart';
import 'sync_setup_screen.dart';
import '../providers/app_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _syncEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSyncPreference();
  }

  Future<void> _loadSyncPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _syncEnabled = prefs.getBool('syncEnabled') ?? true;
    });
  }

  Future<void> _updateSyncPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('syncEnabled', value);
    setState(() {
      _syncEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Usage History'),
            _buildHistorySection(context),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Data & Storage'),
            _buildSyncSection(context),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Security & Privacy'),
            _buildSecuritySection(context),
            const SizedBox(height: 32),
            _buildAppInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppTheme.onTertiaryContainer,
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
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
      child: Column(
        children: [
          _buildListTile(
            context: context,
            icon: Symbols.payments,
            title: 'Ironing Price History',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
          ),
          const Divider(height: 1, color: AppTheme.surfaceVariant),
          _buildListTile(
            context: context,
            icon: Symbols.bolt,
            title: 'Electricity Rate History',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Symbols.cloud_sync,
                      color: AppTheme.secondary,
                      fill: 1.0,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Cloud Sync',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _syncEnabled,
                onChanged: (value) {
                  _updateSyncPreference(value);
                  if (value) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SyncSetupScreen()));
                  }
                },
                activeThumbColor: AppTheme.secondary,
                inactiveThumbColor: AppTheme.outlineVariant,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppTheme.surfaceVariant)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last Synced',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.outline,
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final lastSyncedAsync = ref.watch(lastSyncedAtProvider);
                    final lastSynced = lastSyncedAsync.value;
                    return Text(
                      lastSynced != null ? DateFormat('MMM dd, hh:mm a').format(DateTime.parse(lastSynced).toLocal()) : 'Never synced',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
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
      child: _buildListTile(
        context: context,
        icon: Symbols.key,
        title: 'Passphrase Setup',
        subtitle: 'Secure your financial vault',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SyncSetupScreen())),
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
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
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: AppTheme.outline),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.onSurface,
                        ),
                      ),
                      if (subtitle != null) ...[
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.outline,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const Icon(Symbols.chevron_right, color: AppTheme.outline),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppInfo(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Home CFO v2.4.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.outline,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Local-first Domestic Stewardship',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
