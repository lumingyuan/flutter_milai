import 'package:json_annotation/json_annotation.dart'; 
  
part 'find_selected_model.g.dart';


List<FindSelectedModel> getFindSelectedModelList(List<dynamic> list){
    List<FindSelectedModel> result = [];
    list.forEach((item){
      result.add(FindSelectedModel.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class FindSelectedModel extends Object {

  @JsonKey(name: 'CardType')
  String cardType;

  @JsonKey(name: 'UserHeadImgUrl')
  String userHeadImgUrl;

  @JsonKey(name: 'CardImgList')
  List<String> cardImgList;

  @JsonKey(name: 'FindSelectedTBID')
  String findSelectedTBID;

  @JsonKey(name: 'FabulousNum')
  String fabulousNum;

  @JsonKey(name: 'IsUserFabulous')
  String isUserFabulous;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Subtitle')
  String subtitle;

  @JsonKey(name: 'BrowseNum')
  String browseNum;

  @JsonKey(name: 'Describe')
  String describe;

  FindSelectedModel(this.cardType,this.userHeadImgUrl,this.cardImgList,this.findSelectedTBID,this.fabulousNum,this.isUserFabulous,this.title,this.subtitle,this.browseNum,this.describe,);

  factory FindSelectedModel.fromJson(Map<String, dynamic> srcJson) => _$FindSelectedModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FindSelectedModelToJson(this);

}

  
