import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/app_module.dart';
import 'package:food/foods/bloc/favorites/favorite_bloc.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteBloc>().add(const GetFavoriteList());
    return Scaffold(
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
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                itemCount: state.list.length,
                itemBuilder: (ctx, i) => ListTile(
                      onTap: () {
                        AppModule.toDetail(state.list[i].id);
                      },
                      title: Text(state.list[i].nameMeal),
                      leading: Image.network(
                        state.list[i].thumbnail,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_forever),
                        onPressed: () {
                          ctx
                              .read<FavoriteBloc>()
                              .add(RemoveFavorite(state.list[i].id));
                        },
                      ),
                    ));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
