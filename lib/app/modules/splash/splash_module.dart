import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/modules/splash/splash_controller.dart';
import 'package:mobile/app/modules/splash/splash_page.dart';
import 'package:mobile/app/shared/auth/auth_controller.dart';
import 'package:mobile/app/shared/services/user_local_storage_service.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashController(
          i.get<UserLocalStorageService>(),
          i.get<AuthController>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => SplashPage())
  ];
}
