import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:food/foods/resources/local/entity/meal_entity.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'food.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [MealEntity])
class Db extends _$Db {
  Db() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<MealEntityData>> getFavorites() async {
    return await select(mealEntity).get();
  }

  Future<MealEntityData?> getFavorite(String id) async {
    return await (select(mealEntity)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertFavorites(MealEntityCompanion entity) async {
    return await into(mealEntity).insert(entity);
  }

  Future<int> deletedFavorites(String id) async {
    return await (delete(mealEntity)..where((tbl) => tbl.id.equals(id))).go();
  }
}
