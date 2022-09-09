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

    on<GetFavoriteById>((event, emit) async {
      Db db = Db();
      DbRepository dbRepository = DbRepository(db);
      try {
        var response = await dbRepository.getFavorite(event.id);
        print(response);
        if (response != null) {
          if (state is FavoriteLoaded) {
            FavoriteLoaded nowState = state as FavoriteLoaded;
            emit(FavoriteLoading());
            emit(FavoriteLoaded(nowState.list, mealFavorite: response));
          } else {
            emit(FavoriteLoaded(const [], mealFavorite: response));
          }
        } else {
          throw ("Data not found");
        }
      } catch (e) {
        emit(FavoriteLoaded([]));
      } finally {
        db.close();
      }
    });

    on<AddFavorite>((event, emit) async {
      Db db = Db();
      DbRepository dbRepository = DbRepository(db);
      try {
        emit(FavoriteLoading());
        await dbRepository.insertFavorite(event.entity);
        var response = await dbRepository.getFavorite(event.entity.id.value);
        if (response != null) {
          if (state is FavoriteLoaded) {
            FavoriteLoaded nowState = state as FavoriteLoaded;
            emit(nowState.copyWith(mealFavorite: response));
          } else {
            emit(FavoriteLoaded(const [], mealFavorite: response));
          }
        } else {
          throw ("Data null");
        }
      } catch (e) {
        emit(FavoriteLoaded([]));
      } finally {
        db.close();
      }
    });

    on<RemoveFavorite>((event, emit) async {
      Db db = Db();
      DbRepository dbRepository = DbRepository(db);
      try {
        await dbRepository.deletedFavorites(event.id);
        if (state is FavoriteLoaded) {
          var nowState = state as FavoriteLoaded;
          var filterList =
              nowState.list.where((element) => element.id != event.id).toList();

          if (filterList.isEmpty) {
            emit(const FavoriteError("Favorite belum ada"));
            return;
          }
          emit(FavoriteLoading());
          emit(FavoriteLoaded(filterList));
        } else {}
      } catch (e) {
        // print(e);
        emit(const FavoriteError("id tidak ditemukan"));
      } finally {
        db.close();
      }
    });
  }
}
