import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database.dart';

class IroningRepository {
  final AppDatabase db;
  const IroningRepository(this.db);

  Future<double> getCurrentBalance() async {
    final query = db.select(db.ironingTransactions)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ])
      ..limit(1);

    final latestTransaction = await query.getSingleOrNull();
    return latestTransaction?.balanceAfter ?? 0.0;
  }

  Future<void> addTransaction(IroningTransactionsCompanion transaction) async {
    final balanceBefore = await getCurrentBalance();

    final String type = transaction.type.value;
    double balanceAfter = balanceBefore;

    if (type == 'regular') {
      final clothCount = transaction.clothCount.value ?? 0;
      final priceSnapshot = transaction.priceSnapshot.value ?? 0.0;
      final amountPaid = transaction.amountPaid.value ?? 0.0;

      final totalDue = clothCount * priceSnapshot;
      final delta = amountPaid - totalDue;
      balanceAfter = balanceBefore + delta;
    } else if (type == 'reset') {
      balanceAfter = 0.0;
    } else if (type == 'custom') {
      final direction = transaction.direction.value;
      final amount = transaction.amount.value ?? 0.0;

      if (direction == 'credit') {
        balanceAfter = balanceBefore + amount;
      } else if (direction == 'debit') {
        balanceAfter = balanceBefore - amount;
      }
    }

    final id = const Uuid().v4();
    final now = DateTime.now().toUtc().toIso8601String();

    await db.into(db.ironingTransactions).insert(
      transaction.copyWith(
        id: Value(id),
        balanceBefore: Value(balanceBefore),
        balanceAfter: Value(balanceAfter),
        createdAt: Value(now),
        updatedAt: Value(now),
      )
    );
  }

  Future<double?> getActivePrice(String date) async {
    final query = db.select(db.ironingPrices)
      ..where((t) => t.effectiveFrom.isSmallerOrEqualValue(date))
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.effectiveFrom, mode: OrderingMode.desc)])
      ..limit(1);

    final activePriceRow = await query.getSingleOrNull();
    return activePriceRow?.pricePerCloth;
  }

  Future<List<IroningPrice>> getPriceHistory() async {
    final query = db.select(db.ironingPrices)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.effectiveFrom, mode: OrderingMode.desc)]);

    return await query.get();
  }

  Future<void> addPrice(IroningPricesCompanion price) async {
    final id = const Uuid().v4();
    final now = DateTime.now().toUtc().toIso8601String();

    await db.into(db.ironingPrices).insert(
      price.copyWith(
        id: Value(id),
        createdAt: Value(now),
        updatedAt: Value(now),
      )
    );
  }

  Future<List<IroningTransaction>> getRecentTransactions(int limit) async {
    final query = db.select(db.ironingTransactions)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ])
      ..limit(limit);

    return await query.get();
  }

  Future<List<IroningTransaction>> getAllTransactions() async {
    final query = db.select(db.ironingTransactions)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);

    return await query.get();
  }
}
