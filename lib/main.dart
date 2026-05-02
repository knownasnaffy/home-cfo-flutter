import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/bottom_nav_bar.dart';

import 'screens/dashboard_screen.dart';
import 'screens/ironing_home_screen.dart';
import 'screens/electricity_home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/history_screen.dart';
import 'screens/new_reading_screen.dart';
import 'screens/reading_detail_screen.dart';
import 'screens/sync_setup_screen.dart';
import 'screens/transaction_history_screen.dart';
import 'screens/transaction_detail_screen.dart';
import 'screens/new_ironing_transaction_screen.dart';
import 'screens/new_ironing_transaction_summary_screen.dart';
import 'screens/reset_transaction_screen.dart';

void main() {
  runApp(const HomeCFOApp());
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
      // Only adding drawer to easily access all screens during dev/demo since they aren't all wired fully via tap handlers in UI yet.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppTheme.primaryContainer),
              child: Text('All Screens Navigation', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            _buildDrawerItem(context, 'Dashboard', const DashboardScreen()),
            _buildDrawerItem(context, 'Ironing Home', const IroningHomeScreen()),
            _buildDrawerItem(context, 'Electricity Home', const ElectricityHomeScreen()),
            _buildDrawerItem(context, 'Settings', const SettingsScreen()),
            _buildDrawerItem(context, 'History (Utility)', const HistoryScreen()),
            _buildDrawerItem(context, 'Sync Setup', const SyncSetupScreen()),
            _buildDrawerItem(context, 'New Reading', const NewReadingScreen()),
            _buildDrawerItem(context, 'Reading Detail', const ReadingDetailScreen()),
            _buildDrawerItem(context, 'Transaction History', const TransactionHistoryScreen()),
            _buildDrawerItem(context, 'Transaction Detail', const TransactionDetailScreen()),
            _buildDrawerItem(context, 'New Ironing Txn', const NewIroningTransactionScreen()),
            _buildDrawerItem(context, 'New Ironing Summary', const NewIroningTransactionSummaryScreen()),
            _buildDrawerItem(context, 'Reset Txn Warning', const ResetTransactionScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, Widget screen) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // close drawer
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
    );
  }
}
