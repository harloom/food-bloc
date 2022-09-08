part of 'meal_bloc.dart';

abstract class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object> get props => [];
}

class GetMealList extends MealEvent {
  final String txtCategory;

  const GetMealList(this.txtCategory);
}

class ToDetailEvent extends MealEvent {
  final String id;

  const ToDetailEvent(this.id);
}
