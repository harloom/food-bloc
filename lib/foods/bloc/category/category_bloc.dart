import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/foods/models/models.dart';
import 'package:food/foods/resources/resources.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    final ApiRepository _apiRepository = ApiRepository();
    on<GetCategoryList>((event, emit) async {
      emit(CategoryLoading());

      var response = await _apiRepository.getCategory();

      // cek error
      if (response.error != null) {
        emit(CategoryError(response.error));
        return;
      }
      emit(CategoryLoaded(response.categorys, 0));
    });
    on<SelectedCategory>((event, Emitter<CategoryState> emit) async {
      if (state is CategoryLoaded) {
        CategoryLoaded nowState = state as CategoryLoaded;
        emit(nowState.copyWith(indexSelected: event.index));
      }
    });
  }
}
