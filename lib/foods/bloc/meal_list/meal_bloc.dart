import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/app_module.dart';
import 'package:food/foods/models/models.dart';
import 'package:food/foods/resources/resources.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(MealInitial()) {
    final ApiRepository _apiRepository = ApiRepository();
    on<GetMealList>((event, emit) async {
      emit(MealLoading());

      var response =
          await _apiRepository.getMealWithCategory(event.txtCategory);
      if (response.error != null) {
        emit(MealError(response.error));
        return;
      }
      emit(MealLoaded(response.meals));
    });
    on<ToDetailEvent>((event, emit) {
      AppModule.toDetail(event.id);
    });
  }
}
