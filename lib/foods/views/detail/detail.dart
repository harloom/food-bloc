import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/foods/bloc/detail_meal/detail_meal.dart';
import 'package:food/foods/models/models.dart';
import 'package:food/foods/widgets/buttons/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatelessWidget {
  final String id;

  const Detail({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (_) => DetailMealBloc()..add(GetDetailMeal(id)),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                  toolbarHeight: 80,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarButton(
                        iconWidget: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Modular.to.pop();
                        },
                      ),
                      AppBarButton(
                        iconWidget: const Icon(
                          Icons.favorite,
                          color: Colors.black,
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(20),
                    child: Container(
                      width: double.maxFinite,
                      child: Center(
                          child: BlocBuilder<DetailMealBloc, DetailMealState>(
                        builder: (ctx, state) {
                          if (state is DetailMealInitial ||
                              state is DetailMealLoading) {
                            return _buildLoading();
                          } else if (state is DetailMealLoaded) {
                            return Text(
                              StringUtils.capitalize('${state.detail.strMeal}'),
                              style: const TextStyle(fontSize: 18),
                            );
                          } else {
                            return _buildTextEmpty();
                          }
                        },
                      )),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18.0),
                              topLeft: Radius.circular(18.0))),
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: BlocBuilder<DetailMealBloc, DetailMealState>(
                    builder: (ctx, state) {
                      if (state is DetailMealInitial ||
                          state is DetailMealLoading) {
                        return const FlexibleSpaceBar();
                      } else if (state is DetailMealLoaded) {
                        return FlexibleSpaceBar(
                          background: Image.network(
                            '${state.detail.strMealThumb}',
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return const FlexibleSpaceBar();
                      }
                    },
                  )),
              SliverToBoxAdapter(
                child: BlocBuilder<DetailMealBloc, DetailMealState>(
                  builder: (ctx, state) {
                    if (state is DetailMealInitial ||
                        state is DetailMealLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is DetailMealLoaded) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Area : ${state.detail.strArea}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Category : ${state.detail.strCategory}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildTags(state.detail),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Ingredients",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            _buildIngredients(state.detail.getIngredients(),
                                state.detail.getMeasures()),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Text('${state.detail.strInstructions}'),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
          BlocBuilder<DetailMealBloc, DetailMealState>(builder: (ctx, state) {
            if (state is DetailMealInitial || state is DetailMealLoading) {
              return Container();
            } else if (state is DetailMealLoaded) {
              return Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 2.0),
                    decoration: const BoxDecoration(color: Colors.white),
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _launchInBrowser(
                                  Uri.parse('${state.detail.strSource}'));
                            },
                            child: const Text("Source")),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  _launchInBrowser(
                                      Uri.parse('${state.detail.strYoutube}'));
                                },
                                child: const Text("Youtube")))
                      ],
                    ),
                  ));
            } else {
              return Container();
            }
          })
        ],
      ),
    ));
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Text _buildTextEmpty() {
    return const Text(
      "-",
      style: TextStyle(fontSize: 16),
    );
  }

  Text _buildLoading() => const Text("Loading....");

  Widget _buildIngredients(List<String> ingredients, List<String> measures) {
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 10,
        children: ingredients.asMap().entries.map((e) {
          int idx = e.key;
          String val = e.value;

          return val != ""
              ? Chip(
                  backgroundColor: Colors.amberAccent,
                  label: Text("$val (${measures[idx]})"),
                )
              : Container();
        }).toList());
  }

  Widget _buildTags(DetailMeal detail) {
    List<String> sliceText(String text) {
      if (text == "null") return [];
      var data = text.split(',');
      return data;
    }

    return sliceText('${detail.strTags}').isNotEmpty
        ? Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 10,
            children: sliceText('${detail.strTags}')
                .map((e) => Chip(label: Text(e)))
                .toList(),
          )
        : Container();
  }
}
