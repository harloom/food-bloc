part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryList extends CategoryEvent {}

class SelectedCategory extends CategoryEvent {
  final int index;

  const SelectedCategory(this.index);
}
