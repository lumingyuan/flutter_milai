import 'package:json_annotation/json_annotation.dart'; 
  
part 'user_center_model.g.dart';


@JsonSerializable()
  class UserCenterModel extends Object {

  @JsonKey(name: 'Count1000')
  String count1000;

  @JsonKey(name: 'IsDistributorApply')
  String isDistributorApply;

  @JsonKey(name: 'WeiXinOpenId')
  String weiXinOpenId;

  @JsonKey(name: 'IsVerificationMobile')
  String isVerificationMobile;

  @JsonKey(name: 'Count1002')
  String count1002;

  @JsonKey(name: 'MessageCount')
  String messageCount;

  @JsonKey(name: 'ShareInfo')
  ShareInfo shareInfo;

  @JsonKey(name: 'IsMiLaiDistributor')
  String isMiLaiDistributor;

  @JsonKey(name: 'CountRefund')
  String countRefund;

  @JsonKey(name: 'Sex')
  String sex;

  @JsonKey(name: 'IsMilaiDistributorApply')
  String isMilaiDistributorApply;

  @JsonKey(name: 'Integral')
  String integral;

  @JsonKey(name: 'IsDistributor')
  String isDistributor;

  @JsonKey(name: 'Birthday')
  String birthday;

  @JsonKey(name: 'NickName')
  String nickName;

  @JsonKey(name: 'Mobile')
  String mobile;

  @JsonKey(name: 'Count1001')
  String count1001;

  @JsonKey(name: 'Count1003')
  String count1003;

  @JsonKey(name: 'Level')
  String level;

  @JsonKey(name: 'Distributor')
  Distributor distributor;

  @JsonKey(name: 'SexName')
  String sexName;

  @JsonKey(name: 'WeiXinNickName')
  String weiXinNickName;

  @JsonKey(name: 'WeiXinTXOpenId')
  String weiXinTXOpenId;

  @JsonKey(name: 'HeadImageUrl')
  String headImageUrl;

  UserCenterModel(this.count1000,this.isDistributorApply,this.weiXinOpenId,this.isVerificationMobile,this.count1002,this.messageCount,this.shareInfo,this.isMiLaiDistributor,this.countRefund,this.sex,this.isMilaiDistributorApply,this.integral,this.isDistributor,this.birthday,this.nickName,this.mobile,this.count1001,this.count1003,this.level,this.distributor,this.sexName,this.weiXinNickName,this.weiXinTXOpenId,this.headImageUrl,);

  factory UserCenterModel.fromJson(Map<String, dynamic> srcJson) => _$UserCenterModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserCenterModelToJson(this);

}

  
@JsonSerializable()
  class ShareInfo extends Object {

  @JsonKey(name: 'Link')
  String link;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Content')
  String content;

  @JsonKey(name: 'ImgUrl')
  String imgUrl;

  ShareInfo(this.link,this.title,this.content,this.imgUrl,);

  factory ShareInfo.fromJson(Map<String, dynamic> srcJson) => _$ShareInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShareInfoToJson(this);

}

  
@JsonSerializable()
  class Distributor extends Object {

  @JsonKey(name: 'DistributorStoreCount')
  String distributorStoreCount;

  @JsonKey(name: 'MoneyToday')
  String moneyToday;

  @JsonKey(name: 'MoneySUM')
  String moneySUM;

  @JsonKey(name: 'CountTeam')
  String countTeam;

  @JsonKey(name: 'Distributor1TeamCount')
  String distributor1TeamCount;

  Distributor(this.distributorStoreCount,this.moneyToday,this.moneySUM,this.countTeam,this.distributor1TeamCount,);

  factory Distributor.fromJson(Map<String, dynamic> srcJson) => _$DistributorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DistributorToJson(this);

}

  
