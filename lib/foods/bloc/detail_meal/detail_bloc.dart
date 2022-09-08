import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/foods/models/models.dart';
import 'package:food/foods/resources/resources.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailMealBloc extends Bloc<DetailEvent, DetailMealState> {
  DetailMealBloc() : super(DetailMealInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetDetailMeal>((event, emit) async {
      emit(DetailMealLoading());

      var response = await _apiRepository.getDetailMeals(event.id);

      if (response.error != null) {
        emit(DetailMealError(response.error));
        return;
      }
      emit(DetailMealLoaded(response.meal!));
    });
  }
}
