import 'package:flutter/material.dart';

import '../../shared/widgets/header_widget.dart';

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
                child: buildHeader(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: buildTodosList([]),
                ),
              ),
            ],
          ),
          buildLogoutButton(context),
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
      key: null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descrição',
            ),
          ),
          const SizedBox(height: 30.0),
          Container(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: Text('Cancelar'),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Confirmar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    return Positioned(
      right: 0.0,
      top: MediaQuery.of(context).padding.top,
      child: IconButton(
        icon: Icon(Icons.logout),
        color: Colors.white,
        onPressed: () {},
      ),
    );
  }

  Widget buildTodosList(List todos) {
    return ListView.separated(
      separatorBuilder: (_, __) => Divider(),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: const EdgeInsets.only(right: 16.0),
          title: Text(
            'Descrição vem aqui',
            style: TextStyle(
              color: Colors.black,
              decoration: null,
            ),
          ),
          value: false,
          onChanged: (value) => {},
        );
      },
    );
  }

  Widget buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_greeting(DateTime.now().hour)},',
          style: headerStyle,
        ),
        Text(
          'John Doe!',
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
