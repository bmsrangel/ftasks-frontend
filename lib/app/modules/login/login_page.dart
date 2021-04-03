import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../shared/widgets/header_widget.dart';
import 'login_controller.dart';
import 'widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  static final String route = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color primaryColor;

  final LoginController _login$ = Modular.get<LoginController>();

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
                key: _login$.formKey,
                child: ListView(
                  children: [
                    buildEmailField(),
                    const SizedBox(height: 20.0),
                    RxBuilder(
                      builder: (_) => buildPasswordField(
                        showHidePassword: _login$.showHidePassword.value,
                        onSuffixIconPressed: _login$.setShowHidePassword,
                      ),
                    ),
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
        onPressed: _login$.login,
      ),
    );
  }

  Widget buildPasswordField(
      {bool showHidePassword, Function onSuffixIconPressed}) {
    return CustomFormField(
      controller: _login$.password$,
      cursorColor: primaryColor,
      validationFunction: _login$.passwordValidation,
      labelText: 'Password',
      obscureText: showHidePassword,
      suffixIcon: showHidePassword ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: onSuffixIconPressed,
    );
  }

  Widget buildEmailField() {
    return CustomFormField(
      controller: _login$.email$,
      cursorColor: primaryColor,
      keyboardType: TextInputType.emailAddress,
      // validationFunction: (email) => _login$.emailValidation(email),
      validationFunction: _login$.emailValidation,
      labelText: 'E-mail',
    );
  }
}
