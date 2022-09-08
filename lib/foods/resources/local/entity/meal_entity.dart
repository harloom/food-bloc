import 'package:drift/drift.dart';

class MealEntity extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get nameMeal => text().named('name_meal')();
  TextColumn get thumbnail => text().named('thumbnail')();
  @override
  Set<Column>? get primaryKey => {id};
}
