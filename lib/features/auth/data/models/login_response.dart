import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/models/user.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final User user;
  final String token;
  
  LoginResponse({
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}