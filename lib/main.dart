import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/app.dart';
import 'package:food/app_module.dart';
import 'package:food/foods/bloc/favorites/favorite_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => FavoriteBloc(),
    child: ModularApp(module: AppModule(), child: const App()),
  ));
}
