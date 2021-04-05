import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/app/modules/login/pages/register_controller.dart';
import 'package:mobile/app/shared/utils/validator.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../shared/widgets/header_widget.dart';
import '../widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  static final String route = 'register';

  const RegisterPage({Key key}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final RegisterController _register$ = Modular.get<RegisterController>();

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
                key: _register$.formKey,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    buildNameField(primaryColor, _register$.name$),
                    const SizedBox(height: 15.0),
                    buildEmailField(primaryColor, _register$.email$),
                    const SizedBox(height: 15.0),
                    RxBuilder(
                      builder: (context) => buildPasswordField(
                        primaryColor,
                        _register$.hidePassword.value,
                        _register$.showHidePassword,
                        _register$.password$,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    RxBuilder(
                      builder: (context) => buildConfirmPasswordField(
                        primaryColor,
                        _register$.hideConfirmPassword.value,
                        _register$.showHideConfirmPassword,
                        _register$.confirmPassword$,
                      ),
                    ),
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
        style: GoogleFonts.righteous(
            textStyle: TextStyle(
          fontSize: 32.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        )),
      ),
    );
  }

  Widget buildNameField(
    Color primaryColor,
    TextEditingController controller,
  ) {
    return CustomFormField(
      labelText: 'Nome',
      controller: controller,
      cursorColor: primaryColor,
      validationFunction: Validator.nameValidation,
    );
  }

  Widget buildEmailField(
    Color primaryColor,
    TextEditingController controller,
  ) {
    return CustomFormField(
      labelText: 'E-mail',
      controller: controller,
      cursorColor: primaryColor,
      keyboardType: TextInputType.emailAddress,
      validationFunction: Validator.emailValidation,
    );
  }

  Widget buildPasswordField(
    Color primaryColor,
    bool isObscure,
    Function onSuffixIconPressed,
    TextEditingController controller,
  ) {
    return CustomFormField(
      labelText: 'Senha',
      controller: controller,
      cursorColor: primaryColor,
      obscureText: isObscure,
      suffixIcon: isObscure ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: onSuffixIconPressed,
      validationFunction: Validator.passwordValidation,
    );
  }

  Widget buildConfirmPasswordField(
    Color primaryColor,
    bool isObscure,
    Function onSuffixIconPressed,
    TextEditingController controller,
  ) {
    return CustomFormField(
      labelText: 'Confirmação da senha',
      controller: controller,
      cursorColor: primaryColor,
      obscureText: isObscure,
      suffixIcon: isObscure ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: onSuffixIconPressed,
      validationFunction: (passwordConfirmation) {
        final String currentPassword = _register$.password$.text;
        return Validator.confirmPasswordValidation(
          currentPassword,
          passwordConfirmation,
        );
      },
    );
  }

  Widget buildRegisterButton() {
    return Container(
      height: 50.0,
      child: ElevatedButton(
        onPressed: _register$.register,
        child: Text('Registrar'),
      ),
    );
  }

  Widget buildBackButton() {
    return Container(
      height: 50.0,
      child: OutlinedButton(
        onPressed: () {
          Modular.to.pop();
        },
        child: Text('Voltar'),
      ),
    );
  }
}
