// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_trace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindTraceModel _$FindTraceModelFromJson(Map<String, dynamic> json) {
  return FindTraceModel(
      json['UserProductLogTBID'] as String,
      json['ProductTBID'] as String,
      json['Name'] as String,
      json['ImageUrl'] as String,
      json['Price'] as String,
      json['BelongMDStoreID'] as String,
      json['BelongMDType'] as String,
      json['InventorySituation'] as String,
      json['BrowseTime'] as String);
}

Map<String, dynamic> _$FindTraceModelToJson(FindTraceModel instance) =>
    <String, dynamic>{
      'UserProductLogTBID': instance.userProductLogTBID,
      'ProductTBID': instance.productTBID,
      'Name': instance.name,
      'ImageUrl': instance.imageUrl,
      'Price': instance.price,
      'BelongMDStoreID': instance.belongMDStoreID,
      'BelongMDType': instance.belongMDType,
      'InventorySituation': instance.inventorySituation,
      'BrowseTime': instance.browseTime
    };
