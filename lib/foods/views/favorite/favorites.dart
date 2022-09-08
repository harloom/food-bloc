import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/foods/bloc/favorites/favorite_bloc.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Favorite"),
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (ctx, state) {
            if (state is FavoriteInitial || state is FavoriteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoriteError) {
              return Center(
                child: Text("${state.message}"),
              );
            } else if (state is FavoriteLoaded) {
              return ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (ctx, i) => ListTile(
                        title: Text(state.list[i].nameMeal),
                      ));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
