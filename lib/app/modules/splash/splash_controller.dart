import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/modules/home/home_page.dart';
import 'package:mobile/app/modules/login/login_page.dart';
import 'package:mobile/app/shared/auth/auth_controller.dart';
import 'package:mobile/app/shared/models/user_model.dart';
import 'package:mobile/app/shared/services/user_local_storage_service.dart';

class SplashController {
  SplashController(this._storageService, this._auth$);

  final UserLocalStorageService _storageService;
  final AuthController _auth$;

  Future<void> getUserData() async {
    final UserModel userData = await _storageService.getUserData();
    if (userData == null) {
      Modular.to.navigate(LoginPage.route, replaceAll: true);
    } else {
      _auth$.user = userData;
      Modular.to.navigate(HomePage.route, replaceAll: true);
    }
  }
}
