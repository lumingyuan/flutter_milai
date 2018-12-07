// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexModel _$IndexModelFromJson(Map<String, dynamic> json) {
  return IndexModel(
      (json['AdRotationList'] as List)
          ?.map((e) => e == null
              ? null
              : AdRotationList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['CategoryList'] as List)
          ?.map((e) => e == null
              ? null
              : CategoryList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['UserCouponInfo'] == null
          ? null
          : UserCouponInfo.fromJson(
              json['UserCouponInfo'] as Map<String, dynamic>),
      json['Announcement'] as List,
      json['RecommendProductBgUrl'] as String,
      json['AdIndexList'] as List,
      (json['ActivityAdList2'] as List)
          ?.map((e) => e == null
              ? null
              : ActivityAdList2.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['FeaturedShop'] as List)
          ?.map((e) => e == null
              ? null
              : FeaturedShop.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['ActivityAdList1'] as List)
          ?.map((e) => e == null
              ? null
              : ActivityAdList1.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$IndexModelToJson(IndexModel instance) =>
    <String, dynamic>{
      'AdRotationList': instance.adRotationList,
      'CategoryList': instance.categoryList,
      'UserCouponInfo': instance.userCouponInfo,
      'Announcement': instance.announcement,
      'RecommendProductBgUrl': instance.recommendProductBgUrl,
      'AdIndexList': instance.adIndexList,
      'ActivityAdList2': instance.activityAdList2,
      'FeaturedShop': instance.featuredShop,
      'ActivityAdList1': instance.activityAdList1
    };

AdRotationList _$AdRotationListFromJson(Map<String, dynamic> json) {
  return AdRotationList(
      json['AdAreaTBID'] as String,
      json['Time'] as String,
      json['ImageUrl'] as String,
      json['linkUrl'] as String,
      json['linkType'] as String,
      json['linkTypeName'] as String,
      json['Title'] as String,
      json['Subtitle'] as String,
      json['Alt'] as String);
}

Map<String, dynamic> _$AdRotationListToJson(AdRotationList instance) =>
    <String, dynamic>{
      'AdAreaTBID': instance.adAreaTBID,
      'Time': instance.time,
      'ImageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'linkType': instance.linkType,
      'linkTypeName': instance.linkTypeName,
      'Title': instance.title,
      'Subtitle': instance.subtitle,
      'Alt': instance.alt
    };

CategoryList _$CategoryListFromJson(Map<String, dynamic> json) {
  return CategoryList(
      json['AdAreaTBID'] as String,
      json['Time'] as String,
      json['ImageUrl'] as String,
      json['linkUrl'] as String,
      json['linkType'] as String,
      json['linkTypeName'] as String,
      json['Title'] as String,
      json['Subtitle'] as String,
      json['Alt'] as String);
}

Map<String, dynamic> _$CategoryListToJson(CategoryList instance) =>
    <String, dynamic>{
      'AdAreaTBID': instance.adAreaTBID,
      'Time': instance.time,
      'ImageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'linkType': instance.linkType,
      'linkTypeName': instance.linkTypeName,
      'Title': instance.title,
      'Subtitle': instance.subtitle,
      'Alt': instance.alt
    };

UserCouponInfo _$UserCouponInfoFromJson(Map<String, dynamic> json) {
  return UserCouponInfo(json['CouponCount'] as String,
      json['UserCouponList'] as List, json['SourceTypeName'] as String);
}

Map<String, dynamic> _$UserCouponInfoToJson(UserCouponInfo instance) =>
    <String, dynamic>{
      'CouponCount': instance.couponCount,
      'UserCouponList': instance.userCouponList,
      'SourceTypeName': instance.sourceTypeName
    };

ActivityAdList2 _$ActivityAdList2FromJson(Map<String, dynamic> json) {
  return ActivityAdList2(
      json['AdAreaTBID'] as String,
      json['Time'] as String,
      json['ImageUrl'] as String,
      json['linkUrl'] as String,
      json['linkType'] as String,
      json['linkTypeName'] as String,
      json['Title'] as String,
      json['Subtitle'] as String,
      json['Alt'] as String);
}

Map<String, dynamic> _$ActivityAdList2ToJson(ActivityAdList2 instance) =>
    <String, dynamic>{
      'AdAreaTBID': instance.adAreaTBID,
      'Time': instance.time,
      'ImageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'linkType': instance.linkType,
      'linkTypeName': instance.linkTypeName,
      'Title': instance.title,
      'Subtitle': instance.subtitle,
      'Alt': instance.alt
    };

FeaturedShop _$FeaturedShopFromJson(Map<String, dynamic> json) {
  return FeaturedShop(
      json['AdAreaTBID'] as String,
      json['Time'] as String,
      json['ImageUrl'] as String,
      json['linkUrl'] as String,
      json['linkType'] as String,
      json['linkTypeName'] as String,
      json['Title'] as String,
      json['Subtitle'] as String,
      json['Alt'] as String);
}

Map<String, dynamic> _$FeaturedShopToJson(FeaturedShop instance) =>
    <String, dynamic>{
      'AdAreaTBID': instance.adAreaTBID,
      'Time': instance.time,
      'ImageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'linkType': instance.linkType,
      'linkTypeName': instance.linkTypeName,
      'Title': instance.title,
      'Subtitle': instance.subtitle,
      'Alt': instance.alt
    };

ActivityAdList1 _$ActivityAdList1FromJson(Map<String, dynamic> json) {
  return ActivityAdList1(
      json['AdAreaTBID'] as String,
      json['Time'] as String,
      json['ImageUrl'] as String,
      json['linkUrl'] as String,
      json['linkType'] as String,
      json['linkTypeName'] as String,
      json['Title'] as String,
      json['Subtitle'] as String,
      json['Alt'] as String);
}

Map<String, dynamic> _$ActivityAdList1ToJson(ActivityAdList1 instance) =>
    <String, dynamic>{
      'AdAreaTBID': instance.adAreaTBID,
      'Time': instance.time,
      'ImageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'linkType': instance.linkType,
      'linkTypeName': instance.linkTypeName,
      'Title': instance.title,
      'Subtitle': instance.subtitle,
      'Alt': instance.alt
    };
