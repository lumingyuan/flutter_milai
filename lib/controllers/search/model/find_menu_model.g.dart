// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindMenuModel _$FindMenuModelFromJson(Map<String, dynamic> json) {
  return FindMenuModel(json['Title'] as String,
      json['BackGroundImgUrl'] as String, json['FindMenuID'] as String);
}

Map<String, dynamic> _$FindMenuModelToJson(FindMenuModel instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'BackGroundImgUrl': instance.backGroundImgUrl,
      'FindMenuID': instance.findMenuID
    };
