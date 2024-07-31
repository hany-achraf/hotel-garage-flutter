import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/auth/data/models/login_response.dart';
import '../../features/visit/data/models/visit.dart';
import '../constants/constants.dart';

part 'api.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @POST('/auth/login')
  @Extra({'Exempt-From-401-Handling': true})
  Future<LoginResponse> login({
    @Field('email') required String email,
    @Field('password') required String password,
  });

  @POST('/visits')
  Future<void> createNewVisit({
    @Field('qr_code') required String qrCode,
    @Field('plate_no') required String plateNo,
    @Field('email') String? email,
    @Field('phone_no') String? phoneNo,
    @Field('entry_guard_id') required int entryGuardId,
    @Field('entry_gate_id') required int entryGateId,
  });

  @GET('/visits')
  Future<Visit> getVisit(@Query('qr_code') String qrCode);

  @POST('/visits/{id}/end')
  Future<void> endVisit({
    @Path('id') required int id,
    @Field('exit_guard_id') required int exitGuardId,
    @Field('exit_gate_id') required int exitGateId,
  });
}
