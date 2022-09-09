import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food/foods/bloc/bloc.dart';

void main() {
  group("Category Testing bloc", () {
    late CategoryBloc categoryBloc;

    setUp(() {
      categoryBloc = CategoryBloc();
    });

    test("initial test ...", () {
      expect(categoryBloc.state, isA<CategoryInitial>());
    });

    blocTest<CategoryBloc, CategoryState>(
      "Fetch category loading...",
      build: () => categoryBloc,
      act: (bloc) => bloc.add((GetCategoryList())),
      expect: () => [isA<CategoryLoading>()],
    );

    blocTest<CategoryBloc, CategoryState>(
      "Fetch category Successfull...",
      build: () => categoryBloc,
      act: (bloc) => bloc.add((GetCategoryList())),
      wait: const Duration(milliseconds: 3000),
      expect: () => [isA<CategoryLoading>(), isA<CategoryLoaded>()],
    );
  });

  group("List Meal Testing bloc", () {
    late MealBloc mealBloc;

    setUp(() {
      mealBloc = MealBloc();
    });

    test("initial test ...", () {
      expect(mealBloc.state, isA<MealInitial>());
    });

    blocTest<MealBloc, MealState>(
      "Fetch meal with category state loading...",
      build: () => mealBloc,
      act: (bloc) => bloc.add((const GetMealList("Seafood"))),
      expect: () => [isA<MealLoading>()],
    );

    blocTest<MealBloc, MealState>(
      "Fetch meal Successfully...",
      build: () => mealBloc,
      act: (bloc) => bloc.add((const GetMealList("Seafood"))),
      wait: const Duration(milliseconds: 3000),
      expect: () => [isA<MealLoading>(), isA<MealLoaded>()],
    );

    blocTest<MealBloc, MealState>(
      "Fetch meal failed...",
      build: () => mealBloc,
      act: (bloc) => bloc.add((const GetMealList("Seaxxxfood"))),
      wait: const Duration(milliseconds: 3000),
      expect: () => [isA<MealLoading>(), isA<MealError>()],
    );
  });
}
