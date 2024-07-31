import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repos/visits_repo.dart';

part 'new_visit_state.dart';
part 'new_visit_cubit.freezed.dart';

class NewVisitCubit extends Cubit<NewVisitState> {
  final VisitsRepo _repo;

  NewVisitCubit(
    this._repo,
  ) : super(const NewVisitState.initial());

  Future<void> createNewVisit({
    required String qrCode,
    required String plateNo,
    String? email,
    String? phoneNo,
    required int entryGateId,
  }) async {
    emit(const NewVisitState.loading());
    final result = await _repo.createNewVisit(
      qrCode: qrCode,
      email: email,
      plateNo: plateNo,
      phoneNo: phoneNo,
      entryGateId: entryGateId,
    );
    result.fold(
      (_) => emit(const NewVisitState.error()),
      (_) => emit(const NewVisitState.success()),
    );
  }
}
