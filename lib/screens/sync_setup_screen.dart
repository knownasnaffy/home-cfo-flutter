import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';

class SyncSetupScreen extends StatefulWidget {
  const SyncSetupScreen({super.key});

  @override
  State<SyncSetupScreen> createState() => _SyncSetupScreenState();
}

class _SyncSetupScreenState extends State<SyncSetupScreen> {
  bool _syncEnabled = true;
  bool _obscurePassphrase = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        title: 'Home CFO',
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
            _buildSyncConfigCard(context),
            const SizedBox(height: 16),
            _buildSystemStatusCard(context),
            const SizedBox(height: 16),
            _buildSecurityHealthCard(context),
            const SizedBox(height: 32),
            _buildActionButtons(context),
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
          'Sync Setup',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.onBackground,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Securely bridge your local financial data across all your devices.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSyncConfigCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceVariant.withValues(alpha: 0.5)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cloud Synchronization',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Enable automated backups and multi-device access.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _syncEnabled,
                onChanged: (value) {
                  setState(() {
                    _syncEnabled = value;
                  });
                },
                activeThumbColor: AppTheme.secondary,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: AppTheme.surfaceVariant),
          const SizedBox(height: 24),
          Text(
            'Encryption Passphrase',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppTheme.onBackground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your local data is encrypted before it leaves this device. Keep this passphrase safe.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: '••••••••••••••••',
            obscureText: _obscurePassphrase,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onBackground,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.surfaceContainerLowest,
              hintText: 'Enter secure passphrase',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassphrase ? Symbols.visibility_off : Symbols.visibility,
                  color: AppTheme.outline,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassphrase = !_obscurePassphrase;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.outlineVariant, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.primaryContainer, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Symbols.verified_user, color: AppTheme.onTertiaryContainer, size: 20),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Your passphrase is used to generate an AES-256 key. Home CFO never sees or stores your plain-text password.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
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

  Widget _buildSystemStatusCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceVariant.withValues(alpha: 0.5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppTheme.secondaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Symbols.cloud_done, color: AppTheme.onSecondaryContainer, size: 32, fill: 1.0),
            ),
            const SizedBox(height: 16),
            Text(
              'SYSTEM STATUS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.secondary,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Last Synced',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Oct 24, 14:32',
              style: Theme.of(context).textTheme.titleMedium?.copyWith( // roughly matches numeric-md logic for here
                color: AppTheme.onBackground,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '2 minutes ago',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityHealthCard(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(24),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -16,
            bottom: -16,
            child: Icon(
              Symbols.shield,
              size: 120,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Security Health',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '100%',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Encrypted',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryFixed,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Symbols.save, color: Colors.white),
            label: const Text('Save Sync Preferences'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryContainer,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Symbols.history, color: AppTheme.onBackground),
            label: const Text('View Sync Logs'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.onBackground,
              side: const BorderSide(color: AppTheme.outlineVariant, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ],
    );
  }
}
