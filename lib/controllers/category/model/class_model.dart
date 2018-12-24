import 'package:json_annotation/json_annotation.dart'; 
  
part 'class_model.g.dart';


List<ClassModel> getClassModelList(List<dynamic> list){
    List<ClassModel> result = [];
    list.forEach((item){
      result.add(ClassModel.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class ClassModel extends Object {

  @JsonKey(name: 'ID')
  String iD;

  @JsonKey(name: 'ClassCode')
  String classCode;

  @JsonKey(name: 'Subtitle')
  String subtitle;

  @JsonKey(name: 'ClassName')
  String className;

  @JsonKey(name: 'IconUrl')
  String iconUrl;

  @JsonKey(name: 'DepthLevel')
  String depthLevel;

  @JsonKey(name: 'FatherID')
  String fatherID;

  @JsonKey(name: 'CategoryList')
  List<dynamic> categoryList;

  ClassModel(this.iD,this.classCode,this.subtitle,this.className,this.iconUrl,this.depthLevel,this.fatherID,this.categoryList,);

  factory ClassModel.fromJson(Map<String, dynamic> srcJson) => _$ClassModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ClassModelToJson(this);

}

  
