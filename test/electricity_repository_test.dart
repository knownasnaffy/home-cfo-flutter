import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart' as flutter_test;
// The hide doesn't hide everything easily sometimes, but we can prefix flutter_test
import 'package:home_cfo/db/database.dart';
import 'package:home_cfo/db/repositories/electricity_repository.dart';

void main() {
  late AppDatabase db;
  late ElectricityRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ElectricityRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('ElectricityRepository getActiveRate returns correct rate based on effective_from date', () async {
    await repo.addRate(const ElectricityRatesCompanion(
      ratePerUnit: Value(0.12),
      effectiveFrom: Value('2023-01-01'),
    ));

    await repo.addRate(const ElectricityRatesCompanion(
      ratePerUnit: Value(0.15),
      effectiveFrom: Value('2023-06-01'),
    ));

    await repo.addRate(const ElectricityRatesCompanion(
      ratePerUnit: Value(0.14),
      effectiveFrom: Value('2024-01-01'),
    ));

    final rateBefore2023 = await repo.getActiveRate('2022-12-31');
    expect(rateBefore2023, flutter_test.isNull);

    final rateInMarch2023 = await repo.getActiveRate('2023-03-15');
    expect(rateInMarch2023, 0.12);

    final rateInJuly2023 = await repo.getActiveRate('2023-07-20');
    expect(rateInJuly2023, 0.15);

    final rateToday = await repo.getActiveRate('2024-10-24');
    expect(rateToday, 0.14);
  });

  test('ElectricityRepository getConsumptionForReading computes correctly based on ordered readings', () async {
    final now = DateTime.now().toUtc().toIso8601String();

    final id1 = 'id-1';
    await db.into(db.electricityReadings).insert(
      ElectricityReadingsCompanion.insert(
        id: id1,
        readingDate: '2023-08-01',
        meterValue: 12000.0,
        billingCycle: 'monthly',
        createdAt: now,
        updatedAt: now,
      )
    );

    final id2 = 'id-2';
    await db.into(db.electricityReadings).insert(
      ElectricityReadingsCompanion.insert(
        id: id2,
        readingDate: '2023-09-01',
        meterValue: 12400.0,
        billingCycle: 'monthly',
        createdAt: now,
        updatedAt: now,
      )
    );

    final id3 = 'id-3';
    await db.into(db.electricityReadings).insert(
      ElectricityReadingsCompanion.insert(
        id: id3,
        readingDate: '2023-10-01',
        meterValue: 12850.5,
        billingCycle: 'monthly',
        createdAt: now,
        updatedAt: now,
      )
    );

    final cons1 = await repo.getConsumptionForReading(id1);
    expect(cons1, flutter_test.isNull);

    final cons2 = await repo.getConsumptionForReading(id2);
    expect(cons2, 400.0);

    final cons3 = await repo.getConsumptionForReading(id3);
    expect(cons3, 450.5);
  });

  test('ElectricityRepository updateReading modifies reading, updates updatedAt, and clears syncedAt', () async {
    final oldTime = DateTime.now().subtract(const Duration(days: 1)).toUtc().toIso8601String();

    final id1 = 'id-1';
    await db.into(db.electricityReadings).insert(
      ElectricityReadingsCompanion.insert(
        id: id1,
        readingDate: '2023-08-01',
        meterValue: 12000.0,
        billingCycle: 'monthly',
        createdAt: oldTime,
        updatedAt: oldTime,
        syncedAt: Value(oldTime),
      )
    );

    await repo.updateReading(id1, const ElectricityReadingsCompanion(
      meterValue: Value(12010.0),
      note: Value('Corrected'),
    ));

    final reading = await (db.select(db.electricityReadings)..where((t) => t.id.equals(id1))).getSingle();

    expect(reading.meterValue, 12010.0);
    expect(reading.note, 'Corrected');
    expect(reading.updatedAt, isNot(oldTime));
    expect(reading.syncedAt, flutter_test.isNull);
  });
}
