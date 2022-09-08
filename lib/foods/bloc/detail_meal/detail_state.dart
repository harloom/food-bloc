part of 'detail_bloc.dart';

abstract class DetailMealState extends Equatable {
  const DetailMealState();

  @override
  List<Object?> get props => [];
}

class DetailMealInitial extends DetailMealState {}

class DetailMealLoading extends DetailMealState {}

class DetailMealLoaded extends DetailMealState {
  final DetailMeal detail;
  const DetailMealLoaded(this.detail);

  DetailMealLoaded copyWith({DetailMeal? detail}) {
    return DetailMealLoaded(detail ?? this.detail);
  }

  @override
  List<Object> get props => [detail];
}

class DetailMealError extends DetailMealState {
  final String? message;
  const DetailMealError(this.message);
}
