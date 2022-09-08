import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/foods/resources/local/db/db.dart';
import 'package:food/foods/resources/local/db_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<GetFavoriteList>((event, emit) async {
      Db db = Db();
      DbRepository dbRepository = DbRepository(db);
      try {
        emit(FavoriteLoading());
        var response = await dbRepository.getFavorites();
        if (response.isEmpty) {
          emit(const FavoriteError("Favorite belum ada"));
          return;
        }
        emit(FavoriteLoaded(response));
      } catch (e) {
        log("message error : ${e.toString()}");
        emit(const FavoriteError("Catch Error query"));
      } finally {
        db.close();
      }
    });
  }
}
