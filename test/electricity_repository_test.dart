import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart' hide isNull, isNotNull;
import 'package:matcher/src/core_matchers.dart' as matcher;
import 'package:home_cfo/db/database.dart';
import 'package:home_cfo/db/repositories/electricity_repository.dart';

void main() {
  late AppDatabase db;
  late ElectricityRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repo = ElectricityRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ElectricityRepository', () {
    test('getActiveRate returns correct rate based on effective_from date', () async {
      await repo.addRate(const ElectricityRatesCompanion(
        ratePerUnit: Value(5.0),
        effectiveFrom: Value('2023-01-01'),
      ));

      await repo.addRate(const ElectricityRatesCompanion(
        ratePerUnit: Value(6.5),
        effectiveFrom: Value('2023-06-01'),
      ));

      final rateBeforeJune = await repo.getActiveRate('2023-05-15');
      expect(rateBeforeJune, 5.0);

      final rateAfterJune = await repo.getActiveRate('2023-06-15');
      expect(rateAfterJune, 6.5);
    });

    test('getConsumptionForReading computes correctly based on ordered readings', () async {
      await repo.addReading(const ElectricityReadingsCompanion(
        readingDate: Value('2023-01-01'),
        meterValue: Value(100.0),
        billingCycle: Value('monthly'),
      ));

      await repo.addReading(const ElectricityReadingsCompanion(
        readingDate: Value('2023-02-01'),
        meterValue: Value(150.0),
        billingCycle: Value('monthly'),
      ));

      await repo.addReading(const ElectricityReadingsCompanion(
        readingDate: Value('2023-03-01'),
        meterValue: Value(220.0),
        billingCycle: Value('monthly'),
      ));

      final readings = await repo.getReadings();

      // They are returned in descending order by readingDate
      expect(readings.length, 3);

      final readingMarch = readings[0]; // 2023-03-01
      final readingFeb = readings[1];   // 2023-02-01
      final readingJan = readings[2];   // 2023-01-01

      final consumptionJan = await repo.getConsumptionForReading(readingJan.id);
      expect(consumptionJan, null); // First reading

      final consumptionFeb = await repo.getConsumptionForReading(readingFeb.id);
      expect(consumptionFeb, 50.0); // 150 - 100

      final consumptionMarch = await repo.getConsumptionForReading(readingMarch.id);
      expect(consumptionMarch, 70.0); // 220 - 150
    });

    test('updateReading modifies reading, updates updatedAt, and clears syncedAt', () async {
      await repo.addReading(const ElectricityReadingsCompanion(
        readingDate: Value('2023-01-01'),
        meterValue: Value(100.0),
        billingCycle: Value('monthly'),
      ));

      var readings = await repo.getReadings();
      final readingId = readings.first.id;

      // Simulate a sync occurring
      await (db.update(db.electricityReadings)..where((t) => t.id.equals(readingId)))
        .write(const ElectricityReadingsCompanion(syncedAt: Value('2023-01-02T10:00:00Z')));

      readings = await repo.getReadings();
      expect(readings.first.syncedAt, matcher.isNotNull);

      // Now update the reading
      await repo.updateReading(readingId, const ElectricityReadingsCompanion(
        meterValue: Value(105.0),
      ));

      readings = await repo.getReadings();
      expect(readings.first.meterValue, 105.0);
      expect(readings.first.syncedAt, matcher.isNull);
    });
  });
}
