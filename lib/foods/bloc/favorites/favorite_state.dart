part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  List<MealEntityData> list;
  MealEntityData? mealFavorite;

  FavoriteLoaded(this.list, {this.mealFavorite});

  FavoriteLoaded copyWith(
          {List<MealEntityData>? list, MealEntityData? mealFavorite}) =>
      FavoriteLoaded(list ?? this.list,
          mealFavorite: mealFavorite ?? this.mealFavorite);

  @override
  List<Object> get props => [list];
}

class FavoriteError extends FavoriteState {
  final String? message;
  const FavoriteError(this.message);
}
