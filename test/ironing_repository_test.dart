import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_cfo/db/database.dart';
import 'package:home_cfo/db/repositories/ironing_repository.dart';

void main() {
  late AppDatabase db;
  late IroningRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repo = IroningRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('IroningRepository', () {
    test('getActivePrice returns correct price based on effective_from date', () async {
      await repo.addPrice(const IroningPricesCompanion(
        pricePerCloth: Value(10.0),
        effectiveFrom: Value('2023-01-01'),
      ));

      await repo.addPrice(const IroningPricesCompanion(
        pricePerCloth: Value(12.0),
        effectiveFrom: Value('2023-06-01'),
      ));

      final priceBeforeJune = await repo.getActivePrice('2023-05-15');
      expect(priceBeforeJune, 10.0);

      final priceAfterJune = await repo.getActivePrice('2023-06-15');
      expect(priceAfterJune, 12.0);

      final priceOnJune = await repo.getActivePrice('2023-06-01');
      expect(priceOnJune, 12.0);
    });

    test('addTransaction: regular transaction updates balance correctly', () async {
      // Starts at 0 balance
      await repo.addTransaction(const IroningTransactionsCompanion(
        type: Value('regular'),
        date: Value('2023-01-01'),
        clothCount: Value(10),
        priceSnapshot: Value(10.0), // total due 100
        amountPaid: Value(120.0),   // overpaid by 20 -> credit
      ));

      var currentBalance = await repo.getCurrentBalance();
      expect(currentBalance, 20.0);

      await repo.addTransaction(const IroningTransactionsCompanion(
        type: Value('regular'),
        date: Value('2023-01-02'),
        clothCount: Value(5),
        priceSnapshot: Value(10.0), // total due 50
        amountPaid: Value(0.0),     // underpaid by 50 -> debt
      ));

      currentBalance = await repo.getCurrentBalance();
      expect(currentBalance, -30.0); // 20 - 50
    });

    test('addTransaction: reset transaction resets balance to zero', () async {
      await repo.addTransaction(const IroningTransactionsCompanion(
        type: Value('custom'),
        date: Value('2023-01-01'),
        direction: Value('credit'),
        amount: Value(50.0),
      ));

      var currentBalance = await repo.getCurrentBalance();
      expect(currentBalance, 50.0);

      await repo.addTransaction(const IroningTransactionsCompanion(
        type: Value('reset'),
        date: Value('2023-01-02'),
        reason: Value('Monthly reset'),
      ));

      currentBalance = await repo.getCurrentBalance();
      expect(currentBalance, 0.0);
    });

    test('addTransaction: custom transaction adds or subtracts correctly', () async {
      await repo.addTransaction(const IroningTransactionsCompanion(
        type: Value('custom'),
        date: Value('2023-01-01'),
        direction: Value('credit'),
        amount: Value(100.0),
      ));

      var currentBalance = await repo.getCurrentBalance();
      expect(currentBalance, 100.0);

      await repo.addTransaction(const IroningTransactionsCompanion(
        type: Value('custom'),
        date: Value('2023-01-02'),
        direction: Value('debit'),
        amount: Value(30.0),
      ));

      currentBalance = await repo.getCurrentBalance();
      expect(currentBalance, 70.0);
    });

    test('addTransaction: validates transaction type is present', () async {
      expect(
        () => repo.addTransaction(const IroningTransactionsCompanion(
          date: Value('2023-01-01'),
        )),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', 'Transaction type is required.')),
      );
    });

    test('addTransaction: validates transaction type value', () async {
      expect(
        () => repo.addTransaction(const IroningTransactionsCompanion(
          type: Value('invalid_type'),
          date: Value('2023-01-01'),
        )),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', 'Invalid transaction type: invalid_type')),
      );
    });

    test('addTransaction: validates direction is present for custom transaction', () async {
      expect(
        () => repo.addTransaction(const IroningTransactionsCompanion(
          type: Value('custom'),
          date: Value('2023-01-01'),
        )),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', 'Direction is required for custom transactions.')),
      );
    });

    test('addTransaction: validates direction value for custom transaction', () async {
      expect(
        () => repo.addTransaction(const IroningTransactionsCompanion(
          type: Value('custom'),
          date: Value('2023-01-01'),
          direction: Value('invalid_direction'),
        )),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', 'Invalid direction for custom transaction: invalid_direction')),
      );
    });
  });
}
