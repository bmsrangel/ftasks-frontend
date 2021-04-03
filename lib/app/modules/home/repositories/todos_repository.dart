import 'package:dio/dio.dart';
import 'package:mobile/app/modules/home/models/todo_model.dart';

class TodosRepository {
  TodosRepository(this._dio);

  final Dio _dio;

  Future<List<TodoModel>> getAllTodosFromUser() async {
    final Response response = await _dio.get('/todos');
    final List todosMapList = response.data;
    if (response.data == null) {
      return null;
    } else {
      return todosMapList.map((todoMap) => TodoModel.fromMap(todoMap)).toList();
    }
  }

  Future<TodoModel> updateTodo(TodoModel updatedTodo) async {
    final int id = updatedTodo.id;
    final Response response =
        await _dio.patch('/todos/$id', data: updatedTodo.toMap());
    return TodoModel.fromMap(response.data);
  }

  Future<TodoModel> addTodo(String description) async {
    final Response response = await _dio.post('/todos', data: {
      'description': description,
    });
    return TodoModel.fromMap(response.data);
  }
}
