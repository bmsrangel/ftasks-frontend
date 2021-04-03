import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/app/shared/models/user_model.dart';

class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  Future<UserModel> login(String email, String password) async {
    final Response response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });

    if (response.data == null) {
      return null;
    } else {
      return UserModel.fromMap(response.data);
    }
  }

  Future<String> refreshToken(String oldToken) async {
    final Response response = await _dio.put('/tokens/refresh', data: {
      'oldToken': oldToken,
    });

    return response.data['access_token'];
  }

  Future<void> register() async {}
}
