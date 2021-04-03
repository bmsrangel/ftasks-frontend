import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/modules/home/home_module.dart';
import 'package:mobile/app/modules/home/home_page.dart';
import 'package:mobile/app/modules/login/login_module.dart';
import 'package:mobile/app/modules/login/login_page.dart';
import 'package:mobile/app/shared/auth/auth_controller.dart';
import 'package:mobile/app/shared/auth/repositories/auth_repository.dart';
import 'package:mobile/app/shared/custom_dio/custom_dio.dart';
import 'package:mobile/app/shared/services/user_local_storage_service.dart';

import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => CustomDio()),
    Bind.singleton((i) => UserLocalStorageService()),
    Bind.lazySingleton((i) => AuthRepository(i.get<Dio>())),
    Bind.singleton((i) => AuthController(
        i.get<AuthRepository>(), i.get<UserLocalStorageService>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute(LoginPage.route, module: LoginModule()),
    ModuleRoute(HomePage.route, module: HomeModule()),
  ];
}
