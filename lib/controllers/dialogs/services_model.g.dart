// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesModel _$ServicesModelFromJson(Map<String, dynamic> json) {
  return ServicesModel(
      (json['CustomServiceList'] as List)
          ?.map((e) => e == null
              ? null
              : CustomServiceList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['SystemSetting'] == null
          ? null
          : SystemSetting.fromJson(
              json['SystemSetting'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ServicesModelToJson(ServicesModel instance) =>
    <String, dynamic>{
      'CustomServiceList': instance.customServiceList,
      'SystemSetting': instance.systemSetting
    };

CustomServiceList _$CustomServiceListFromJson(Map<String, dynamic> json) {
  return CustomServiceList(json['QQ'] as String, json['Tel'] as String,
      json['DisplayName'] as String);
}

Map<String, dynamic> _$CustomServiceListToJson(CustomServiceList instance) =>
    <String, dynamic>{
      'QQ': instance.qQ,
      'Tel': instance.tel,
      'DisplayName': instance.displayName
    };

SystemSetting _$SystemSettingFromJson(Map<String, dynamic> json) {
  return SystemSetting(json['Title'] as String, json['Value'] as String,
      json['Description'] as String);
}

Map<String, dynamic> _$SystemSettingToJson(SystemSetting instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Value': instance.value,
      'Description': instance.description
    };
