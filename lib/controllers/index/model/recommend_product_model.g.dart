// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendProductModel _$RecommendProductModelFromJson(
    Map<String, dynamic> json) {
  return RecommendProductModel(
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

Map<String, dynamic> _$RecommendProductModelToJson(
        RecommendProductModel instance) =>
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