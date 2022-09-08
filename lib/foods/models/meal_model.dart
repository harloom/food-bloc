import 'dart:convert';

class ListMeals {
  List<Meal> meals = [];
  String? error;

  ListMeals.withError(String err) {
    error = err;
  }
  ListMeals(this.meals, {this.error});
}

class Meal {
  Meal({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  final String? strMeal;
  final String? strMealThumb;
  final String? idMeal;

  Meal copyWith({
    String? strMeal,
    String? strMealThumb,
    String? idMeal,
  }) =>
      Meal(
        strMeal: strMeal ?? this.strMeal,
        strMealThumb: strMealThumb ?? this.strMealThumb,
        idMeal: idMeal ?? this.idMeal,
      );

  factory Meal.fromRawJson(String str) => Meal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
