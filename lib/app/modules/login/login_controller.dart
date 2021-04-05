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
  final RxNotifier<bool> isLoading = RxNotifier<bool>(false);
  final RxNotifier<String> error = RxNotifier<String>(null);

  void setShowHidePassword() {
    showHidePassword.value = !showHidePassword.value;
  }

  Future<void> login() async {
    try {
      error.value = null;
      isLoading.value = true;
      if (formKey.currentState.validate()) {
        await _auth$.login(email$.text, password$.text);
        isLoading.value = false;
        Modular.to.navigate(HomePage.route, replaceAll: true);
      }
    } catch (e) {
      isLoading.value = false;
      error.value = "Falha na autenticação";
    }
  }
}
