import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/foods/views/favorite/favorites.dart';

import 'foods/views/views.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  static void toFavorites() {
    Modular.to.pushNamed("/favorites");
  }

  static void toDetail(String id) {
    Modular.to.pushNamed('/detail/$id');
  }

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const Home()),
        ChildRoute('/favorites', child: (context, args) => const Favorites()),
        ChildRoute('/detail/:id',
            child: (context, args) => Detail(id: args.params['id'])),
      ];
}
