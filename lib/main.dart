import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/bottom_nav_bar.dart';

import 'screens/dashboard_screen.dart';
import 'screens/ironing_home_screen.dart';
import 'screens/electricity_home_screen.dart';
import 'screens/settings_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: HomeCFOApp()));
}

class HomeCFOApp extends StatelessWidget {
  const HomeCFOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home CFO',
      theme: AppTheme.lightTheme,
      home: const MainNavigationShell(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    IroningHomeScreen(),
    ElectricityHomeScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

}
