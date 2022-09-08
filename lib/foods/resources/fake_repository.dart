import 'package:food/foods/models/models.dart';

class FakeRepository {
  static ListCategory getCategory() {
    List<Category> categories = [
      Category(strCategory: "Beef"),
      Category(strCategory: "Breakfast"),
      Category(strCategory: "Chicken"),
      Category(strCategory: "Dessert"),
      Category(strCategory: "Goat"),
      Category(strCategory: "Vegan"),
      Category(strCategory: "Pasta"),
      Category(strCategory: "SeaFood")
    ];
    return ListCategory(categories);
  }
}
