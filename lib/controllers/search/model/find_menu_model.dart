import 'package:json_annotation/json_annotation.dart'; 
  
part 'find_menu_model.g.dart';


List<FindMenuModel> getFindMenuModelList(List<dynamic> list){
    List<FindMenuModel> result = [];
    list.forEach((item){
      result.add(FindMenuModel.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class FindMenuModel extends Object {

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'BackGroundImgUrl')
  String backGroundImgUrl;

  @JsonKey(name: 'FindMenuID')
  String findMenuID;

  FindMenuModel(this.title,this.backGroundImgUrl,this.findMenuID,);

  factory FindMenuModel.fromJson(Map<String, dynamic> srcJson) => _$FindMenuModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FindMenuModelToJson(this);

}

  
