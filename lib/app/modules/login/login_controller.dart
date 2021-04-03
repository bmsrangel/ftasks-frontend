import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/modules/home/home_page.dart';
import 'package:mobile/app/shared/auth/auth_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class LoginController {
  LoginController(this._auth$);

  final AuthController _auth$;

  final TextEditingController email$ = TextEditingController();
  final TextEditingController password$ = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxNotifier<bool> showHidePassword = RxNotifier<bool>(true);

  String emailValidation(String email) {
    if (email.isEmpty) {
      return 'E-mail é obrigatório';
    } else if (!email.contains('@')) {
      return 'Formato de e-mail inválido';
    } else {
      return null;
    }
  }

  String passwordValidation(String password) {
    if (password.isEmpty) {
      return 'A senha é obrigatória';
    } else if (password.length < 6) {
      return 'A senha precisa de no mínimo 6 caracteres';
    } else {
      return null;
    }
  }

  void setShowHidePassword() {
    showHidePassword.value = !showHidePassword.value;
  }

  Future<void> login() async {
    try {
      if (formKey.currentState.validate()) {
        await _auth$.login(email$.text, password$.text);
        Modular.to.navigate(HomePage.route, replaceAll: true);
      }
    } catch (e) {}
  }
}
