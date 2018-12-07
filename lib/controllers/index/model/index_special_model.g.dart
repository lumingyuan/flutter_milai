// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_special_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexSpecialModel _$IndexSpecialModelFromJson(Map<String, dynamic> json) {
  return IndexSpecialModel(
      json['AdExpandTBID'] as String,
      json['ImageUrl'] as String,
      json['AdTBID'] as String,
      (json['SpecialCategoryList'] as List)
          ?.map((e) => e == null
              ? null
              : SpecialCategoryList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['Title'] as String,
      (json['SpecialProductList'] as List)
          ?.map((e) => e == null
              ? null
              : SpecialProductList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$IndexSpecialModelToJson(IndexSpecialModel instance) =>
    <String, dynamic>{
      'AdExpandTBID': instance.adExpandTBID,
      'ImageUrl': instance.imageUrl,
      'AdTBID': instance.adTBID,
      'SpecialCategoryList': instance.specialCategoryList,
      'Title': instance.title,
      'SpecialProductList': instance.specialProductList
    };

SpecialCategoryList _$SpecialCategoryListFromJson(Map<String, dynamic> json) {
  return SpecialCategoryList(
      json['AdExpandCategoryTBID'] as String, json['ClassName'] as String);
}

Map<String, dynamic> _$SpecialCategoryListToJson(
        SpecialCategoryList instance) =>
    <String, dynamic>{
      'AdExpandCategoryTBID': instance.adExpandCategoryTBID,
      'ClassName': instance.className
    };

SpecialProductList _$SpecialProductListFromJson(Map<String, dynamic> json) {
  return SpecialProductList(
      json['ImageUrl'] as String,
      json['StoreTBID'] as String,
      json['ActivityInfo'] as List,
      json['ProductTBID'] as String,
      json['MerchantTBID'] as String,
      json['Sales'] as String,
      json['ProductName'] as String,
      json['IsFreePostage'] as String,
      json['Price'] as String,
      json['IsShowSales'] as String,
      json['Unit'] as String);
}

Map<String, dynamic> _$SpecialProductListToJson(SpecialProductList instance) =>
    <String, dynamic>{
      'ImageUrl': instance.imageUrl,
      'StoreTBID': instance.storeTBID,
      'ActivityInfo': instance.activityInfo,
      'ProductTBID': instance.productTBID,
      'MerchantTBID': instance.merchantTBID,
      'Sales': instance.sales,
      'ProductName': instance.productName,
      'IsFreePostage': instance.isFreePostage,
      'Price': instance.price,
      'IsShowSales': instance.isShowSales,
      'Unit': instance.unit
    };
