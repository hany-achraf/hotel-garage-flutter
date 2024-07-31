// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visit _$VisitFromJson(Map<String, dynamic> json) => Visit(
      id: (json['id'] as num).toInt(),
      plateNo: json['plate_no'] as String,
      email: json['email'] as String?,
      phoneNo: json['phone_no'] as String?,
      isPaid: json['is_paid'] as bool,
    );

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'id': instance.id,
      'plate_no': instance.plateNo,
      'email': instance.email,
      'phone_no': instance.phoneNo,
      'is_paid': instance.isPaid,
    };
