import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../shared/widgets/header_widget.dart';
import 'home_controller.dart';
import 'models/todo_model.dart';

class HomePage extends StatefulWidget {
  static final String route = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextStyle headerStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  final HomeController _home$ = Modular.get<HomeController>();

  @override
  void initState() {
    _home$.getAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                backgroundColor: primaryColor,
                height: screenHeight * .2,
                child: buildHeader(_home$.name),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RxBuilder(
                    builder: (_) {
                      if (_home$.allTodos.value == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return buildTodosList(_home$.allTodos.value);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          buildLogoutButton(context, _home$.logout),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            builder: (context) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 20.0,
                ),
                child: SingleChildScrollView(
                  child: buildModalBottomSheet(context),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildModalBottomSheet(BuildContext context) {
    return Form(
      key: _home$.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _home$.description$,
            validator: _home$.descriptionValidation,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descrição',
            ),
          ),
          const SizedBox(height: 30.0),
          Container(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Cancelar'),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await _home$.addTodo();
                Modular.to.pop();
              },
              child: Text('Confirmar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context, Function onPressed) {
    return Positioned(
      right: 0.0,
      top: MediaQuery.of(context).padding.top,
      child: IconButton(
        icon: Icon(Icons.logout),
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }

  Widget buildTodosList(List<TodoModel> todos) {
    return ListView.separated(
      separatorBuilder: (_, __) => Divider(),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final TodoModel currentTodo = todos[index];

        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: const EdgeInsets.only(right: 16.0),
          title: Text(
            currentTodo.description,
            style: TextStyle(
              color: Colors.black,
              decoration: null,
            ),
          ),
          value: currentTodo.isCompleted,
          onChanged: (value) async {
            final TodoModel updatedTodo = currentTodo.copyWith(
              isCompleted: value,
            );
            await _home$.updateTodo(updatedTodo);
          },
        );
      },
    );
  }

  Widget buildHeader(String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_greeting(DateTime.now().hour)},',
          style: headerStyle,
        ),
        Text(
          '$name!',
          style: headerStyle.copyWith(
            fontSize: 44.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  String _greeting(int hour) {
    if (hour > 0 && hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }
}
