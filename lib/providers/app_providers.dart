import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import 'db_provider.dart';

final ironingBalanceProvider = FutureProvider<double>((ref) async {
  final repo = ref.watch(ironingRepositoryProvider);
  return repo.getCurrentBalance();
});

final recentIroningTransactionsProvider = FutureProvider<List<IroningTransaction>>((ref) async {
  final repo = ref.watch(ironingRepositoryProvider);
  return repo.getRecentTransactions(5); // Adjust limit as necessary
});

final allIroningTransactionsProvider = FutureProvider<List<IroningTransaction>>((ref) async {
  final repo = ref.watch(ironingRepositoryProvider);
  return repo.getAllTransactions();
});

final electricityReadingsProvider = FutureProvider<List<ElectricityReading>>((ref) async {
  final repo = ref.watch(electricityRepositoryProvider);
  return repo.getReadings();
});
