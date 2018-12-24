import 'package:json_annotation/json_annotation.dart'; 
  
part 'user_model.g.dart';


@JsonSerializable()
  class UserModel extends Object {

  @JsonKey(name: 'LastLoginTime')
  String lastLoginTime;

  @JsonKey(name: 'IsDistributorApply')
  String isDistributorApply;

  @JsonKey(name: 'PushID')
  String pushID;

  @JsonKey(name: 'Address')
  String address;

  @JsonKey(name: 'WeiXinUnionId')
  String weiXinUnionId;

  @JsonKey(name: 'WeiXinOpenId')
  String weiXinOpenId;

  @JsonKey(name: 'Email')
  String email;

  @JsonKey(name: 'HeadImageUrl')
  String headImageUrl;

  @JsonKey(name: 'Account')
  String account;

  @JsonKey(name: 'WeiXinNickName')
  String weiXinNickName;

  @JsonKey(name: 'ProvinceCode')
  String provinceCode;

  @JsonKey(name: 'Sex')
  String sex;

  @JsonKey(name: 'QQ')
  String qQ;

  @JsonKey(name: 'Integral')
  String integral;

  @JsonKey(name: 'CityCode')
  String cityCode;

  @JsonKey(name: 'IsSubscribe')
  String isSubscribe;

  @JsonKey(name: 'SexName')
  String sexName;

  @JsonKey(name: 'TerminalType')
  String terminalType;

  @JsonKey(name: 'Lng')
  String lng;

  @JsonKey(name: 'Mobile')
  String mobile;

  @JsonKey(name: 'AliPay')
  String aliPay;

  @JsonKey(name: 'AreaCode')
  String areaCode;

  @JsonKey(name: 'ID')
  String iD;

  @JsonKey(name: 'Lat')
  String lat;

  @JsonKey(name: 'WeiXin')
  String weiXin;

  @JsonKey(name: 'StreetCode')
  String streetCode;

  @JsonKey(name: 'MiLaiMoney')
  String miLaiMoney;

  @JsonKey(name: 'WeiXinTXOpenId')
  String weiXinTXOpenId;

  @JsonKey(name: 'Birthday')
  String birthday;

  @JsonKey(name: 'IsNewUser')
  String isNewUser;

  @JsonKey(name: 'NickName')
  String nickName;

  @JsonKey(name: 'RealName')
  String realName;

  @JsonKey(name: 'WeiXinPCOpenId')
  String weiXinPCOpenId;

  @JsonKey(name: 'Level')
  String level;

  @JsonKey(name: 'IsPush')
  String isPush;

  @JsonKey(name: 'IsVerificationEmail')
  String isVerificationEmail;

  @JsonKey(name: 'IsVerificationMobile')
  String isVerificationMobile;

  UserModel(this.lastLoginTime,this.isDistributorApply,this.pushID,this.address,this.weiXinUnionId,this.weiXinOpenId,this.email,this.headImageUrl,this.account,this.weiXinNickName,this.provinceCode,this.sex,this.qQ,this.integral,this.cityCode,this.isSubscribe,this.sexName,this.terminalType,this.lng,this.mobile,this.aliPay,this.areaCode,this.iD,this.lat,this.weiXin,this.streetCode,this.miLaiMoney,this.weiXinTXOpenId,this.birthday,this.isNewUser,this.nickName,this.realName,this.weiXinPCOpenId,this.level,this.isPush,this.isVerificationEmail,this.isVerificationMobile,);

  factory UserModel.fromJson(Map<String, dynamic> srcJson) => _$UserModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}

  
