part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<MealEntityData> list;
  const FavoriteLoaded(this.list);

  FavoriteLoaded copyWith({List<MealEntityData>? list}) {
    return FavoriteLoaded(list ?? this.list);
  }

  @override
  List<Object> get props => [list];
}

class FavoriteError extends FavoriteState {
  final String? message;
  const FavoriteError(this.message);
}
