// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassModel _$ClassModelFromJson(Map<String, dynamic> json) {
  return ClassModel(
      json['ID'] as String,
      json['ClassCode'] as String,
      json['Subtitle'] as String,
      json['ClassName'] as String,
      json['IconUrl'] as String,
      json['DepthLevel'] as String,
      json['FatherID'] as String,
      json['CategoryList'] as List);
}

Map<String, dynamic> _$ClassModelToJson(ClassModel instance) =>
    <String, dynamic>{
      'ID': instance.iD,
      'ClassCode': instance.classCode,
      'Subtitle': instance.subtitle,
      'ClassName': instance.className,
      'IconUrl': instance.iconUrl,
      'DepthLevel': instance.depthLevel,
      'FatherID': instance.fatherID,
      'CategoryList': instance.categoryList
    };
