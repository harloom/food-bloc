import 'dart:convert';

class ListCategory {
  List<Category> categorys = [];
  String? error;

  ListCategory.withError(String err) {
    error = err;
  }
  ListCategory(this.categorys, {this.error});
}

class Category {
  Category({
    this.strCategory,
  });

  final String? strCategory;

  Category copyWith({
    String? strCategory,
  }) =>
      Category(
        strCategory: strCategory ?? this.strCategory,
      );

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        strCategory: json["strCategory"],
      );

  Map<String, dynamic> toJson() => {
        "strCategory": strCategory,
      };
}
