import 'package:drift/drift.dart';

class IroningPrices extends Table {
  TextColumn get id => text()();
  RealColumn get pricePerCloth => real().named('price_per_cloth')();
  TextColumn get effectiveFrom => text().named('effective_from')();
  TextColumn get note => text().nullable()();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
  TextColumn get deletedAt => text().nullable().named('deleted_at')();
  TextColumn get syncedAt => text().nullable().named('synced_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class IroningTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // regular, reset, custom
  TextColumn get date => text()();
  RealColumn get balanceBefore => real().named('balance_before')();
  RealColumn get balanceAfter => real().named('balance_after')();
  RealColumn get priceSnapshot => real().nullable().named('price_snapshot')();
  IntColumn get clothCount => integer().nullable().named('cloth_count')();
  RealColumn get totalDue => real().nullable().named('total_due')();
  RealColumn get amountPaid => real().nullable().named('amount_paid')();
  TextColumn get direction => text().nullable()(); // credit, debit
  RealColumn get amount => real().nullable()();
  TextColumn get label => text().nullable()();
  TextColumn get reason => text().nullable()();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
  TextColumn get deletedAt => text().nullable().named('deleted_at')();
  TextColumn get syncedAt => text().nullable().named('synced_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class ElectricityReadings extends Table {
  TextColumn get id => text()();
  TextColumn get readingDate => text().named('reading_date')();
  RealColumn get meterValue => real().named('meter_value')();
  TextColumn get billingCycle => text().named('billing_cycle')(); // monthly, bimonthly
  TextColumn get note => text().nullable()();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
  TextColumn get deletedAt => text().nullable().named('deleted_at')();
  TextColumn get syncedAt => text().nullable().named('synced_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class ElectricityRates extends Table {
  TextColumn get id => text()();
  RealColumn get ratePerUnit => real().named('rate_per_unit')();
  TextColumn get effectiveFrom => text().named('effective_from')();
  TextColumn get note => text().nullable()();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
  TextColumn get deletedAt => text().nullable().named('deleted_at')();
  TextColumn get syncedAt => text().nullable().named('synced_at')();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncLogs extends Table {
  TextColumn get id => text()();
  TextColumn get syncedAt => text().named('synced_at')();
  TextColumn get direction => text()(); // push, pull, full
  IntColumn get rowsPushed => integer().named('rows_pushed')();
  IntColumn get rowsPulled => integer().named('rows_pulled')();
  TextColumn get status => text()(); // success, failed
  TextColumn get error => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
