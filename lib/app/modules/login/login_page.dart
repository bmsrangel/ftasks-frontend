import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/app/modules/login/pages/register_page.dart';
import 'package:mobile/app/shared/mixins/loader_mixin.dart';
import 'package:mobile/app/shared/mixins/messages_mixin.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../shared/widgets/header_widget.dart';
import 'login_controller.dart';
import 'widgets/custom_form_field.dart';
import '../../shared/utils/validator.dart';

class LoginPage extends StatefulWidget {
  static final String route = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoaderMixin, MessagesMixin {
  Color primaryColor;

  final LoginController _login$ = Modular.get<LoginController>();

  @override
  void initState() {
    rxObserver(() {
      showHideLoaderHelper(context, _login$.isLoading.value);
      if (_login$.error.value != null) {
        showError(message: _login$.error.value, context: context);
      }
    });
    super.initState();
  }

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
              'Bem-vindo ao F-Tasks!',
              style: GoogleFonts.righteous(
                  textStyle: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              )),
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
        onPressed: () {
          Modular.to.pushNamed(RegisterPage.route);
        },
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
      validationFunction: Validator.passwordValidation,
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
      validationFunction: Validator.emailValidation,
      labelText: 'E-mail',
    );
  }
}
