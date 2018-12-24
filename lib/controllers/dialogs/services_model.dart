import 'package:json_annotation/json_annotation.dart'; 
  
part 'services_model.g.dart';


@JsonSerializable()
  class ServicesModel extends Object {

  @JsonKey(name: 'CustomServiceList')
  List<CustomServiceList> customServiceList;

  @JsonKey(name: 'SystemSetting')
  SystemSetting systemSetting;

  ServicesModel(this.customServiceList,this.systemSetting,);

  factory ServicesModel.fromJson(Map<String, dynamic> srcJson) => _$ServicesModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ServicesModelToJson(this);

}

  
@JsonSerializable()
  class CustomServiceList extends Object {

  @JsonKey(name: 'QQ')
  String qQ;

  @JsonKey(name: 'Tel')
  String tel;

  @JsonKey(name: 'DisplayName')
  String displayName;

  CustomServiceList(this.qQ,this.tel,this.displayName,);

  factory CustomServiceList.fromJson(Map<String, dynamic> srcJson) => _$CustomServiceListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CustomServiceListToJson(this);

}

  
@JsonSerializable()
  class SystemSetting extends Object {

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Value')
  String value;

  @JsonKey(name: 'Description')
  String description;

  SystemSetting(this.title,this.value,this.description,);

  factory SystemSetting.fromJson(Map<String, dynamic> srcJson) => _$SystemSettingFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SystemSettingToJson(this);

}

  
