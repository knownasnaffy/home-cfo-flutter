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

final ironingActivePriceProvider = FutureProvider.family<double?, String>((ref, date) async {
  final repo = ref.watch(ironingRepositoryProvider);
  return repo.getActivePrice(date);
});

final electricityActiveRateProvider = FutureProvider.family<double?, String>((ref, date) async {
  final repo = ref.watch(electricityRepositoryProvider);
  return repo.getActiveRate(date);
});

final ironingPriceHistoryProvider = FutureProvider<List<IroningPrice>>((ref) async {
  final repo = ref.watch(ironingRepositoryProvider);
  return repo.getPriceHistory();
});

final electricityRateHistoryProvider = FutureProvider<List<ElectricityRate>>((ref) async {
  final repo = ref.watch(electricityRepositoryProvider);
  return repo.getRateHistory();
});

final electricityConsumptionProvider = FutureProvider.family<double?, String>((ref, id) async {
  final repo = ref.watch(electricityRepositoryProvider);
  return repo.getConsumptionForReading(id);
});

final lastSyncedAtProvider = FutureProvider<String?>((ref) async {
  final repo = ref.watch(syncRepositoryProvider);
  return repo.getLastSyncedAt();
});
