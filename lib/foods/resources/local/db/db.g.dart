// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MealEntityData extends DataClass implements Insertable<MealEntityData> {
  final String id;
  final String nameMeal;
  final String thumbnail;
  MealEntityData(
      {required this.id, required this.nameMeal, required this.thumbnail});
  factory MealEntityData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MealEntityData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      nameMeal: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name_meal'])!,
      thumbnail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_meal'] = Variable<String>(nameMeal);
    map['thumbnail'] = Variable<String>(thumbnail);
    return map;
  }

  MealEntityCompanion toCompanion(bool nullToAbsent) {
    return MealEntityCompanion(
      id: Value(id),
      nameMeal: Value(nameMeal),
      thumbnail: Value(thumbnail),
    );
  }

  factory MealEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealEntityData(
      id: serializer.fromJson<String>(json['id']),
      nameMeal: serializer.fromJson<String>(json['nameMeal']),
      thumbnail: serializer.fromJson<String>(json['thumbnail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameMeal': serializer.toJson<String>(nameMeal),
      'thumbnail': serializer.toJson<String>(thumbnail),
    };
  }

  MealEntityData copyWith({String? id, String? nameMeal, String? thumbnail}) =>
      MealEntityData(
        id: id ?? this.id,
        nameMeal: nameMeal ?? this.nameMeal,
        thumbnail: thumbnail ?? this.thumbnail,
      );
  @override
  String toString() {
    return (StringBuffer('MealEntityData(')
          ..write('id: $id, ')
          ..write('nameMeal: $nameMeal, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameMeal, thumbnail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealEntityData &&
          other.id == this.id &&
          other.nameMeal == this.nameMeal &&
          other.thumbnail == this.thumbnail);
}

class MealEntityCompanion extends UpdateCompanion<MealEntityData> {
  final Value<String> id;
  final Value<String> nameMeal;
  final Value<String> thumbnail;
  const MealEntityCompanion({
    this.id = const Value.absent(),
    this.nameMeal = const Value.absent(),
    this.thumbnail = const Value.absent(),
  });
  MealEntityCompanion.insert({
    required String id,
    required String nameMeal,
    required String thumbnail,
  })  : id = Value(id),
        nameMeal = Value(nameMeal),
        thumbnail = Value(thumbnail);
  static Insertable<MealEntityData> custom({
    Expression<String>? id,
    Expression<String>? nameMeal,
    Expression<String>? thumbnail,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameMeal != null) 'name_meal': nameMeal,
      if (thumbnail != null) 'thumbnail': thumbnail,
    });
  }

  MealEntityCompanion copyWith(
      {Value<String>? id, Value<String>? nameMeal, Value<String>? thumbnail}) {
    return MealEntityCompanion(
      id: id ?? this.id,
      nameMeal: nameMeal ?? this.nameMeal,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameMeal.present) {
      map['name_meal'] = Variable<String>(nameMeal.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealEntityCompanion(')
          ..write('id: $id, ')
          ..write('nameMeal: $nameMeal, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }
}

class $MealEntityTable extends MealEntity
    with TableInfo<$MealEntityTable, MealEntityData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MealEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _nameMealMeta = const VerificationMeta('nameMeal');
  late final GeneratedColumn<String?> nameMeal = GeneratedColumn<String?>(
      'name_meal', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _thumbnailMeta = const VerificationMeta('thumbnail');
  late final GeneratedColumn<String?> thumbnail = GeneratedColumn<String?>(
      'thumbnail', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nameMeal, thumbnail];
  @override
  String get aliasedName => _alias ?? 'meal_entity';
  @override
  String get actualTableName => 'meal_entity';
  @override
  VerificationContext validateIntegrity(Insertable<MealEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_meal')) {
      context.handle(_nameMealMeta,
          nameMeal.isAcceptableOrUnknown(data['name_meal']!, _nameMealMeta));
    } else if (isInserting) {
      context.missing(_nameMealMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    } else if (isInserting) {
      context.missing(_thumbnailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MealEntityData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MealEntityTable createAlias(String alias) {
    return $MealEntityTable(_db, alias);
  }
}

abstract class _$Db extends GeneratedDatabase {
  _$Db(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $MealEntityTable mealEntity = $MealEntityTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mealEntity];
}
