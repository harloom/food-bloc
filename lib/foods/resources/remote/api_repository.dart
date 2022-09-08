import 'package:food/foods/models/models.dart';
import 'package:food/foods/resources/remote/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<ListCategory> getCategory() => _provider.fetchCategory();

  Future<ListMeals> getMealWithCategory(String txtCategory) =>
      _provider.fetchMeal(txtCategory);

  Future<DMeal> getDetailMeals(String idMeal) =>
      _provider.fetchDetailMeal(idMeal);
}
