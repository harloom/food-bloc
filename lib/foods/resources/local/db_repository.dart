import 'db/db.dart';

class DbRepository {
  final Db _db;

  DbRepository(this._db);

  Future<MealEntityData?> getFavorite(String id) => _db.getFavorite(id);

  Future<List<MealEntityData>> getFavorites() => _db.getFavorites();

  Future<int> insertFavorite(MealEntityCompanion entity) =>
      _db.insertFavorites(entity);

  Future<int> deletedFavorites(String id) => _db.deletedFavorites(id);
}
