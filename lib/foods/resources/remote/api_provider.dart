import 'package:dio/dio.dart';
import 'package:food/foods/models/models.dart';

class ApiProvider {
  final Dio _dio = Dio();

  final String _baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<ListCategory> fetchCategory() async {
    try {
      List<Category> categorys = [];

      Response response = await _dio.get(_baseUrl + "/list.php?c=list");
      var list = response.data['meals'] as List<dynamic>;
      categorys = list.map((e) => Category.fromJson(e)).toList();

      return ListCategory(categorys);
    } catch (e) {
      String? errMessage = '$e';
      if (e is DioError) {
        errMessage = e.message;
      }
      return ListCategory.withError(errMessage);
    }
  }

  Future<ListMeals> fetchMeal(String txtCategory) async {
    try {
      List<Meal> meals = [];
      Response response = await _dio
          .get(_baseUrl + "/filter.php", queryParameters: {'c': txtCategory});
      var list = response.data['meals'] as List<dynamic>?;

      if (list == null) throw ("List null");

      meals = list.map((e) => Meal.fromJson(e)).toList();
      return ListMeals(meals);
    } catch (e) {
      String? errMessage = '$e';
      if (e is DioError) {
        errMessage = e.message;
      }
      return ListMeals.withError(errMessage);
    }
  }

  Future<DMeal> fetchDetailMeal(String idMeal) async {
    try {
      DetailMeal? meal;
      Response response = await _dio
          .get(_baseUrl + "/lookup.php", queryParameters: {'i': idMeal});
      var list = response.data['meals'] as List<dynamic>?;
      if (list == null) throw ("detail null");
      meal = DetailMeal.fromJson(list[0]);
      return DMeal(meal);
    } catch (e) {
      String? errMessage = '$e';
      if (e is DioError) {
        errMessage = e.message;
      }
      return DMeal.withError(errMessage);
    }
  }
}
