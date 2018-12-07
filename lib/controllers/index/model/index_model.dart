import 'package:json_annotation/json_annotation.dart'; 
  
part 'index_model.g.dart';


@JsonSerializable()
  class IndexModel extends Object {

  @JsonKey(name: 'AdRotationList')
  List<AdRotationList> adRotationList;

  @JsonKey(name: 'CategoryList')
  List<CategoryList> categoryList;

  @JsonKey(name: 'UserCouponInfo')
  UserCouponInfo userCouponInfo;

  @JsonKey(name: 'Announcement')
  List<dynamic> announcement;

  @JsonKey(name: 'RecommendProductBgUrl')
  String recommendProductBgUrl;

  @JsonKey(name: 'AdIndexList')
  List<dynamic> adIndexList;

  @JsonKey(name: 'ActivityAdList2')
  List<ActivityAdList2> activityAdList2;

  @JsonKey(name: 'FeaturedShop')
  List<FeaturedShop> featuredShop;

  @JsonKey(name: 'ActivityAdList1')
  List<ActivityAdList1> activityAdList1;

  IndexModel(this.adRotationList,this.categoryList,this.userCouponInfo,this.announcement,this.recommendProductBgUrl,this.adIndexList,this.activityAdList2,this.featuredShop,this.activityAdList1,);

  factory IndexModel.fromJson(Map<String, dynamic> srcJson) => _$IndexModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IndexModelToJson(this);

}

  
@JsonSerializable()
  class AdRotationList extends Object {

  @JsonKey(name: 'AdAreaTBID')
  String adAreaTBID;

  @JsonKey(name: 'Time')
  String time;

  @JsonKey(name: 'ImageUrl')
  String imageUrl;

  @JsonKey(name: 'linkUrl')
  String linkUrl;

  @JsonKey(name: 'linkType')
  String linkType;

  @JsonKey(name: 'linkTypeName')
  String linkTypeName;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Subtitle')
  String subtitle;

  @JsonKey(name: 'Alt')
  String alt;

  AdRotationList(this.adAreaTBID,this.time,this.imageUrl,this.linkUrl,this.linkType,this.linkTypeName,this.title,this.subtitle,this.alt,);

  factory AdRotationList.fromJson(Map<String, dynamic> srcJson) => _$AdRotationListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AdRotationListToJson(this);

}

  
@JsonSerializable()
  class CategoryList extends Object {

  @JsonKey(name: 'AdAreaTBID')
  String adAreaTBID;

  @JsonKey(name: 'Time')
  String time;

  @JsonKey(name: 'ImageUrl')
  String imageUrl;

  @JsonKey(name: 'linkUrl')
  String linkUrl;

  @JsonKey(name: 'linkType')
  String linkType;

  @JsonKey(name: 'linkTypeName')
  String linkTypeName;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Subtitle')
  String subtitle;

  @JsonKey(name: 'Alt')
  String alt;

  CategoryList(this.adAreaTBID,this.time,this.imageUrl,this.linkUrl,this.linkType,this.linkTypeName,this.title,this.subtitle,this.alt,);

  factory CategoryList.fromJson(Map<String, dynamic> srcJson) => _$CategoryListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryListToJson(this);

}

  
@JsonSerializable()
  class UserCouponInfo extends Object {

  @JsonKey(name: 'CouponCount')
  String couponCount;

  @JsonKey(name: 'UserCouponList')
  List<dynamic> userCouponList;

  @JsonKey(name: 'SourceTypeName')
  String sourceTypeName;

  UserCouponInfo(this.couponCount,this.userCouponList,this.sourceTypeName,);

  factory UserCouponInfo.fromJson(Map<String, dynamic> srcJson) => _$UserCouponInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserCouponInfoToJson(this);

}

  
@JsonSerializable()
  class ActivityAdList2 extends Object {

  @JsonKey(name: 'AdAreaTBID')
  String adAreaTBID;

  @JsonKey(name: 'Time')
  String time;

  @JsonKey(name: 'ImageUrl')
  String imageUrl;

  @JsonKey(name: 'linkUrl')
  String linkUrl;

  @JsonKey(name: 'linkType')
  String linkType;

  @JsonKey(name: 'linkTypeName')
  String linkTypeName;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Subtitle')
  String subtitle;

  @JsonKey(name: 'Alt')
  String alt;

  ActivityAdList2(this.adAreaTBID,this.time,this.imageUrl,this.linkUrl,this.linkType,this.linkTypeName,this.title,this.subtitle,this.alt,);

  factory ActivityAdList2.fromJson(Map<String, dynamic> srcJson) => _$ActivityAdList2FromJson(srcJson);

  Map<String, dynamic> toJson() => _$ActivityAdList2ToJson(this);

}

  
@JsonSerializable()
  class FeaturedShop extends Object {

  @JsonKey(name: 'AdAreaTBID')
  String adAreaTBID;

  @JsonKey(name: 'Time')
  String time;

  @JsonKey(name: 'ImageUrl')
  String imageUrl;

  @JsonKey(name: 'linkUrl')
  String linkUrl;

  @JsonKey(name: 'linkType')
  String linkType;

  @JsonKey(name: 'linkTypeName')
  String linkTypeName;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Subtitle')
  String subtitle;

  @JsonKey(name: 'Alt')
  String alt;

  FeaturedShop(this.adAreaTBID,this.time,this.imageUrl,this.linkUrl,this.linkType,this.linkTypeName,this.title,this.subtitle,this.alt,);

  factory FeaturedShop.fromJson(Map<String, dynamic> srcJson) => _$FeaturedShopFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeaturedShopToJson(this);

}

  
@JsonSerializable()
  class ActivityAdList1 extends Object {

  @JsonKey(name: 'AdAreaTBID')
  String adAreaTBID;

  @JsonKey(name: 'Time')
  String time;

  @JsonKey(name: 'ImageUrl')
  String imageUrl;

  @JsonKey(name: 'linkUrl')
  String linkUrl;

  @JsonKey(name: 'linkType')
  String linkType;

  @JsonKey(name: 'linkTypeName')
  String linkTypeName;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Subtitle')
  String subtitle;

  @JsonKey(name: 'Alt')
  String alt;

  ActivityAdList1(this.adAreaTBID,this.time,this.imageUrl,this.linkUrl,this.linkType,this.linkTypeName,this.title,this.subtitle,this.alt,);

  factory ActivityAdList1.fromJson(Map<String, dynamic> srcJson) => _$ActivityAdList1FromJson(srcJson);

  Map<String, dynamic> toJson() => _$ActivityAdList1ToJson(this);

}

  
