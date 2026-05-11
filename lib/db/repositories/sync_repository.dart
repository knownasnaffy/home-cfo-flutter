import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database.dart';

class SyncRepository {
  final AppDatabase db;
  const SyncRepository(this.db);

  Future<Map<String, List<dynamic>>> getUnsyncedRows() async {
    final ironingPrices = await (db.select(db.ironingPrices)..where((t) => t.syncedAt.isNull())).get();
    final ironingTransactions = await (db.select(db.ironingTransactions)..where((t) => t.syncedAt.isNull())).get();
    final electricityReadings = await (db.select(db.electricityReadings)..where((t) => t.syncedAt.isNull())).get();
    final electricityRates = await (db.select(db.electricityRates)..where((t) => t.syncedAt.isNull())).get();

    return {
      'ironing_prices': ironingPrices,
      'ironing_transactions': ironingTransactions,
      'electricity_readings': electricityReadings,
      'electricity_rates': electricityRates,
    };
  }

  Future<void> markAsSynced(String table, List<String> ids) async {
    if (ids.isEmpty) return;

    final now = DateTime.now().toUtc().toIso8601String();

    switch (table) {
      case 'ironing_prices':
        await (db.update(db.ironingPrices)..where((t) => t.id.isIn(ids))).write(
          IroningPricesCompanion(syncedAt: Value(now)),
        );
        break;
      case 'ironing_transactions':
        await (db.update(db.ironingTransactions)..where((t) => t.id.isIn(ids))).write(
          IroningTransactionsCompanion(syncedAt: Value(now)),
        );
        break;
      case 'electricity_readings':
        await (db.update(db.electricityReadings)..where((t) => t.id.isIn(ids))).write(
          ElectricityReadingsCompanion(syncedAt: Value(now)),
        );
        break;
      case 'electricity_rates':
        await (db.update(db.electricityRates)..where((t) => t.id.isIn(ids))).write(
          ElectricityRatesCompanion(syncedAt: Value(now)),
        );
        break;
      default:
        throw ArgumentError('Unknown table: $table');
    }
  }

  Future<String?> getLastSyncedAt() async {
    final query = db.select(db.syncLogs)
      ..where((t) => t.status.equals('success'))
      ..orderBy([(t) => OrderingTerm(expression: t.syncedAt, mode: OrderingMode.desc)])
      ..limit(1);

    final lastSyncLog = await query.getSingleOrNull();
    return lastSyncLog?.syncedAt;
  }

  Future<void> writeSyncLog(SyncLogsCompanion entry) async {
    final id = const Uuid().v4();

    await db.into(db.syncLogs).insert(
      entry.copyWith(id: Value(id))
    );
  }
}
