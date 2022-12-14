part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetailMeal extends DetailEvent {
  final String id;

  const GetDetailMeal(this.id);
}
