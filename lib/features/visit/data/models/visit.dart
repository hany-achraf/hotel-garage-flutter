import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit.g.dart';

@JsonSerializable()
class Visit {
  final int id;

  @JsonKey(name: 'plate_no')
  final String plateNo;

  final String? email;
  
  @JsonKey(name: 'phone_no')
  final String? phoneNo;

  @JsonKey(name: 'is_paid')
  final bool isPaid;

  const Visit({
    required this.id,
    required this.plateNo,
    this.email,
    this.phoneNo,
    required this.isPaid,
  });

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);
}