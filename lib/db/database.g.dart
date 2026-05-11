// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $IroningPricesTable extends IroningPrices
    with TableInfo<$IroningPricesTable, IroningPrice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IroningPricesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pricePerClothMeta =
      const VerificationMeta('pricePerCloth');
  @override
  late final GeneratedColumn<double> pricePerCloth = GeneratedColumn<double>(
      'price_per_cloth', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _effectiveFromMeta =
      const VerificationMeta('effectiveFrom');
  @override
  late final GeneratedColumn<String> effectiveFrom = GeneratedColumn<String>(
      'effective_from', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<String> syncedAt = GeneratedColumn<String>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        pricePerCloth,
        effectiveFrom,
        note,
        createdAt,
        updatedAt,
        deletedAt,
        syncedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ironing_prices';
  @override
  VerificationContext validateIntegrity(Insertable<IroningPrice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('price_per_cloth')) {
      context.handle(
          _pricePerClothMeta,
          pricePerCloth.isAcceptableOrUnknown(
              data['price_per_cloth']!, _pricePerClothMeta));
    } else if (isInserting) {
      context.missing(_pricePerClothMeta);
    }
    if (data.containsKey('effective_from')) {
      context.handle(
          _effectiveFromMeta,
          effectiveFrom.isAcceptableOrUnknown(
              data['effective_from']!, _effectiveFromMeta));
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IroningPrice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IroningPrice(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      pricePerCloth: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}price_per_cloth'])!,
      effectiveFrom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}effective_from'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deleted_at']),
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}synced_at']),
    );
  }

  @override
  $IroningPricesTable createAlias(String alias) {
    return $IroningPricesTable(attachedDatabase, alias);
  }
}

class IroningPrice extends DataClass implements Insertable<IroningPrice> {
  final String id;
  final double pricePerCloth;
  final String effectiveFrom;
  final String? note;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? syncedAt;
  const IroningPrice(
      {required this.id,
      required this.pricePerCloth,
      required this.effectiveFrom,
      this.note,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.syncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['price_per_cloth'] = Variable<double>(pricePerCloth);
    map['effective_from'] = Variable<String>(effectiveFrom);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<String>(syncedAt);
    }
    return map;
  }

