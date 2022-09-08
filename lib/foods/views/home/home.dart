import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food/app_module.dart';
import 'package:food/foods/bloc/bloc.dart';
import 'package:food/foods/widgets/card/card.dart';
import 'package:food/foods/widgets/card/card_meal.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food"),
          actions: [
            TextButton.icon(
              onPressed: () {
                AppModule.toFavorites();
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.black87,
              ),
              label: const Text(
                "Favorite",
                style: TextStyle(color: Colors.black87),
              ),
            )
          ],
        ),
        body: BlocProvider(
          lazy: true,
          create: (_) => CategoryBloc()..add(GetCategoryList()),
          child: BlocProvider(
            create: (_) => MealBloc(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: 70,
                      child: BlocListener<CategoryBloc, CategoryState>(
                        listener: (context, state) {
                          if (state is CategoryLoaded) {
                            //load meal
                            context.read<MealBloc>().add(GetMealList(
                                '${state.list[state.indexSelected].strCategory}'));
                          }
                        },
                        child: BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (ctx, state) {
                          if (state is CategoryInitial) {
                            return _buildLoading();
                          } else if (state is CategoryLoading) {
                            return _buildLoading();
                          } else if (state is CategoryError) {
                            return Text('${state.message}');
                          } else if (state is CategoryLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.list.length,
                              itemBuilder: (BuildContext context, int i) {
                                return CardCategory(
                                  isSelected: state.indexSelected == i,
                                  onTap: () {
                                    context
                                        .read<CategoryBloc>()
                                        .add(SelectedCategory(i));
                                  },
                                  label: '${state.list[i].strCategory}',
                                );
                              },
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: BlocBuilder<MealBloc, MealState>(
                      builder: (context, state) {
                        if (state is MealInitial) {
                          return _buildLoading();
                        } else if (state is MealLoading) {
                          return _buildLoading();
                        } else if (state is MealError) {
                          return Text("${state.message}");
                        } else if (state is MealLoaded) {
                          return StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.list.length,
                              crossAxisCount: 2,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 2.0,
                              itemBuilder: (BuildContext context, int i) =>
                                  CardMeal(
                                    onTap: () {
                                      context.read<MealBloc>().add(
                                          ToDetailEvent(
                                              '${state.list[i].idMeal}'));
                                    },
                                    urlImage: '${state.list[i].strMealThumb}',
                                    name: '${state.list[i].strMeal}',
                                  ),
                              staggeredTileBuilder: (int index) =>
                                  const StaggeredTile.fit(1));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _buildLoading() => Center(child: const CircularProgressIndicator());
}
