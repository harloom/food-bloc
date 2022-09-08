part of 'meal_bloc.dart';

abstract class MealState extends Equatable {
  const MealState();

  @override
  List<Object?> get props => [];
}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> list;
  const MealLoaded(this.list);

  MealLoaded copyWith({List<Meal>? list}) {
    return MealLoaded(list ?? this.list);
  }

  @override
  List<Object> get props => [list];
}

class MealError extends MealState {
  final String? message;
  const MealError(this.message);
}
