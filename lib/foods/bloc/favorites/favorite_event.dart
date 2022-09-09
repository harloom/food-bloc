part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteList extends FavoriteEvent {
  const GetFavoriteList();
}

class AddFavorite extends FavoriteEvent {
  final MealEntityCompanion entity;
  const AddFavorite(this.entity);
}

class RemoveFavorite extends FavoriteEvent {
  final String id;

  const RemoveFavorite(this.id);
}

class GetFavoriteById extends FavoriteEvent {
  final String id;

  const GetFavoriteById(this.id);
}
