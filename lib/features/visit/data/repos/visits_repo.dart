import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import '../../../../core/helpers/index.dart' as helpers;
import '../../../../core/networking/api.dart';

class VisitsRepo {
  final Api _api;

  VisitsRepo(this._api);

  Future<Either<Exception, Unit>> createNewVisit({
    required String qrCode,
    required String plateNo,
    String? email,
    String? phoneNo,
    required int entryGateId,
  }) async {
    try {
      final userId = helpers.getUserIdFromLocalStorage();
      await _api.createNewVisit(
        qrCode: qrCode,
        email: email,
        phoneNo: phoneNo,
        plateNo: plateNo,
        entryGuardId: userId!,
        entryGateId: entryGateId,
      );
      return right(unit);
    } catch (e) {
      log(
        'Error creating new visit',
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
