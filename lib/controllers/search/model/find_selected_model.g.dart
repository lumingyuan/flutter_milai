// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_selected_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindSelectedModel _$FindSelectedModelFromJson(Map<String, dynamic> json) {
  return FindSelectedModel(
      json['CardType'] as String,
      json['UserHeadImgUrl'] as String,
      (json['CardImgList'] as List)?.map((e) => e as String)?.toList(),
      json['FindSelectedTBID'] as String,
      json['FabulousNum'] as String,
      json['IsUserFabulous'] as String,
      json['Title'] as String,
      json['Subtitle'] as String,
      json['BrowseNum'] as String,
      json['Describe'] as String);
}

Map<String, dynamic> _$FindSelectedModelToJson(FindSelectedModel instance) =>
    <String, dynamic>{
      'CardType': instance.cardType,
      'UserHeadImgUrl': instance.userHeadImgUrl,
      'CardImgList': instance.cardImgList,
      'FindSelectedTBID': instance.findSelectedTBID,
      'FabulousNum': instance.fabulousNum,
      'IsUserFabulous': instance.isUserFabulous,
      'Title': instance.title,
      'Subtitle': instance.subtitle,
      'BrowseNum': instance.browseNum,
      'Describe': instance.describe
    };