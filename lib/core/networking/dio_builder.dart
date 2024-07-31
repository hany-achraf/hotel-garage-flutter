import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/bottom_nav_bar.dart';
import '../di/injection_container.dart';
import '../routing/routes.dart';
import 'interceptors/auth_token_interceptor.dart';

class DioBuilder {
  final BaseOptions _baseOptions;
  final List<Interceptor> _interceptors = [];
  Duration _connectTimeout = const Duration(seconds: 60);
  Duration _receiveTimeout = const Duration(seconds: 60);

  DioBuilder()
      : _baseOptions = BaseOptions(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        );

  DioBuilder addPrettyDioLogger() {
    _interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    return this;
  }

  DioBuilder addAuthTokenInterceptor() {
    _interceptors.add(AuthTokenInterceptor());
    return this;
  }

  DioBuilder addErrorInterceptor() {
    _interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401 &&
              (e.requestOptions.extra['Exempt-From-401-Handling'] == null ||
                  !e.requestOptions.extra['Exempt-From-401-Handling'])) {
            await sl<SharedPreferences>().clear();
            sl<BottomNavBarCubit>().updateIndex(0);
            sl<GlobalKey<NavigatorState>>()
                .currentState!
                .pushNamedAndRemoveUntil(
                  Routes.login,
                  (_) => false,
                );
            return;
          }
          handler.next(e);
        },
      ),
    );
    return this;
  }
  
  DioBuilder withConnectTimeout(int milliseconds) {
    _connectTimeout = Duration(seconds: milliseconds);
    return this;
  }

  DioBuilder withReceiveTimeout(int milliseconds) {
    _receiveTimeout = Duration(seconds: milliseconds);
    return this;
  }

  Dio build() {
    Dio dio = Dio(_baseOptions)
      ..options.connectTimeout = _connectTimeout
      ..options.receiveTimeout = _receiveTimeout;

    for (Interceptor interceptor in _interceptors) {
      dio.interceptors.add(interceptor);
    }

    return dio;
  }
}
