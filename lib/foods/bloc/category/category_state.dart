part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final int indexSelected;
  final List<Category> list;
  const CategoryLoaded(this.list, this.indexSelected);

  CategoryLoaded copyWith({int? indexSelected, List<Category>? list}) {
    return CategoryLoaded(
        list ?? this.list, indexSelected ?? this.indexSelected);
  }

  @override
  List<Object> get props => [indexSelected, list];
}

class CategoryError extends CategoryState {
  final String? message;
  const CategoryError(this.message);
}
