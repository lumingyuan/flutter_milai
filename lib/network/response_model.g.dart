// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) {
  return ResponseModel(json['Code'] as int, json['Message'] as String,
      json['Encrypt'] as bool, json['Result']);
}

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Message': instance.message,
      'Encrypt': instance.encrypt,
      'Result': instance.result
    };
