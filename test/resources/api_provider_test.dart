import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food/foods/models/category_model.dart';
import 'package:food/foods/models/detail_meal_model.dart';
import 'package:food/foods/models/meal_model.dart';
import 'package:food/foods/resources/remote/api_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_provider_test.mocks.dart';

// class ApiProviderMock extends Mock implements HttpClientAdapter {}

@GenerateMocks([Dio])
void main() {
  MockDio mockDio = MockDio();
  final String _baseUrl = "https://www.themealdb.com/api/json/v1/1";

  setUp(() {});

  group("Category test", () {
    test("Category Data > 0", () async {
      when(mockDio.get(_baseUrl + '/list.php?c=list'))
          .thenAnswer((realInvocation) {
        return Future.value(Response(
            statusCode: 200,
            requestOptions:
                RequestOptions(path: _baseUrl + '/list.php?c=list')));
      });
      ListCategory listCategory = await ApiRepository().getCategory();
      expect(listCategory.categorys.length, greaterThan(0));
    });
  });

  group("Meals Test", () {
    test("Fetch meal with Category", () async {
      String category = "Seafood";

      when(mockDio
              .get(_baseUrl + '/filter.php', queryParameters: {'c': category}))
          .thenAnswer((realInvocation) => Future.value(Response(
              statusCode: 200,
              requestOptions:
                  RequestOptions(path: _baseUrl + '/filter.php?c=$category'))));
      ListMeals listMeals = await ApiRepository().getMealWithCategory(category);
      expect(listMeals.meals.length, greaterThan(0));
    });

    test("error fetch", () async {
      String category = "Seaxxfood";
      when(mockDio
              .get(_baseUrl + '/filter.php', queryParameters: {'c': category}))
          .thenAnswer((realInvocation) => Future.value(Response(
              statusCode: 200,
              requestOptions:
                  RequestOptions(path: _baseUrl + '/filter.php?c=$category'))));
      ListMeals listMeals = await ApiRepository().getMealWithCategory(category);
      expect(listMeals.meals.length, 0);
      expect(listMeals.error, isNot(""));
    });

    test("fetch detail successfull", () async {
      String id = "52807";
      when(mockDio.get(_baseUrl + '/lookup.php', queryParameters: {'i': id}))
          .thenAnswer((realInvocation) => Future.value(Response(
              statusCode: 200,
              requestOptions:
                  RequestOptions(path: _baseUrl + '/lookup.php?i=$id'))));

      DMeal dMeal = await ApiRepository().getDetailMeals(id);
      expect(dMeal.meal, isA<DetailMeal>());
      expect(dMeal.error, equals(null));
    });
  });
}
