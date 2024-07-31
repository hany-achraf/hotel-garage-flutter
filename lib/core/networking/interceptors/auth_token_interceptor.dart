import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/injection_container.dart';

class AuthTokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = sl<SharedPreferences>().getString('token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
