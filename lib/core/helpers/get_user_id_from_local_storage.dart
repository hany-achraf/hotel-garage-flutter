import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../di/injection_container.dart';

int? getUserIdFromLocalStorage() {
  final userString = sl<SharedPreferences>().getString('user');
  if (userString == null) {
    return null;
  }

  final userMap = jsonDecode(userString) as Map<String, dynamic>;
  final userId = userMap['id'] as int;

  return userId;
}
