import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/mixins/loader_mixin.dart';
import '../../shared/widgets/header_widget.dart';
import 'widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  static final String route = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color primaryColor;

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(
            backgroundColor: primaryColor,
            height: screenHeight * .15,
            child: Text(
              'Bem-vindo ao F-Tasks',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: null,
                child: ListView(
                  children: [
                    buildEmailField(),
                    const SizedBox(height: 20.0),
                    buildPasswordField(),
                    const SizedBox(height: 20.0),
                    buildLoginButton(context),
                    const SizedBox(height: 20.0),
                    buildSignInButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .2),
      height: 50.0,
      child: OutlinedButton(
        child: Text(
          'Registrar',
        ),
        onPressed: () {},
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .2),
      height: 50.0,
      child: ElevatedButton(
        child: Text('Entrar'),
        onPressed: () {},
      ),
    );
  }

  Widget buildPasswordField() {
    return CustomFormField(
      cursorColor: primaryColor,
      validationFunction: (value) => {},
      labelText: 'Password',
      obscureText: true,
      suffixIcon: Icons.visibility,
      onSuffixIconPressed: () {},
    );
  }

  Widget buildEmailField() {
    return CustomFormField(
      cursorColor: primaryColor,
      keyboardType: TextInputType.emailAddress,
      validationFunction: (value) => {},
      labelText: 'E-mail',
    );
  }
}
