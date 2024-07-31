import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repos/auth_repo.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _repo;
  LoginCubit(
    this._repo,
  ) : super(const LoginState.initial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const LoginState.loading());
    final result = await _repo.login(email: email, password: password);
    result.fold(
      (e) {
        if (e is DioException &&
            (e.response!.statusCode == HttpStatus.unauthorized ||
                e.response!.statusCode == HttpStatus.unprocessableEntity)) {
          emit(const LoginState.invalidCredentials());
        } else {
          emit(const LoginState.error());
        }
      },
      (_) => emit(const LoginState.success()),
    );
  }
}
