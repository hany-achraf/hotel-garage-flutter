part of 'new_visit_cubit.dart';

@freezed
class NewVisitState with _$NewVisitState {
  const factory NewVisitState.initial() = _Initial;
  const factory NewVisitState.loading() = Loading;
  const factory NewVisitState.success() = Success;
  const factory NewVisitState.error() = Error;
}
