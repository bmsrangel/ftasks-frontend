import 'package:dio/native_imp.dart';
import 'package:mobile/app/shared/custom_dio/auth_interceptor.dart';
import 'package:mobile/app/shared/utils/constants.dart';

class CustomDio extends DioForNative {
  CustomDio() {
    options.baseUrl = BASE_URL;
    options.connectTimeout = 5000;
    interceptors.add(AuthInterceptor());
  }
}
