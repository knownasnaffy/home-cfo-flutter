import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database.dart';

class ElectricityRepository {
  final AppDatabase db;
  const ElectricityRepository(this.db);

  Future<double?> getConsumptionForReading(String id) async {
    final query = db.select(db.electricityReadings)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.readingDate, mode: OrderingMode.asc)]);

    final readings = await query.get();

    for (int i = 0; i < readings.length; i++) {
      if (readings[i].id == id) {
        if (i == 0) return null; // First reading has no previous
        return readings[i].meterValue - readings[i - 1].meterValue;
      }
    }

    return null; // Reading not found
  }

  Future<double?> getActiveRate(String date) async {
    final query = db.select(db.electricityRates)
      ..where((t) => t.effectiveFrom.isSmallerOrEqualValue(date))
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.effectiveFrom, mode: OrderingMode.desc)])
      ..limit(1);

    final activeRateRow = await query.getSingleOrNull();
    return activeRateRow?.ratePerUnit;
  }

  Future<List<ElectricityRate>> getRateHistory() async {
    final query = db.select(db.electricityRates)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.effectiveFrom, mode: OrderingMode.desc)]);

    return await query.get();
  }

  Future<void> addRate(ElectricityRatesCompanion rate) async {
    final id = const Uuid().v4();
    final now = DateTime.now().toUtc().toIso8601String();

    await db.into(db.electricityRates).insert(
      rate.copyWith(
        id: Value(id),
        createdAt: Value(now),
        updatedAt: Value(now),
      )
    );
  }

  Future<List<ElectricityReading>> getReadings() async {
    final query = db.select(db.electricityReadings)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.readingDate, mode: OrderingMode.desc)]);

    return await query.get();
  }

  Future<void> addReading(ElectricityReadingsCompanion reading) async {
    final id = const Uuid().v4();
    final now = DateTime.now().toUtc().toIso8601String();

    await db.into(db.electricityReadings).insert(
      reading.copyWith(
        id: Value(id),
        createdAt: Value(now),
        updatedAt: Value(now),
      )
    );
  }

  Future<void> updateReading(String id, ElectricityReadingsCompanion fields) async {
    final now = DateTime.now().toUtc().toIso8601String();

    await (db.update(db.electricityReadings)..where((t) => t.id.equals(id))).write(
      fields.copyWith(
        updatedAt: Value(now),
        syncedAt: const Value(null),
      )
    );
  }
}