  IroningPricesCompanion toCompanion(bool nullToAbsent) {
    return IroningPricesCompanion(
      id: Value(id),
      pricePerCloth: Value(pricePerCloth),
      effectiveFrom: Value(effectiveFrom),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory IroningPrice.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IroningPrice(
      id: serializer.fromJson<String>(json['id']),
      pricePerCloth: serializer.fromJson<double>(json['pricePerCloth']),
      effectiveFrom: serializer.fromJson<String>(json['effectiveFrom']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      syncedAt: serializer.fromJson<String?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pricePerCloth': serializer.toJson<double>(pricePerCloth),
      'effectiveFrom': serializer.toJson<String>(effectiveFrom),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'syncedAt': serializer.toJson<String?>(syncedAt),
    };
  }

  IroningPrice copyWith(
          {String? id,
          double? pricePerCloth,
          String? effectiveFrom,
          Value<String?> note = const Value.absent(),
          String? createdAt,
          String? updatedAt,
          Value<String?> deletedAt = const Value.absent(),
          Value<String?> syncedAt = const Value.absent()}) =>
      IroningPrice(
        id: id ?? this.id,
        pricePerCloth: pricePerCloth ?? this.pricePerCloth,
        effectiveFrom: effectiveFrom ?? this.effectiveFrom,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
      );
  IroningPrice copyWithCompanion(IroningPricesCompanion data) {
    return IroningPrice(
      id: data.id.present ? data.id.value : this.id,
      pricePerCloth: data.pricePerCloth.present
          ? data.pricePerCloth.value
          : this.pricePerCloth,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IroningPrice(')
          ..write('id: $id, ')
          ..write('pricePerCloth: $pricePerCloth, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pricePerCloth, effectiveFrom, note,
      createdAt, updatedAt, deletedAt, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IroningPrice &&
          other.id == this.id &&
          other.pricePerCloth == this.pricePerCloth &&
          other.effectiveFrom == this.effectiveFrom &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncedAt == this.syncedAt);
}

class IroningPricesCompanion extends UpdateCompanion<IroningPrice> {
  final Value<String> id;
  final Value<double> pricePerCloth;
  final Value<String> effectiveFrom;
  final Value<String?> note;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<String?> syncedAt;
  final Value<int> rowid;
  const IroningPricesCompanion({
    this.id = const Value.absent(),
    this.pricePerCloth = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IroningPricesCompanion.insert({
    required String id,
    required double pricePerCloth,
    required String effectiveFrom,
    this.note = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        pricePerCloth = Value(pricePerCloth),
        effectiveFrom = Value(effectiveFrom),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<IroningPrice> custom({
    Expression<String>? id,
    Expression<double>? pricePerCloth,
    Expression<String>? effectiveFrom,
    Expression<String>? note,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<String>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pricePerCloth != null) 'price_per_cloth': pricePerCloth,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IroningPricesCompanion copyWith(
      {Value<String>? id,
      Value<double>? pricePerCloth,
      Value<String>? effectiveFrom,
      Value<String?>? note,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String?>? deletedAt,
      Value<String?>? syncedAt,
      Value<int>? rowid}) {
    return IroningPricesCompanion(
      id: id ?? this.id,
      pricePerCloth: pricePerCloth ?? this.pricePerCloth,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pricePerCloth.present) {
      map['price_per_cloth'] = Variable<double>(pricePerCloth.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<String>(effectiveFrom.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<String>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IroningPricesCompanion(')
          ..write('id: $id, ')
          ..write('pricePerCloth: $pricePerCloth, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IroningTransactionsTable extends IroningTransactions
    with TableInfo<$IroningTransactionsTable, IroningTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IroningTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _balanceBeforeMeta =
      const VerificationMeta('balanceBefore');
  @override
  late final GeneratedColumn<double> balanceBefore = GeneratedColumn<double>(
      'balance_before', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _balanceAfterMeta =
      const VerificationMeta('balanceAfter');
  @override
  late final GeneratedColumn<double> balanceAfter = GeneratedColumn<double>(
      'balance_after', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _priceSnapshotMeta =
      const VerificationMeta('priceSnapshot');
  @override
  late final GeneratedColumn<double> priceSnapshot = GeneratedColumn<double>(
      'price_snapshot', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _clothCountMeta =
      const VerificationMeta('clothCount');
  @override
  late final GeneratedColumn<int> clothCount = GeneratedColumn<int>(
      'cloth_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalDueMeta =
      const VerificationMeta('totalDue');
  @override
  late final GeneratedColumn<double> totalDue = GeneratedColumn<double>(
      'total_due', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _amountPaidMeta =
      const VerificationMeta('amountPaid');
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
      'amount_paid', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
      'direction', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<String> syncedAt = GeneratedColumn<String>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        date,
        balanceBefore,
        balanceAfter,
        priceSnapshot,
        clothCount,
        totalDue,
        amountPaid,
        direction,
        amount,
        label,
        reason,
        createdAt,
        updatedAt,
        deletedAt,
        syncedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ironing_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<IroningTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('balance_before')) {
      context.handle(
          _balanceBeforeMeta,
          balanceBefore.isAcceptableOrUnknown(
              data['balance_before']!, _balanceBeforeMeta));
    } else if (isInserting) {
      context.missing(_balanceBeforeMeta);
    }
    if (data.containsKey('balance_after')) {
      context.handle(
          _balanceAfterMeta,
          balanceAfter.isAcceptableOrUnknown(
              data['balance_after']!, _balanceAfterMeta));
    } else if (isInserting) {
      context.missing(_balanceAfterMeta);
    }
    if (data.containsKey('price_snapshot')) {
      context.handle(
          _priceSnapshotMeta,
          priceSnapshot.isAcceptableOrUnknown(
              data['price_snapshot']!, _priceSnapshotMeta));
    }
    if (data.containsKey('cloth_count')) {
      context.handle(
          _clothCountMeta,
          clothCount.isAcceptableOrUnknown(
              data['cloth_count']!, _clothCountMeta));
    }
    if (data.containsKey('total_due')) {
      context.handle(_totalDueMeta,
          totalDue.isAcceptableOrUnknown(data['total_due']!, _totalDueMeta));
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
          _amountPaidMeta,
          amountPaid.isAcceptableOrUnknown(
              data['amount_paid']!, _amountPaidMeta));
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IroningTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IroningTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      balanceBefore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}balance_before'])!,
      balanceAfter: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}balance_after'])!,
      priceSnapshot: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price_snapshot']),
      clothCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cloth_count']),
      totalDue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_due']),
      amountPaid: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount_paid']),
      direction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}direction']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount']),
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label']),
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deleted_at']),
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}synced_at']),
    );
  }

  @override
  $IroningTransactionsTable createAlias(String alias) {
    return $IroningTransactionsTable(attachedDatabase, alias);
  }
}

class IroningTransaction extends DataClass
    implements Insertable<IroningTransaction> {
  final String id;
  final String type;
  final String date;
  final double balanceBefore;
  final double balanceAfter;
  final double? priceSnapshot;
  final int? clothCount;
  final double? totalDue;
  final double? amountPaid;
  final String? direction;
  final double? amount;
  final String? label;
  final String? reason;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? syncedAt;
  const IroningTransaction(
      {required this.id,
      required this.type,
      required this.date,
      required this.balanceBefore,
      required this.balanceAfter,
      this.priceSnapshot,
      this.clothCount,
      this.totalDue,
      this.amountPaid,
      this.direction,
      this.amount,
      this.label,
      this.reason,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.syncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<String>(date);
    map['balance_before'] = Variable<double>(balanceBefore);
    map['balance_after'] = Variable<double>(balanceAfter);
    if (!nullToAbsent || priceSnapshot != null) {
      map['price_snapshot'] = Variable<double>(priceSnapshot);
    }
    if (!nullToAbsent || clothCount != null) {
      map['cloth_count'] = Variable<int>(clothCount);
    }
    if (!nullToAbsent || totalDue != null) {
      map['total_due'] = Variable<double>(totalDue);
    }
    if (!nullToAbsent || amountPaid != null) {
      map['amount_paid'] = Variable<double>(amountPaid);
    }
    if (!nullToAbsent || direction != null) {
      map['direction'] = Variable<String>(direction);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<String>(syncedAt);
    }
    return map;
  }

  IroningTransactionsCompanion toCompanion(bool nullToAbsent) {
    return IroningTransactionsCompanion(
      id: Value(id),
      type: Value(type),
      date: Value(date),
      balanceBefore: Value(balanceBefore),
      balanceAfter: Value(balanceAfter),
      priceSnapshot: priceSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(priceSnapshot),
      clothCount: clothCount == null && nullToAbsent
          ? const Value.absent()
          : Value(clothCount),
      totalDue: totalDue == null && nullToAbsent
          ? const Value.absent()
          : Value(totalDue),
      amountPaid: amountPaid == null && nullToAbsent
          ? const Value.absent()
          : Value(amountPaid),
      direction: direction == null && nullToAbsent
          ? const Value.absent()
          : Value(direction),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory IroningTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IroningTransaction(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<String>(json['date']),
      balanceBefore: serializer.fromJson<double>(json['balanceBefore']),
      balanceAfter: serializer.fromJson<double>(json['balanceAfter']),
      priceSnapshot: serializer.fromJson<double?>(json['priceSnapshot']),
      clothCount: serializer.fromJson<int?>(json['clothCount']),
      totalDue: serializer.fromJson<double?>(json['totalDue']),
      amountPaid: serializer.fromJson<double?>(json['amountPaid']),
      direction: serializer.fromJson<String?>(json['direction']),
      amount: serializer.fromJson<double?>(json['amount']),
      label: serializer.fromJson<String?>(json['label']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      syncedAt: serializer.fromJson<String?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<String>(date),
      'balanceBefore': serializer.toJson<double>(balanceBefore),
      'balanceAfter': serializer.toJson<double>(balanceAfter),
      'priceSnapshot': serializer.toJson<double?>(priceSnapshot),
      'clothCount': serializer.toJson<int?>(clothCount),
      'totalDue': serializer.toJson<double?>(totalDue),
      'amountPaid': serializer.toJson<double?>(amountPaid),
      'direction': serializer.toJson<String?>(direction),
      'amount': serializer.toJson<double?>(amount),
      'label': serializer.toJson<String?>(label),
      'reason': serializer.toJson<String?>(reason),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'syncedAt': serializer.toJson<String?>(syncedAt),
    };
  }

  IroningTransaction copyWith(
          {String? id,
          String? type,
          String? date,
          double? balanceBefore,
          double? balanceAfter,
          Value<double?> priceSnapshot = const Value.absent(),
          Value<int?> clothCount = const Value.absent(),
          Value<double?> totalDue = const Value.absent(),
          Value<double?> amountPaid = const Value.absent(),
          Value<String?> direction = const Value.absent(),
          Value<double?> amount = const Value.absent(),
          Value<String?> label = const Value.absent(),
          Value<String?> reason = const Value.absent(),
          String? createdAt,
          String? updatedAt,
          Value<String?> deletedAt = const Value.absent(),
          Value<String?> syncedAt = const Value.absent()}) =>
      IroningTransaction(
        id: id ?? this.id,
        type: type ?? this.type,
        date: date ?? this.date,
        balanceBefore: balanceBefore ?? this.balanceBefore,
        balanceAfter: balanceAfter ?? this.balanceAfter,
        priceSnapshot:
            priceSnapshot.present ? priceSnapshot.value : this.priceSnapshot,
        clothCount: clothCount.present ? clothCount.value : this.clothCount,
        totalDue: totalDue.present ? totalDue.value : this.totalDue,
        amountPaid: amountPaid.present ? amountPaid.value : this.amountPaid,
        direction: direction.present ? direction.value : this.direction,
        amount: amount.present ? amount.value : this.amount,
        label: label.present ? label.value : this.label,
        reason: reason.present ? reason.value : this.reason,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
      );
  IroningTransaction copyWithCompanion(IroningTransactionsCompanion data) {
    return IroningTransaction(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      balanceBefore: data.balanceBefore.present
          ? data.balanceBefore.value
          : this.balanceBefore,
      balanceAfter: data.balanceAfter.present
          ? data.balanceAfter.value
          : this.balanceAfter,
      priceSnapshot: data.priceSnapshot.present
          ? data.priceSnapshot.value
          : this.priceSnapshot,
      clothCount:
          data.clothCount.present ? data.clothCount.value : this.clothCount,
      totalDue: data.totalDue.present ? data.totalDue.value : this.totalDue,
      amountPaid:
          data.amountPaid.present ? data.amountPaid.value : this.amountPaid,
      direction: data.direction.present ? data.direction.value : this.direction,
      amount: data.amount.present ? data.amount.value : this.amount,
      label: data.label.present ? data.label.value : this.label,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IroningTransaction(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('balanceBefore: $balanceBefore, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('priceSnapshot: $priceSnapshot, ')
          ..write('clothCount: $clothCount, ')
          ..write('totalDue: $totalDue, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('direction: $direction, ')
          ..write('amount: $amount, ')
          ..write('label: $label, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      type,
      date,
      balanceBefore,
      balanceAfter,
      priceSnapshot,
      clothCount,
      totalDue,
      amountPaid,
      direction,
      amount,
      label,
      reason,
      createdAt,
      updatedAt,
      deletedAt,
      syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IroningTransaction &&
          other.id == this.id &&
          other.type == this.type &&
          other.date == this.date &&
          other.balanceBefore == this.balanceBefore &&
          other.balanceAfter == this.balanceAfter &&
          other.priceSnapshot == this.priceSnapshot &&
          other.clothCount == this.clothCount &&
          other.totalDue == this.totalDue &&
          other.amountPaid == this.amountPaid &&
          other.direction == this.direction &&
          other.amount == this.amount &&
          other.label == this.label &&
          other.reason == this.reason &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncedAt == this.syncedAt);
}

class IroningTransactionsCompanion extends UpdateCompanion<IroningTransaction> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> date;
  final Value<double> balanceBefore;
  final Value<double> balanceAfter;
  final Value<double?> priceSnapshot;
  final Value<int?> clothCount;
  final Value<double?> totalDue;
  final Value<double?> amountPaid;
  final Value<String?> direction;
  final Value<double?> amount;
  final Value<String?> label;
  final Value<String?> reason;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<String?> syncedAt;
  final Value<int> rowid;
  const IroningTransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.balanceBefore = const Value.absent(),
    this.balanceAfter = const Value.absent(),
    this.priceSnapshot = const Value.absent(),
    this.clothCount = const Value.absent(),
    this.totalDue = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.direction = const Value.absent(),
    this.amount = const Value.absent(),
    this.label = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IroningTransactionsCompanion.insert({
    required String id,
    required String type,
    required String date,
    required double balanceBefore,
    required double balanceAfter,
    this.priceSnapshot = const Value.absent(),
    this.clothCount = const Value.absent(),
    this.totalDue = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.direction = const Value.absent(),
    this.amount = const Value.absent(),
    this.label = const Value.absent(),
    this.reason = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        date = Value(date),
        balanceBefore = Value(balanceBefore),
        balanceAfter = Value(balanceAfter),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<IroningTransaction> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? date,
    Expression<double>? balanceBefore,
    Expression<double>? balanceAfter,
    Expression<double>? priceSnapshot,
    Expression<int>? clothCount,
    Expression<double>? totalDue,
    Expression<double>? amountPaid,
    Expression<String>? direction,
    Expression<double>? amount,
    Expression<String>? label,
    Expression<String>? reason,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<String>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (balanceBefore != null) 'balance_before': balanceBefore,
      if (balanceAfter != null) 'balance_after': balanceAfter,
      if (priceSnapshot != null) 'price_snapshot': priceSnapshot,
      if (clothCount != null) 'cloth_count': clothCount,
      if (totalDue != null) 'total_due': totalDue,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (direction != null) 'direction': direction,
      if (amount != null) 'amount': amount,
      if (label != null) 'label': label,
      if (reason != null) 'reason': reason,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IroningTransactionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<String>? date,
      Value<double>? balanceBefore,
      Value<double>? balanceAfter,
      Value<double?>? priceSnapshot,
      Value<int?>? clothCount,
      Value<double?>? totalDue,
      Value<double?>? amountPaid,
      Value<String?>? direction,
      Value<double?>? amount,
      Value<String?>? label,
      Value<String?>? reason,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String?>? deletedAt,
      Value<String?>? syncedAt,
      Value<int>? rowid}) {
    return IroningTransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      date: date ?? this.date,
      balanceBefore: balanceBefore ?? this.balanceBefore,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      priceSnapshot: priceSnapshot ?? this.priceSnapshot,
      clothCount: clothCount ?? this.clothCount,
      totalDue: totalDue ?? this.totalDue,
      amountPaid: amountPaid ?? this.amountPaid,
      direction: direction ?? this.direction,
      amount: amount ?? this.amount,
      label: label ?? this.label,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (balanceBefore.present) {
      map['balance_before'] = Variable<double>(balanceBefore.value);
    }
    if (balanceAfter.present) {
      map['balance_after'] = Variable<double>(balanceAfter.value);
    }
    if (priceSnapshot.present) {
      map['price_snapshot'] = Variable<double>(priceSnapshot.value);
    }
    if (clothCount.present) {
      map['cloth_count'] = Variable<int>(clothCount.value);
    }
    if (totalDue.present) {
      map['total_due'] = Variable<double>(totalDue.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<String>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IroningTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('balanceBefore: $balanceBefore, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('priceSnapshot: $priceSnapshot, ')
          ..write('clothCount: $clothCount, ')
          ..write('totalDue: $totalDue, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('direction: $direction, ')
          ..write('amount: $amount, ')
          ..write('label: $label, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ElectricityReadingsTable extends ElectricityReadings
    with TableInfo<$ElectricityReadingsTable, ElectricityReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElectricityReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _readingDateMeta =
      const VerificationMeta('readingDate');
  @override
  late final GeneratedColumn<String> readingDate = GeneratedColumn<String>(
      'reading_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _meterValueMeta =
      const VerificationMeta('meterValue');
  @override
  late final GeneratedColumn<double> meterValue = GeneratedColumn<double>(
      'meter_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _billingCycleMeta =
      const VerificationMeta('billingCycle');
  @override
  late final GeneratedColumn<String> billingCycle = GeneratedColumn<String>(
      'billing_cycle', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<String> syncedAt = GeneratedColumn<String>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        readingDate,
        meterValue,
        billingCycle,
        note,
        createdAt,
        updatedAt,
        deletedAt,
        syncedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'electricity_readings';
  @override
  VerificationContext validateIntegrity(Insertable<ElectricityReading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('reading_date')) {
      context.handle(
          _readingDateMeta,
          readingDate.isAcceptableOrUnknown(
              data['reading_date']!, _readingDateMeta));
    } else if (isInserting) {
      context.missing(_readingDateMeta);
    }
    if (data.containsKey('meter_value')) {
      context.handle(
          _meterValueMeta,
          meterValue.isAcceptableOrUnknown(
              data['meter_value']!, _meterValueMeta));
    } else if (isInserting) {
      context.missing(_meterValueMeta);
    }
    if (data.containsKey('billing_cycle')) {
      context.handle(
          _billingCycleMeta,
          billingCycle.isAcceptableOrUnknown(
              data['billing_cycle']!, _billingCycleMeta));
    } else if (isInserting) {
      context.missing(_billingCycleMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ElectricityReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ElectricityReading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      readingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reading_date'])!,
      meterValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}meter_value'])!,
      billingCycle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}billing_cycle'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deleted_at']),
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}synced_at']),
    );
  }

  @override
  $ElectricityReadingsTable createAlias(String alias) {
    return $ElectricityReadingsTable(attachedDatabase, alias);
  }
}

class ElectricityReading extends DataClass
    implements Insertable<ElectricityReading> {
  final String id;
  final String readingDate;
  final double meterValue;
  final String billingCycle;
  final String? note;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? syncedAt;
  const ElectricityReading(
      {required this.id,
      required this.readingDate,
      required this.meterValue,
      required this.billingCycle,
      this.note,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.syncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['reading_date'] = Variable<String>(readingDate);
    map['meter_value'] = Variable<double>(meterValue);
    map['billing_cycle'] = Variable<String>(billingCycle);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<String>(syncedAt);
    }
    return map;
  }

  ElectricityReadingsCompanion toCompanion(bool nullToAbsent) {
    return ElectricityReadingsCompanion(
      id: Value(id),
      readingDate: Value(readingDate),
      meterValue: Value(meterValue),
      billingCycle: Value(billingCycle),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory ElectricityReading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ElectricityReading(
      id: serializer.fromJson<String>(json['id']),
      readingDate: serializer.fromJson<String>(json['readingDate']),
      meterValue: serializer.fromJson<double>(json['meterValue']),
      billingCycle: serializer.fromJson<String>(json['billingCycle']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      syncedAt: serializer.fromJson<String?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'readingDate': serializer.toJson<String>(readingDate),
      'meterValue': serializer.toJson<double>(meterValue),
      'billingCycle': serializer.toJson<String>(billingCycle),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'syncedAt': serializer.toJson<String?>(syncedAt),
    };
  }

  ElectricityReading copyWith(
          {String? id,
          String? readingDate,
          double? meterValue,
          String? billingCycle,
          Value<String?> note = const Value.absent(),
          String? createdAt,
          String? updatedAt,
          Value<String?> deletedAt = const Value.absent(),
          Value<String?> syncedAt = const Value.absent()}) =>
      ElectricityReading(
        id: id ?? this.id,
        readingDate: readingDate ?? this.readingDate,
        meterValue: meterValue ?? this.meterValue,
        billingCycle: billingCycle ?? this.billingCycle,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
      );
  ElectricityReading copyWithCompanion(ElectricityReadingsCompanion data) {
    return ElectricityReading(
      id: data.id.present ? data.id.value : this.id,
      readingDate:
          data.readingDate.present ? data.readingDate.value : this.readingDate,
      meterValue:
          data.meterValue.present ? data.meterValue.value : this.meterValue,
      billingCycle: data.billingCycle.present
          ? data.billingCycle.value
          : this.billingCycle,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ElectricityReading(')
          ..write('id: $id, ')
          ..write('readingDate: $readingDate, ')
          ..write('meterValue: $meterValue, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, readingDate, meterValue, billingCycle,
      note, createdAt, updatedAt, deletedAt, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ElectricityReading &&
          other.id == this.id &&
          other.readingDate == this.readingDate &&
          other.meterValue == this.meterValue &&
          other.billingCycle == this.billingCycle &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncedAt == this.syncedAt);
}

class ElectricityReadingsCompanion extends UpdateCompanion<ElectricityReading> {
  final Value<String> id;
  final Value<String> readingDate;
  final Value<double> meterValue;
  final Value<String> billingCycle;
  final Value<String?> note;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<String?> syncedAt;
  final Value<int> rowid;
  const ElectricityReadingsCompanion({
    this.id = const Value.absent(),
    this.readingDate = const Value.absent(),
    this.meterValue = const Value.absent(),
    this.billingCycle = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ElectricityReadingsCompanion.insert({
    required String id,
    required String readingDate,
    required double meterValue,
    required String billingCycle,
    this.note = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        readingDate = Value(readingDate),
        meterValue = Value(meterValue),
        billingCycle = Value(billingCycle),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ElectricityReading> custom({
    Expression<String>? id,
    Expression<String>? readingDate,
    Expression<double>? meterValue,
    Expression<String>? billingCycle,
    Expression<String>? note,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<String>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (readingDate != null) 'reading_date': readingDate,
      if (meterValue != null) 'meter_value': meterValue,
      if (billingCycle != null) 'billing_cycle': billingCycle,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ElectricityReadingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? readingDate,
      Value<double>? meterValue,
      Value<String>? billingCycle,
      Value<String?>? note,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String?>? deletedAt,
      Value<String?>? syncedAt,
      Value<int>? rowid}) {
    return ElectricityReadingsCompanion(
      id: id ?? this.id,
      readingDate: readingDate ?? this.readingDate,
      meterValue: meterValue ?? this.meterValue,
      billingCycle: billingCycle ?? this.billingCycle,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (readingDate.present) {
      map['reading_date'] = Variable<String>(readingDate.value);
    }
    if (meterValue.present) {
      map['meter_value'] = Variable<double>(meterValue.value);
    }
    if (billingCycle.present) {
      map['billing_cycle'] = Variable<String>(billingCycle.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<String>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElectricityReadingsCompanion(')
          ..write('id: $id, ')
          ..write('readingDate: $readingDate, ')
          ..write('meterValue: $meterValue, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ElectricityRatesTable extends ElectricityRates
    with TableInfo<$ElectricityRatesTable, ElectricityRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElectricityRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ratePerUnitMeta =
      const VerificationMeta('ratePerUnit');
  @override
  late final GeneratedColumn<double> ratePerUnit = GeneratedColumn<double>(
      'rate_per_unit', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _effectiveFromMeta =
      const VerificationMeta('effectiveFrom');
  @override
  late final GeneratedColumn<String> effectiveFrom = GeneratedColumn<String>(
      'effective_from', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<String> syncedAt = GeneratedColumn<String>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        ratePerUnit,
        effectiveFrom,
        note,
        createdAt,
        updatedAt,
        deletedAt,
        syncedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'electricity_rates';
  @override
  VerificationContext validateIntegrity(Insertable<ElectricityRate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('rate_per_unit')) {
      context.handle(
          _ratePerUnitMeta,
          ratePerUnit.isAcceptableOrUnknown(
              data['rate_per_unit']!, _ratePerUnitMeta));
    } else if (isInserting) {
      context.missing(_ratePerUnitMeta);
    }
    if (data.containsKey('effective_from')) {
      context.handle(
          _effectiveFromMeta,
          effectiveFrom.isAcceptableOrUnknown(
              data['effective_from']!, _effectiveFromMeta));
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ElectricityRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ElectricityRate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ratePerUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate_per_unit'])!,
      effectiveFrom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}effective_from'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deleted_at']),
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}synced_at']),
    );
  }

  @override
  $ElectricityRatesTable createAlias(String alias) {
    return $ElectricityRatesTable(attachedDatabase, alias);
  }
}

class ElectricityRate extends DataClass implements Insertable<ElectricityRate> {
  final String id;
  final double ratePerUnit;
  final String effectiveFrom;
  final String? note;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? syncedAt;
  const ElectricityRate(
      {required this.id,
      required this.ratePerUnit,
      required this.effectiveFrom,
      this.note,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.syncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['rate_per_unit'] = Variable<double>(ratePerUnit);
    map['effective_from'] = Variable<String>(effectiveFrom);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<String>(syncedAt);
    }
    return map;
  }

  ElectricityRatesCompanion toCompanion(bool nullToAbsent) {
    return ElectricityRatesCompanion(
      id: Value(id),
      ratePerUnit: Value(ratePerUnit),
      effectiveFrom: Value(effectiveFrom),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory ElectricityRate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ElectricityRate(
      id: serializer.fromJson<String>(json['id']),
      ratePerUnit: serializer.fromJson<double>(json['ratePerUnit']),
      effectiveFrom: serializer.fromJson<String>(json['effectiveFrom']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      syncedAt: serializer.fromJson<String?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ratePerUnit': serializer.toJson<double>(ratePerUnit),
      'effectiveFrom': serializer.toJson<String>(effectiveFrom),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'syncedAt': serializer.toJson<String?>(syncedAt),
    };
  }

  ElectricityRate copyWith(
          {String? id,
          double? ratePerUnit,
          String? effectiveFrom,
          Value<String?> note = const Value.absent(),
          String? createdAt,
          String? updatedAt,
          Value<String?> deletedAt = const Value.absent(),
          Value<String?> syncedAt = const Value.absent()}) =>
      ElectricityRate(
        id: id ?? this.id,
        ratePerUnit: ratePerUnit ?? this.ratePerUnit,
        effectiveFrom: effectiveFrom ?? this.effectiveFrom,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
      );
  ElectricityRate copyWithCompanion(ElectricityRatesCompanion data) {
    return ElectricityRate(
      id: data.id.present ? data.id.value : this.id,
      ratePerUnit:
          data.ratePerUnit.present ? data.ratePerUnit.value : this.ratePerUnit,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ElectricityRate(')
          ..write('id: $id, ')
          ..write('ratePerUnit: $ratePerUnit, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ratePerUnit, effectiveFrom, note,
      createdAt, updatedAt, deletedAt, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ElectricityRate &&
          other.id == this.id &&
          other.ratePerUnit == this.ratePerUnit &&
          other.effectiveFrom == this.effectiveFrom &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncedAt == this.syncedAt);
}

class ElectricityRatesCompanion extends UpdateCompanion<ElectricityRate> {
  final Value<String> id;
  final Value<double> ratePerUnit;
  final Value<String> effectiveFrom;
  final Value<String?> note;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<String?> syncedAt;
  final Value<int> rowid;
  const ElectricityRatesCompanion({
    this.id = const Value.absent(),
    this.ratePerUnit = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ElectricityRatesCompanion.insert({
    required String id,
    required double ratePerUnit,
    required String effectiveFrom,
    this.note = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ratePerUnit = Value(ratePerUnit),
        effectiveFrom = Value(effectiveFrom),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ElectricityRate> custom({
    Expression<String>? id,
    Expression<double>? ratePerUnit,
    Expression<String>? effectiveFrom,
    Expression<String>? note,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<String>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ratePerUnit != null) 'rate_per_unit': ratePerUnit,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ElectricityRatesCompanion copyWith(
      {Value<String>? id,
      Value<double>? ratePerUnit,
      Value<String>? effectiveFrom,
      Value<String?>? note,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String?>? deletedAt,
      Value<String?>? syncedAt,
      Value<int>? rowid}) {
    return ElectricityRatesCompanion(
      id: id ?? this.id,
      ratePerUnit: ratePerUnit ?? this.ratePerUnit,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ratePerUnit.present) {
      map['rate_per_unit'] = Variable<double>(ratePerUnit.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<String>(effectiveFrom.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<String>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElectricityRatesCompanion(')
          ..write('id: $id, ')
          ..write('ratePerUnit: $ratePerUnit, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncLogsTable extends SyncLogs with TableInfo<$SyncLogsTable, SyncLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<String> syncedAt = GeneratedColumn<String>(
      'synced_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
      'direction', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rowsPushedMeta =
      const VerificationMeta('rowsPushed');
  @override
  late final GeneratedColumn<int> rowsPushed = GeneratedColumn<int>(
      'rows_pushed', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rowsPulledMeta =
      const VerificationMeta('rowsPulled');
  @override
  late final GeneratedColumn<int> rowsPulled = GeneratedColumn<int>(
      'rows_pulled', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, syncedAt, direction, rowsPushed, rowsPulled, status, error];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_logs';
  @override
  VerificationContext validateIntegrity(Insertable<SyncLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('rows_pushed')) {
      context.handle(
          _rowsPushedMeta,
          rowsPushed.isAcceptableOrUnknown(
              data['rows_pushed']!, _rowsPushedMeta));
    } else if (isInserting) {
      context.missing(_rowsPushedMeta);
    }
    if (data.containsKey('rows_pulled')) {
      context.handle(
          _rowsPulledMeta,
          rowsPulled.isAcceptableOrUnknown(
              data['rows_pulled']!, _rowsPulledMeta));
    } else if (isInserting) {
      context.missing(_rowsPulledMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}synced_at'])!,
      direction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}direction'])!,
      rowsPushed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rows_pushed'])!,
      rowsPulled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rows_pulled'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error']),
    );
  }

  @override
  $SyncLogsTable createAlias(String alias) {
    return $SyncLogsTable(attachedDatabase, alias);
  }
}

class SyncLog extends DataClass implements Insertable<SyncLog> {
  final String id;
  final String syncedAt;
  final String direction;
  final int rowsPushed;
  final int rowsPulled;
  final String status;
  final String? error;
  const SyncLog(
      {required this.id,
      required this.syncedAt,
      required this.direction,
      required this.rowsPushed,
      required this.rowsPulled,
      required this.status,
      this.error});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['synced_at'] = Variable<String>(syncedAt);
    map['direction'] = Variable<String>(direction);
    map['rows_pushed'] = Variable<int>(rowsPushed);
    map['rows_pulled'] = Variable<int>(rowsPulled);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    return map;
  }

  SyncLogsCompanion toCompanion(bool nullToAbsent) {
    return SyncLogsCompanion(
      id: Value(id),
      syncedAt: Value(syncedAt),
      direction: Value(direction),
      rowsPushed: Value(rowsPushed),
      rowsPulled: Value(rowsPulled),
      status: Value(status),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
    );
  }

  factory SyncLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLog(
      id: serializer.fromJson<String>(json['id']),
      syncedAt: serializer.fromJson<String>(json['syncedAt']),
      direction: serializer.fromJson<String>(json['direction']),
      rowsPushed: serializer.fromJson<int>(json['rowsPushed']),
      rowsPulled: serializer.fromJson<int>(json['rowsPulled']),
      status: serializer.fromJson<String>(json['status']),
      error: serializer.fromJson<String?>(json['error']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'syncedAt': serializer.toJson<String>(syncedAt),
      'direction': serializer.toJson<String>(direction),
      'rowsPushed': serializer.toJson<int>(rowsPushed),
      'rowsPulled': serializer.toJson<int>(rowsPulled),
      'status': serializer.toJson<String>(status),
      'error': serializer.toJson<String?>(error),
    };
  }

  SyncLog copyWith(
          {String? id,
          String? syncedAt,
          String? direction,
          int? rowsPushed,
          int? rowsPulled,
          String? status,
          Value<String?> error = const Value.absent()}) =>
      SyncLog(
        id: id ?? this.id,
        syncedAt: syncedAt ?? this.syncedAt,
        direction: direction ?? this.direction,
        rowsPushed: rowsPushed ?? this.rowsPushed,
        rowsPulled: rowsPulled ?? this.rowsPulled,
        status: status ?? this.status,
        error: error.present ? error.value : this.error,
      );
  SyncLog copyWithCompanion(SyncLogsCompanion data) {
    return SyncLog(
      id: data.id.present ? data.id.value : this.id,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      direction: data.direction.present ? data.direction.value : this.direction,
      rowsPushed:
          data.rowsPushed.present ? data.rowsPushed.value : this.rowsPushed,
      rowsPulled:
          data.rowsPulled.present ? data.rowsPulled.value : this.rowsPulled,
      status: data.status.present ? data.status.value : this.status,
      error: data.error.present ? data.error.value : this.error,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLog(')
          ..write('id: $id, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('direction: $direction, ')
          ..write('rowsPushed: $rowsPushed, ')
          ..write('rowsPulled: $rowsPulled, ')
          ..write('status: $status, ')
          ..write('error: $error')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, syncedAt, direction, rowsPushed, rowsPulled, status, error);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLog &&
          other.id == this.id &&
          other.syncedAt == this.syncedAt &&
          other.direction == this.direction &&
          other.rowsPushed == this.rowsPushed &&
          other.rowsPulled == this.rowsPulled &&
          other.status == this.status &&
          other.error == this.error);
}

class SyncLogsCompanion extends UpdateCompanion<SyncLog> {
  final Value<String> id;
  final Value<String> syncedAt;
  final Value<String> direction;
  final Value<int> rowsPushed;
  final Value<int> rowsPulled;
  final Value<String> status;
  final Value<String?> error;
  final Value<int> rowid;
  const SyncLogsCompanion({
    this.id = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.direction = const Value.absent(),
    this.rowsPushed = const Value.absent(),
    this.rowsPulled = const Value.absent(),
    this.status = const Value.absent(),
    this.error = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncLogsCompanion.insert({
    required String id,
    required String syncedAt,
    required String direction,
    required int rowsPushed,
    required int rowsPulled,
    required String status,
    this.error = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        syncedAt = Value(syncedAt),
        direction = Value(direction),
        rowsPushed = Value(rowsPushed),
        rowsPulled = Value(rowsPulled),
        status = Value(status);
  static Insertable<SyncLog> custom({
    Expression<String>? id,
    Expression<String>? syncedAt,
    Expression<String>? direction,
    Expression<int>? rowsPushed,
    Expression<int>? rowsPulled,
    Expression<String>? status,
    Expression<String>? error,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (direction != null) 'direction': direction,
      if (rowsPushed != null) 'rows_pushed': rowsPushed,
      if (rowsPulled != null) 'rows_pulled': rowsPulled,
      if (status != null) 'status': status,
      if (error != null) 'error': error,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? syncedAt,
      Value<String>? direction,
      Value<int>? rowsPushed,
      Value<int>? rowsPulled,
      Value<String>? status,
      Value<String?>? error,
      Value<int>? rowid}) {
    return SyncLogsCompanion(
      id: id ?? this.id,
      syncedAt: syncedAt ?? this.syncedAt,
      direction: direction ?? this.direction,
      rowsPushed: rowsPushed ?? this.rowsPushed,
      rowsPulled: rowsPulled ?? this.rowsPulled,
      status: status ?? this.status,
      error: error ?? this.error,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<String>(syncedAt.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (rowsPushed.present) {
      map['rows_pushed'] = Variable<int>(rowsPushed.value);
    }
    if (rowsPulled.present) {
      map['rows_pulled'] = Variable<int>(rowsPulled.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogsCompanion(')
          ..write('id: $id, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('direction: $direction, ')
          ..write('rowsPushed: $rowsPushed, ')
          ..write('rowsPulled: $rowsPulled, ')
          ..write('status: $status, ')
          ..write('error: $error, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $IroningPricesTable ironingPrices = $IroningPricesTable(this);
  late final $IroningTransactionsTable ironingTransactions =
      $IroningTransactionsTable(this);
  late final $ElectricityReadingsTable electricityReadings =
      $ElectricityReadingsTable(this);
  late final $ElectricityRatesTable electricityRates =
      $ElectricityRatesTable(this);
  late final $SyncLogsTable syncLogs = $SyncLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        ironingPrices,
        ironingTransactions,
        electricityReadings,
        electricityRates,
        syncLogs
      ];
}

typedef $$IroningPricesTableCreateCompanionBuilder = IroningPricesCompanion
    Function({
  required String id,
  required double pricePerCloth,
  required String effectiveFrom,
  Value<String?> note,
  required String createdAt,
  required String updatedAt,
  Value<String?> deletedAt,
  Value<String?> syncedAt,
  Value<int> rowid,
});
typedef $$IroningPricesTableUpdateCompanionBuilder = IroningPricesCompanion
    Function({
  Value<String> id,
  Value<double> pricePerCloth,
  Value<String> effectiveFrom,
  Value<String?> note,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String?> deletedAt,
  Value<String?> syncedAt,
  Value<int> rowid,
});

class $$IroningPricesTableFilterComposer
    extends Composer<_$AppDatabase, $IroningPricesTable> {
  $$IroningPricesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get pricePerCloth => $composableBuilder(
      column: $table.pricePerCloth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));
}

class $$IroningPricesTableOrderingComposer
    extends Composer<_$AppDatabase, $IroningPricesTable> {
  $$IroningPricesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get pricePerCloth => $composableBuilder(
      column: $table.pricePerCloth,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));
}

class $$IroningPricesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IroningPricesTable> {
  $$IroningPricesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get pricePerCloth => $composableBuilder(
      column: $table.pricePerCloth, builder: (column) => column);

  GeneratedColumn<String> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$IroningPricesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IroningPricesTable,
    IroningPrice,
    $$IroningPricesTableFilterComposer,
    $$IroningPricesTableOrderingComposer,
    $$IroningPricesTableAnnotationComposer,
    $$IroningPricesTableCreateCompanionBuilder,
    $$IroningPricesTableUpdateCompanionBuilder,
    (
      IroningPrice,
      BaseReferences<_$AppDatabase, $IroningPricesTable, IroningPrice>
    ),
    IroningPrice,
    PrefetchHooks Function()> {
  $$IroningPricesTableTableManager(_$AppDatabase db, $IroningPricesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IroningPricesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IroningPricesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IroningPricesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<double> pricePerCloth = const Value.absent(),
            Value<String> effectiveFrom = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            Value<String?> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              IroningPricesCompanion(
            id: id,
            pricePerCloth: pricePerCloth,
            effectiveFrom: effectiveFrom,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required double pricePerCloth,
            required String effectiveFrom,
            Value<String?> note = const Value.absent(),
            required String createdAt,
            required String updatedAt,
            Value<String?> deletedAt = const Value.absent(),
            Value<String?> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              IroningPricesCompanion.insert(
            id: id,
            pricePerCloth: pricePerCloth,
            effectiveFrom: effectiveFrom,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$IroningPricesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IroningPricesTable,
    IroningPrice,
    $$IroningPricesTableFilterComposer,
    $$IroningPricesTableOrderingComposer,
    $$IroningPricesTableAnnotationComposer,
    $$IroningPricesTableCreateCompanionBuilder,
    $$IroningPricesTableUpdateCompanionBuilder,
    (
      IroningPrice,
      BaseReferences<_$AppDatabase, $IroningPricesTable, IroningPrice>
    ),
    IroningPrice,
    PrefetchHooks Function()>;
typedef $$IroningTransactionsTableCreateCompanionBuilder
    = IroningTransactionsCompanion Function({
  required String id,
  required String type,
  required String date,
  required double balanceBefore,
  required double balanceAfter,
  Value<double?> priceSnapshot,
  Value<int?> clothCount,
  Value<double?> totalDue,
  Value<double?> amountPaid,
  Value<String?> direction,
  Value<double?> amount,
  Value<String?> label,
  Value<String?> reason,
  required String createdAt,
  required String updatedAt,
  Value<String?> deletedAt,
  Value<String?> syncedAt,
  Value<int> rowid,
});
typedef $$IroningTransactionsTableUpdateCompanionBuilder
    = IroningTransactionsCompanion Function({
  Value<String> id,
  Value<String> type,
  Value<String> date,
  Value<double> balanceBefore,
  Value<double> balanceAfter,
  Value<double?> priceSnapshot,
  Value<int?> clothCount,
  Value<double?> totalDue,
  Value<double?> amountPaid,
  Value<String?> direction,
  Value<double?> amount,
  Value<String?> label,
  Value<String?> reason,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String?> deletedAt,
  Value<String?> syncedAt,
  Value<int> rowid,
});

class $$IroningTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $IroningTransactionsTable> {
  $$IroningTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get balanceBefore => $composableBuilder(
      column: $table.balanceBefore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get balanceAfter => $composableBuilder(
      column: $table.balanceAfter, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get priceSnapshot => $composableBuilder(
      column: $table.priceSnapshot, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clothCount => $composableBuilder(
      column: $table.clothCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalDue => $composableBuilder(
      column: $table.totalDue, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amountPaid => $composableBuilder(
      column: $table.amountPaid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));
}

class $$IroningTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $IroningTransactionsTable> {
  $$IroningTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get balanceBefore => $composableBuilder(
      column: $table.balanceBefore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get balanceAfter => $composableBuilder(
      column: $table.balanceAfter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get priceSnapshot => $composableBuilder(
      column: $table.priceSnapshot,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clothCount => $composableBuilder(
      column: $table.clothCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalDue => $composableBuilder(
      column: $table.totalDue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountPaid => $composableBuilder(
      column: $table.amountPaid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));
}

class $$IroningTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IroningTransactionsTable> {
  $$IroningTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get balanceBefore => $composableBuilder(
      column: $table.balanceBefore, builder: (column) => column);

  GeneratedColumn<double> get balanceAfter => $composableBuilder(
      column: $table.balanceAfter, builder: (column) => column);

  GeneratedColumn<double> get priceSnapshot => $composableBuilder(
      column: $table.priceSnapshot, builder: (column) => column);

  GeneratedColumn<int> get clothCount => $composableBuilder(
      column: $table.clothCount, builder: (column) => column);

  GeneratedColumn<double> get totalDue =>
      $composableBuilder(column: $table.totalDue, builder: (column) => column);

  GeneratedColumn<double> get amountPaid => $composableBuilder(
      column: $table.amountPaid, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$IroningTransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IroningTransactionsTable,
    IroningTransaction,
    $$IroningTransactionsTableFilterComposer,
    $$IroningTransactionsTableOrderingComposer,
    $$IroningTransactionsTableAnnotationComposer,
    $$IroningTransactionsTableCreateCompanionBuilder,
    $$IroningTransactionsTableUpdateCompanionBuilder,
    (
      IroningTransaction,
      BaseReferences<_$AppDatabase, $IroningTransactionsTable,
          IroningTransaction>
    ),
    IroningTransaction,
    PrefetchHooks Function()> {
  $$IroningTransactionsTableTableManager(
      _$AppDatabase db, $IroningTransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IroningTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IroningTransactionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IroningTransactionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<double> balanceBefore = const Value.absent(),
            Value<double> balanceAfter = const Value.absent(),
            Value<double?> priceSnapshot = const Value.absent(),
            Value<int?> clothCount = const Value.absent(),
            Value<double?> totalDue = const Value.absent(),
            Value<double?> amountPaid = const Value.absent(),
            Value<String?> direction = const Value.absent(),
            Value<double?> amount = const Value.absent(),
            Value<String?> label = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            Value<String?> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              IroningTransactionsCompanion(
            id: id,
            type: type,
            date: date,
            balanceBefore: balanceBefore,
            balanceAfter: balanceAfter,
            priceSnapshot: priceSnapshot,
            clothCount: clothCount,
            totalDue: totalDue,
            amountPaid: amountPaid,
            direction: direction,
            amount: amount,
            label: label,
            reason: reason,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            required String date,
            required double balanceBefore,
            required double balanceAfter,
            Value<double?> priceSnapshot = const Value.absent(),
            Value<int?> clothCount = const Value.absent(),
            Value<double?> totalDue = const Value.absent(),
            Value<double?> amountPaid = const Value.absent(),
            Value<String?> direction = const Value.absent(),
            Value<double?> amount = const Value.absent(),
            Value<String?> label = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            required String createdAt,
            required String updatedAt,
            Value<String?> deletedAt = const Value.absent(),
            Value<String?> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              IroningTransactionsCompanion.insert(
            id: id,
            type: type,
            date: date,
            balanceBefore: balanceBefore,
            balanceAfter: balanceAfter,
            priceSnapshot: priceSnapshot,
            clothCount: clothCount,
            totalDue: totalDue,
            amountPaid: amountPaid,
            direction: direction,
            amount: amount,
            label: label,
            reason: reason,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$IroningTransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IroningTransactionsTable,
    IroningTransaction,
    $$IroningTransactionsTableFilterComposer,
    $$IroningTransactionsTableOrderingComposer,
    $$IroningTransactionsTableAnnotationComposer,
    $$IroningTransactionsTableCreateCompanionBuilder,
    $$IroningTransactionsTableUpdateCompanionBuilder,
    (
      IroningTransaction,
      BaseReferences<_$AppDatabase, $IroningTransactionsTable,
          IroningTransaction>
    ),
    IroningTransaction,
    PrefetchHooks Function()>;
typedef $$ElectricityReadingsTableCreateCompanionBuilder
    = ElectricityReadingsCompanion Function({
  required String id,
  required String readingDate,
  required double meterValue,
  required String billingCycle,
  Value<String?> note,
  required String createdAt,
  required String updatedAt,
  Value<String?> deletedAt,
  Value<String?> syncedAt,
  Value<int> rowid,
});
typedef $$ElectricityReadingsTableUpdateCompanionBuilder
    = ElectricityReadingsCompanion Function({
  Value<String> id,
  Value<String> readingDate,
  Value<double> meterValue,
  Value<String> billingCycle,
  Value<String?> note,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String?> deletedAt,
  Value<String?> syncedAt,
  Value<int> rowid,
});

class $$ElectricityReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $ElectricityReadingsTable> {
  $$ElectricityReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get readingDate => $composableBuilder(
      column: $table.readingDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get meterValue => $composableBuilder(
      column: $table.meterValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get billingCycle => $composableBuilder(
      column: $table.billingCycle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));
}

class $$ElectricityReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ElectricityReadingsTable> {
  $$ElectricityReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get readingDate => $composableBuilder(
      column: $table.readingDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get meterValue => $composableBuilder(
      column: $table.meterValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get billingCycle => $composableBuilder(
      column: $table.billingCycle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));
}

class $$ElectricityReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ElectricityReadingsTable> {
  $$ElectricityReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get readingDate => $composableBuilder(
      column: $table.readingDate, builder: (column) => column);

  GeneratedColumn<double> get meterValue => $composableBuilder(
      column: $table.meterValue, builder: (column) => column);

  GeneratedColumn<String> get billingCycle => $composableBuilder(
      column: $table.billingCycle, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$ElectricityReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ElectricityReadingsTable,
    ElectricityReading,
    $$ElectricityReadingsTableFilterComposer,
    $$ElectricityReadingsTableOrderingComposer,
    $$ElectricityReadingsTableAnnotationComposer,
    $$ElectricityReadingsTableCreateCompanionBuilder,
    $$ElectricityReadingsTableUpdateCompanionBuilder,
    (
      ElectricityReading,
      BaseReferences<_$AppDatabase, $ElectricityReadingsTable,
          ElectricityReading>
    ),
    ElectricityReading,
    PrefetchHooks Function()> {
  $$ElectricityReadingsTableTableManager(
      _$AppDatabase db, $ElectricityReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ElectricityReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ElectricityReadingsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ElectricityReadingsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> readingDate = const Value.absent(),
            Value<double> meterValue = const Value.absent(),
            Value<String> billingCycle = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            Value<String?> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ElectricityReadingsCompanion(
            id: id,
            readingDate: readingDate,
            meterValue: meterValue,
            billingCycle: billingCycle,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String readingDate,
            required double meterValue,
            required String billingCycle,
            Value<String?> note = const Value.absent(),
            required String createdAt,
            required String updatedAt,
            Value<String?> deletedAt = const Value.absent(),
            Value<String?> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ElectricityReadingsCompanion.insert(
            id: id,
            readingDate: readingDate,
            meterValue: meterValue,
            billingCycle: billingCycle,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ElectricityReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ElectricityReadingsTable,
    ElectricityReading,
    $$ElectricityReadingsTableFilterComposer,
    $$ElectricityReadingsTableOrderingComposer,
    $$ElectricityReadingsTableAnnotationComposer,
    $$ElectricityReadingsTableCreateCompanionBuilder,
    $$ElectricityReadingsTableUpdateCompanionBuilder,
    (
      ElectricityReading,
      BaseReferences<_$AppDatabase, $ElectricityReadingsTable,
          ElectricityReading>
    ),
    ElectricityReading,
    PrefetchHooks Function()>;
typedef $$ElectricityRatesTableCreateCompanionBuilder
    = ElectricityRatesCompanion Function({
  required String id,
  required double ratePerUnit,
  required String effectiveFrom,
  Value<String?> note,
  required String createdAt,
  required String updatedAt,
  Value<String?> deletedAt,
  Value<String?> syncedAt,
  Value<int> rowid,
});
typedef $$ElectricityRatesTableUpdateCompanionBuilder
    = ElectricityRatesCompanion Function({
  Value<String> id,
  Value<double> ratePerUnit,
  Value<String> effectiveFrom,
  Value<String?> note,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String?> deletedAt,
  Value<String?> syncedAt,
  Value<int> rowid,
});

class $$ElectricityRatesTableFilterComposer
    extends Composer<_$AppDatabase, $ElectricityRatesTable> {
  $$ElectricityRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get ratePerUnit => $composableBuilder(
      column: $table.ratePerUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));
}

class $$ElectricityRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ElectricityRatesTable> {
  $$ElectricityRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get ratePerUnit => $composableBuilder(
      column: $table.ratePerUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));
}

class $$ElectricityRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ElectricityRatesTable> {
  $$ElectricityRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get ratePerUnit => $composableBuilder(
      column: $table.ratePerUnit, builder: (column) => column);

  GeneratedColumn<String> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$ElectricityRatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ElectricityRatesTable,
    ElectricityRate,
    $$ElectricityRatesTableFilterComposer,
    $$ElectricityRatesTableOrderingComposer,
    $$ElectricityRatesTableAnnotationComposer,
    $$ElectricityRatesTableCreateCompanionBuilder,
    $$ElectricityRatesTableUpdateCompanionBuilder,
    (
      ElectricityRate,
      BaseReferences<_$AppDatabase, $ElectricityRatesTable, ElectricityRate>
    ),
    ElectricityRate,
    PrefetchHooks Function()> {
  $$ElectricityRatesTableTableManager(
      _$AppDatabase db, $ElectricityRatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ElectricityRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ElectricityRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ElectricityRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<double> ratePerUnit = const Value.absent(),
            Value<String> effectiveFrom = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            Value<String?> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ElectricityRatesCompanion(
            id: id,
            ratePerUnit: ratePerUnit,
            effectiveFrom: effectiveFrom,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required double ratePerUnit,
            required String effectiveFrom,
            Value<String?> note = const Value.absent(),
            required String createdAt,
            required String updatedAt,
            Value<String?> deletedAt = const Value.absent(),
            Value<String?> syncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ElectricityRatesCompanion.insert(
            id: id,
            ratePerUnit: ratePerUnit,
            effectiveFrom: effectiveFrom,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncedAt: syncedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ElectricityRatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ElectricityRatesTable,
    ElectricityRate,
    $$ElectricityRatesTableFilterComposer,
    $$ElectricityRatesTableOrderingComposer,
    $$ElectricityRatesTableAnnotationComposer,
    $$ElectricityRatesTableCreateCompanionBuilder,
    $$ElectricityRatesTableUpdateCompanionBuilder,
    (
      ElectricityRate,
      BaseReferences<_$AppDatabase, $ElectricityRatesTable, ElectricityRate>
    ),
    ElectricityRate,
    PrefetchHooks Function()>;
typedef $$SyncLogsTableCreateCompanionBuilder = SyncLogsCompanion Function({
  required String id,
  required String syncedAt,
  required String direction,
  required int rowsPushed,
  required int rowsPulled,
  required String status,
  Value<String?> error,
  Value<int> rowid,
});
typedef $$SyncLogsTableUpdateCompanionBuilder = SyncLogsCompanion Function({
  Value<String> id,
  Value<String> syncedAt,
  Value<String> direction,
  Value<int> rowsPushed,
  Value<int> rowsPulled,
  Value<String> status,
  Value<String?> error,
  Value<int> rowid,
});

class $$SyncLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rowsPushed => $composableBuilder(
      column: $table.rowsPushed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rowsPulled => $composableBuilder(
      column: $table.rowsPulled, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnFilters(column));
}

class $$SyncLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rowsPushed => $composableBuilder(
      column: $table.rowsPushed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rowsPulled => $composableBuilder(
      column: $table.rowsPulled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnOrderings(column));
}

class $$SyncLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<int> get rowsPushed => $composableBuilder(
      column: $table.rowsPushed, builder: (column) => column);

  GeneratedColumn<int> get rowsPulled => $composableBuilder(
      column: $table.rowsPulled, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);
}

class $$SyncLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncLogsTable,
    SyncLog,
    $$SyncLogsTableFilterComposer,
    $$SyncLogsTableOrderingComposer,
    $$SyncLogsTableAnnotationComposer,
    $$SyncLogsTableCreateCompanionBuilder,
    $$SyncLogsTableUpdateCompanionBuilder,
    (SyncLog, BaseReferences<_$AppDatabase, $SyncLogsTable, SyncLog>),
    SyncLog,
    PrefetchHooks Function()> {
  $$SyncLogsTableTableManager(_$AppDatabase db, $SyncLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> syncedAt = const Value.absent(),
            Value<String> direction = const Value.absent(),
            Value<int> rowsPushed = const Value.absent(),
            Value<int> rowsPulled = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncLogsCompanion(
            id: id,
            syncedAt: syncedAt,
            direction: direction,
            rowsPushed: rowsPushed,
            rowsPulled: rowsPulled,
            status: status,
            error: error,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String syncedAt,
            required String direction,
            required int rowsPushed,
            required int rowsPulled,
            required String status,
            Value<String?> error = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncLogsCompanion.insert(
            id: id,
            syncedAt: syncedAt,
            direction: direction,
            rowsPushed: rowsPushed,
            rowsPulled: rowsPulled,
            status: status,
            error: error,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncLogsTable,
    SyncLog,
    $$SyncLogsTableFilterComposer,
    $$SyncLogsTableOrderingComposer,
    $$SyncLogsTableAnnotationComposer,
    $$SyncLogsTableCreateCompanionBuilder,
    $$SyncLogsTableUpdateCompanionBuilder,
    (SyncLog, BaseReferences<_$AppDatabase, $SyncLogsTable, SyncLog>),
    SyncLog,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$IroningPricesTableTableManager get ironingPrices =>
      $$IroningPricesTableTableManager(_db, _db.ironingPrices);
  $$IroningTransactionsTableTableManager get ironingTransactions =>
      $$IroningTransactionsTableTableManager(_db, _db.ironingTransactions);
  $$ElectricityReadingsTableTableManager get electricityReadings =>
      $$ElectricityReadingsTableTableManager(_db, _db.electricityReadings);
  $$ElectricityRatesTableTableManager get electricityRates =>
      $$ElectricityRatesTableTableManager(_db, _db.electricityRates);
  $$SyncLogsTableTableManager get syncLogs =>
      $$SyncLogsTableTableManager(_db, _db.syncLogs);
}
