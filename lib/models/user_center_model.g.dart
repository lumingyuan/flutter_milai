// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_center_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCenterModel _$UserCenterModelFromJson(Map<String, dynamic> json) {
  return UserCenterModel(
      json['Count1000'] as String,
      json['IsDistributorApply'] as String,
      json['WeiXinOpenId'] as String,
      json['IsVerificationMobile'] as String,
      json['Count1002'] as String,
      json['MessageCount'] as String,
      json['ShareInfo'] == null
          ? null
          : ShareInfo.fromJson(json['ShareInfo'] as Map<String, dynamic>),
      json['IsMiLaiDistributor'] as String,
      json['CountRefund'] as String,
      json['Sex'] as String,
      json['IsMilaiDistributorApply'] as String,
      json['Integral'] as String,
      json['IsDistributor'] as String,
      json['Birthday'] as String,
      json['NickName'] as String,
      json['Mobile'] as String,
      json['Count1001'] as String,
      json['Count1003'] as String,
      json['Level'] as String,
      json['Distributor'] == null
          ? null
          : Distributor.fromJson(json['Distributor'] as Map<String, dynamic>),
      json['SexName'] as String,
      json['WeiXinNickName'] as String,
      json['WeiXinTXOpenId'] as String,
      json['HeadImageUrl'] as String);
}

Map<String, dynamic> _$UserCenterModelToJson(UserCenterModel instance) =>
    <String, dynamic>{
      'Count1000': instance.count1000,
      'IsDistributorApply': instance.isDistributorApply,
      'WeiXinOpenId': instance.weiXinOpenId,
      'IsVerificationMobile': instance.isVerificationMobile,
      'Count1002': instance.count1002,
      'MessageCount': instance.messageCount,
      'ShareInfo': instance.shareInfo,
      'IsMiLaiDistributor': instance.isMiLaiDistributor,
      'CountRefund': instance.countRefund,
      'Sex': instance.sex,
      'IsMilaiDistributorApply': instance.isMilaiDistributorApply,
      'Integral': instance.integral,
      'IsDistributor': instance.isDistributor,
      'Birthday': instance.birthday,
      'NickName': instance.nickName,
      'Mobile': instance.mobile,
      'Count1001': instance.count1001,
      'Count1003': instance.count1003,
      'Level': instance.level,
      'Distributor': instance.distributor,
      'SexName': instance.sexName,
      'WeiXinNickName': instance.weiXinNickName,
      'WeiXinTXOpenId': instance.weiXinTXOpenId,
      'HeadImageUrl': instance.headImageUrl
    };

ShareInfo _$ShareInfoFromJson(Map<String, dynamic> json) {
  return ShareInfo(json['Link'] as String, json['Title'] as String,
      json['Content'] as String, json['ImgUrl'] as String);
}

Map<String, dynamic> _$ShareInfoToJson(ShareInfo instance) => <String, dynamic>{
      'Link': instance.link,
      'Title': instance.title,
      'Content': instance.content,
      'ImgUrl': instance.imgUrl
    };

Distributor _$DistributorFromJson(Map<String, dynamic> json) {
  return Distributor(
      json['DistributorStoreCount'] as String,
      json['MoneyToday'] as String,
      json['MoneySUM'] as String,
      json['CountTeam'] as String,
      json['Distributor1TeamCount'] as String);
}

Map<String, dynamic> _$DistributorToJson(Distributor instance) =>
    <String, dynamic>{
      'DistributorStoreCount': instance.distributorStoreCount,
      'MoneyToday': instance.moneyToday,
      'MoneySUM': instance.moneySUM,
      'CountTeam': instance.countTeam,
      'Distributor1TeamCount': instance.distributor1TeamCount
    };
