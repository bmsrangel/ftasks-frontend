import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/shared/auth/auth_controller.dart';

import 'custom_dio.dart';

class AuthInterceptor implements InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    final AuthController _auth$ = Modular.get<AuthController>();
    final String token = _auth$.user?.accessToken;
    if (token != null) {
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final Dio _dio = Modular.get<CustomDio>();
      final AuthController _auth$ = Modular.get<AuthController>();
      final RequestOptions options = err.response.requestOptions;
      await _auth$.refreshToken();
      options.headers['Authorization'] = 'Bearer ${_auth$.user?.accessToken}';
      final Response newResponse = await _dio.request(
        options.path,
        data: options.data,
        queryParameters: options.queryParameters,
        options: Options(
          headers: options.headers,
          contentType: options.contentType,
          method: options.method,
          extra: options.extra,
          requestEncoder: options.requestEncoder,
          responseDecoder: options.responseDecoder,
        ),
      );
      return handler.resolve(newResponse);
    } else {
      return handler.next(err);
    }
  }
}
