import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/modules/login/login_controller.dart';
import 'package:mobile/app/modules/login/login_page.dart';
import 'package:mobile/app/shared/auth/auth_controller.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginController(i.get<AuthController>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => LoginPage(),
    )
  ];
}
