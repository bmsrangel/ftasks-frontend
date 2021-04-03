import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/modules/home/home_controller.dart';
import 'package:mobile/app/modules/home/home_page.dart';
import 'package:mobile/app/modules/home/repositories/todos_repository.dart';
import 'package:mobile/app/shared/auth/auth_controller.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TodosRepository(i.get<Dio>())),
    Bind.lazySingleton((i) => HomeController(
          i.get<AuthController>(),
          i.get<TodosRepository>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => HomePage()),
  ];
}
