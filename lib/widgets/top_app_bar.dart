import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final bool showSync;
  final VoidCallback? onSync;
  final String? avatarUrl;

  const TopAppBar({
    super.key,
    this.title = 'Home CFO',
    this.showBackButton = true,
    this.onBack,
    this.showSync = true,
    this.onSync,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surfaceContainerLowest, // bg-slate-50 equivalent
        border: Border(
          bottom: BorderSide(
            color: AppTheme.surfaceVariant, // border-slate-200 equivalent
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56, // h-14 equivalent roughly
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (showBackButton)
                      IconButton(
                        icon: const Icon(Symbols.arrow_back),
                        onPressed: onBack ?? () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                        color: AppTheme.onSurface,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    if (showBackButton) const SizedBox(width: 12),
                    if (!showBackButton && avatarUrl != null) ...[
                       Container(
                         width: 32,
                         height: 32,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           border: Border.all(color: AppTheme.outlineVariant),
                           image: avatarUrl!.isNotEmpty ? DecorationImage(
                             image: NetworkImage(avatarUrl!),
                             fit: BoxFit.cover,
                           ) : null,
                         ),
                       ),
                       const SizedBox(width: 12),
                    ],
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900, // font-black
                            color: AppTheme.onSurface,
                            letterSpacing: -0.5, // tracking-tight
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (showSync)
                      IconButton(
                        icon: const Icon(Symbols.sync),
                        onPressed: onSync ?? () {},
                        color: AppTheme.onSurface,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    if (showBackButton && avatarUrl != null) ...[
                      const SizedBox(width: 16),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.outlineVariant),
                          image: avatarUrl!.isNotEmpty ? DecorationImage(
                            image: NetworkImage(avatarUrl!),
                            fit: BoxFit.cover,
                          ) : null,
                        ),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // kToolbarHeight + safe area handled internally
}
