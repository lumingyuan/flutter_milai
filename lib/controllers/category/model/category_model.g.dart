// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
      (json['Category23'] as List)
          ?.map((e) =>
              e == null ? null : Category23.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['CategoryAdTop'] == null
          ? null
          : CategoryAdTop.fromJson(
              json['CategoryAdTop'] as Map<String, dynamic>),
      json['CategoryAdBottom'] == null
          ? null
          : CategoryAdBottom.fromJson(
              json['CategoryAdBottom'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'Category23': instance.category23,
      'CategoryAdTop': instance.categoryAdTop,
      'CategoryAdBottom': instance.categoryAdBottom
    };

Category23 _$Category23FromJson(Map<String, dynamic> json) {
  return Category23(
      json['ID'] as String,
      json['ClassCode'] as String,
      json['Subtitle'] as String,
      json['ClassName'] as String,
      json['IconUrl'] as String,
      json['DepthLevel'] as String,
      json['FatherID'] as String,
      (json['CategoryList'] as List)
          ?.map((e) => e == null
              ? null
              : CategoryList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$Category23ToJson(Category23 instance) =>
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

CategoryList _$CategoryListFromJson(Map<String, dynamic> json) {
  return CategoryList(
      json['ID'] as String,
      json['ClassCode'] as String,
      json['Subtitle'] as String,
      json['ClassName'] as String,
      json['IconUrl'] as String,
      json['DepthLevel'] as String,
      json['FatherID'] as String,
      json['CategoryList'] as List);
}

Map<String, dynamic> _$CategoryListToJson(CategoryList instance) =>
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

CategoryAdTop _$CategoryAdTopFromJson(Map<String, dynamic> json) {
  return CategoryAdTop(json['ImgUrl'] as String, json['LinkType'] as String,
      json['LinkUrl'] as String);
}

Map<String, dynamic> _$CategoryAdTopToJson(CategoryAdTop instance) =>
    <String, dynamic>{
      'ImgUrl': instance.imgUrl,
      'LinkType': instance.linkType,
      'LinkUrl': instance.linkUrl
    };

CategoryAdBottom _$CategoryAdBottomFromJson(Map<String, dynamic> json) {
  return CategoryAdBottom(json['ImgUrl'] as String, json['LinkType'] as String,
      json['LinkUrl'] as String);
}

Map<String, dynamic> _$CategoryAdBottomToJson(CategoryAdBottom instance) =>
    <String, dynamic>{
      'ImgUrl': instance.imgUrl,
      'LinkType': instance.linkType,
      'LinkUrl': instance.linkUrl
    };
