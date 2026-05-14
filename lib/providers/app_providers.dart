import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import 'db_provider.dart';
import '../db/repositories/ironing_repository.dart';
import '../db/repositories/electricity_repository.dart';

extension IroningRepositoryExtension on IroningRepository {
  Future<IroningPrice?> getActivePriceRow(String date) async {
    final query = db.select(db.ironingPrices)
      ..where((t) => t.effectiveFrom.isSmallerOrEqualValue(date))
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.effectiveFrom, mode: OrderingMode.desc)])
      ..limit(1);
    return await query.getSingleOrNull();
  }
}

extension ElectricityRepositoryExtension on ElectricityRepository {
  Future<ElectricityRate?> getActiveRateRow(String date) async {
    final query = db.select(db.electricityRates)
      ..where((t) => t.effectiveFrom.isSmallerOrEqualValue(date))
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.effectiveFrom, mode: OrderingMode.desc)])
      ..limit(1);
    return await query.getSingleOrNull();
  }
}

final ironingBalanceProvider = FutureProvider<double>((ref) async {
  final repo = ref.watch(ironingRepositoryProvider);
  return repo.getCurrentBalance();
});

final recentIroningTransactionsProvider = FutureProvider<List<IroningTransaction>>((ref) async {
  final repo = ref.watch(ironingRepositoryProvider);
  return repo.getRecentTransactions(5);
});

final allIroningTransactionsProvider = FutureProvider<List<IroningTransaction>>((ref) async {
  final repo = ref.watch(ironingRepositoryProvider);
  return repo.getAllTransactions();
});

final electricityReadingsProvider = FutureProvider<List<ElectricityReading>>((ref) async {
  final repo = ref.watch(electricityRepositoryProvider);
  return repo.getReadings();
});

final ironingActivePriceProvider = FutureProvider.family<IroningPrice?, String>((ref, date) async {
  final repo = ref.watch(ironingRepositoryProvider);
  return repo.getActivePriceRow(date);
});

final electricityActiveRateProvider = FutureProvider.family<ElectricityRate?, String>((ref, date) async {
  final repo = ref.watch(electricityRepositoryProvider);
  return repo.getActiveRateRow(date);
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
