import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/networking/api.dart';

class AuthRepo {
  final Api _api;
  final SharedPreferences _prefes;

  AuthRepo(this._api, this._prefes);

  Future<Either<Exception, Unit>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.login(
        email: email,
        password: password,
      );
      await _prefes.setString('user', jsonEncode(response.user.toJson()));
      await _prefes.setString('token', response.token);
      return right(unit);
    } catch (e) {
      log(
        'AuthRepo.login: $e',
        error: e,
        stackTrace: StackTrace.current,
      );
      if (e is! Exception) {
        return left(Exception(e));
      } else {
        return left(e);
      }
    }
  }
}
