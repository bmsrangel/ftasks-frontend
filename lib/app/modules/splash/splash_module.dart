import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/modules/splash/splash_controller.dart';
import 'package:mobile/app/modules/splash/splash_page.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => SplashPage())
  ];
}
