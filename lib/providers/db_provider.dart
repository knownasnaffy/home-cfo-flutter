import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../db/repositories/ironing_repository.dart';
import '../db/repositories/electricity_repository.dart';
import '../db/repositories/sync_repository.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final ironingRepositoryProvider = Provider<IroningRepository>((ref) {
  final db = ref.watch(dbProvider);
  return IroningRepository(db);
});

final electricityRepositoryProvider = Provider<ElectricityRepository>((ref) {
  final db = ref.watch(dbProvider);
  return ElectricityRepository(db);
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  final db = ref.watch(dbProvider);
  return SyncRepository(db);
});
