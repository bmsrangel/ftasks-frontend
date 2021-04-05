import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/shared/auth/auth_controller.dart';
import 'package:mobile/app/shared/auth/models/user_dto.dart';
import 'package:rx_notifier/rx_notifier.dart';

class RegisterController {
  RegisterController(this._auth$);

  final AuthController _auth$;

  final TextEditingController name$ = TextEditingController();
  final TextEditingController email$ = TextEditingController();
  final TextEditingController password$ = TextEditingController();
  final TextEditingController confirmPassword$ = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxNotifier<bool> hidePassword = RxNotifier<bool>(true);
  final RxNotifier<bool> hideConfirmPassword = RxNotifier<bool>(true);

  // DRY = Don't Repeat Yourself
  Future<void> register() async {
    if (formKey.currentState.validate()) {
      try {
        final UserDto userData = UserDto(
          name: name$.text,
          email: email$.text,
          password: password$.text,
        );
        await _auth$.register(userData);
        Modular.to.pop();
      } catch (e) {}
    }
  }

  showHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  showHideConfirmPassword() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }
}
