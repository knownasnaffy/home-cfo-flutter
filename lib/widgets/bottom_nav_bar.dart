import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: AppTheme.surfaceVariant,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000), // shadow-[0_-2px_8px_rgba(0,0,0,0.04)] equivalent
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64, // h-16 equivalent
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                index: 0,
                icon: Symbols.dashboard,
                label: 'Dashboard',
              ),
              _buildNavItem(
                context,
                index: 1,
                icon: Symbols.payments, // Alternative to ironing icon missing in standard set? Wait, let's stick to what's mapped or use generic if material_symbols missing. Symbols.payments used in screen 10
                label: 'Ironing',
              ),
              _buildNavItem(
                context,
                index: 2,
                icon: Symbols.bolt,
                label: 'Electricity',
              ),
              _buildNavItem(
                context,
                index: 3,
                icon: Symbols.settings,
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required int index, required IconData icon, required String label}) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              fill: isSelected ? 1 : 0,
              color: isSelected ? AppTheme.onSurface : AppTheme.outline,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Public Sans',
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.05,
                color: isSelected ? AppTheme.onSurface : AppTheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
