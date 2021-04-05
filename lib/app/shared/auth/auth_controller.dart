import 'package:mobile/app/shared/auth/models/user_dto.dart';
import 'package:mobile/app/shared/auth/repositories/auth_repository.dart';
import 'package:mobile/app/shared/models/user_model.dart';
import 'package:mobile/app/shared/services/user_local_storage_service.dart';

class AuthController {
  AuthController(this._authRepository, this._storageService);

  final AuthRepository _authRepository;
  final UserLocalStorageService _storageService;

  UserModel user;

  Future<void> login(String email, String password) async {
    user = await _authRepository.login(email, password);
    if (user != null) {
      await _storageService.setUserData(user);
    }
  }

  Future<void> refreshToken() async {
    final String oldToken = user.accessToken;
    final String newToken = await _authRepository.refreshToken(oldToken);
    if (newToken != null) {
      user = user.copyWith(
        accessToken: newToken,
      );
      await _storageService.setUserData(user);
    }
  }

  Future<void> logout() async {
    user = null;
    await _storageService.clearUserData();
  }

  Future<void> register(UserDto userData) async {
    await _authRepository.register(userData);
  }
}
