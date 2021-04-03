import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/modules/home/models/todo_model.dart';
import 'package:mobile/app/modules/home/repositories/todos_repository.dart';
import 'package:mobile/app/modules/login/login_page.dart';
import 'package:mobile/app/shared/auth/auth_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomeController {
  HomeController(this._auth$, this._todosRepository);

  final AuthController _auth$;
  final TodosRepository _todosRepository;

  final TextEditingController description$ = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxNotifier<List<TodoModel>> allTodos = RxNotifier<List<TodoModel>>(null);

  String get name => _auth$.user?.name;

  Future<void> logout() async {
    await _auth$.logout();
    Modular.to.navigate(LoginPage.route, replaceAll: true);
  }

  Future<void> getAllTodos() async {
    final allTodos = await _todosRepository.getAllTodosFromUser();
    await Future.delayed(Duration(seconds: 2));
    this.allTodos.value = List.from(allTodos);
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    try {
      await _todosRepository.updateTodo(updatedTodo);
      final updatedTodoIndex =
          allTodos.value.indexWhere((todo) => todo.id == updatedTodo.id);
      allTodos.value[updatedTodoIndex] = updatedTodo;
      allTodos.value = List.from(allTodos.value);
    } catch (e) {}
  }

  String descriptionValidation(String description) {
    if (description.isEmpty) {
      return 'Descrição é obrigatória';
    } else {
      return null;
    }
  }

  Future<void> addTodo() async {
    try {
      final TodoModel newTodo =
          await _todosRepository.addTodo(description$.text);
      allTodos.value = List.from([...allTodos.value, newTodo]);
      description$.clear();
    } catch (e) {}
  }
}
