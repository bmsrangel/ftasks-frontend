import 'package:flutter/material.dart';

import '../../../shared/widgets/header_widget.dart';
import '../widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  static final String route = 'register';
  final String title;
  const RegisterPage({Key key, this.title = "RegisterPage"}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        children: [
          buildHeader(primaryColor),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: null,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    buildNameField(primaryColor),
                    const SizedBox(height: 15.0),
                    buildEmailField(primaryColor),
                    const SizedBox(height: 15.0),
                    buildPasswordField(primaryColor, true),
                    buildConfirmPasswordField(primaryColor, true),
                    const SizedBox(height: 25.0),
                    buildRegisterButton(),
                    const SizedBox(height: 20.0),
                    buildBackButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(Color primaryColor) {
    return HeaderWidget(
      backgroundColor: primaryColor,
      child: Text(
        'Registro de usuário',
        style: TextStyle(
          fontSize: 32.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildNameField(Color primaryColor) {
    return CustomFormField(
      labelText: 'Nome',
      cursorColor: primaryColor,
      // validationFunction: (name) => {},
    );
  }

  Widget buildEmailField(Color primaryColor) {
    return CustomFormField(
      labelText: 'E-mail',
      cursorColor: primaryColor,
      keyboardType: TextInputType.emailAddress,
      // validationFunction: (email) => {},
    );
  }

  Widget buildPasswordField(Color primaryColor, bool isObscure) {
    return CustomFormField(
      labelText: 'Senha',
      cursorColor: primaryColor,
      obscureText: isObscure,
      suffixIcon: isObscure ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: () {},
      // validationFunction: (password) => {},
    );
  }

  Widget buildConfirmPasswordField(Color primaryColor, bool isObscure) {
    return CustomFormField(
      labelText: 'Confirmação da senha',
      cursorColor: primaryColor,
      obscureText: isObscure,
      suffixIcon: isObscure ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: () {},
      // validationFunction: (confirmPassword) => {},
    );
  }

  Widget buildRegisterButton() {
    return Container(
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Registrar'),
      ),
    );
  }

  Widget buildBackButton() {
    return Container(
      height: 50.0,
      child: OutlinedButton(
        onPressed: () {},
        child: Text('Voltar'),
      ),
    );
  }
}
