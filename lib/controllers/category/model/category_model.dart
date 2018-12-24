import 'package:json_annotation/json_annotation.dart'; 
  
part 'category_model.g.dart';


@JsonSerializable()
  class CategoryModel extends Object {

  @JsonKey(name: 'Category23')
  List<Category23> category23;

  @JsonKey(name: 'CategoryAdTop')
  CategoryAdTop categoryAdTop;

  @JsonKey(name: 'CategoryAdBottom')
  CategoryAdBottom categoryAdBottom;

  CategoryModel(this.category23,this.categoryAdTop,this.categoryAdBottom,);

  factory CategoryModel.fromJson(Map<String, dynamic> srcJson) => _$CategoryModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

}

  
@JsonSerializable()
  class Category23 extends Object {

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
  List<CategoryList> categoryList;

  Category23(this.iD,this.classCode,this.subtitle,this.className,this.iconUrl,this.depthLevel,this.fatherID,this.categoryList,);

  factory Category23.fromJson(Map<String, dynamic> srcJson) => _$Category23FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Category23ToJson(this);

}

  
@JsonSerializable()
  class CategoryList extends Object {

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

  CategoryList(this.iD,this.classCode,this.subtitle,this.className,this.iconUrl,this.depthLevel,this.fatherID,this.categoryList,);

  factory CategoryList.fromJson(Map<String, dynamic> srcJson) => _$CategoryListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryListToJson(this);

}

  
@JsonSerializable()
  class CategoryAdTop extends Object {

  @JsonKey(name: 'ImgUrl')
  String imgUrl;

  @JsonKey(name: 'LinkType')
  String linkType;

  @JsonKey(name: 'LinkUrl')
  String linkUrl;

  CategoryAdTop(this.imgUrl,this.linkType,this.linkUrl,);

  factory CategoryAdTop.fromJson(Map<String, dynamic> srcJson) => _$CategoryAdTopFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryAdTopToJson(this);

}

  
@JsonSerializable()
  class CategoryAdBottom extends Object {

  @JsonKey(name: 'ImgUrl')
  String imgUrl;

  @JsonKey(name: 'LinkType')
  String linkType;

  @JsonKey(name: 'LinkUrl')
  String linkUrl;

  CategoryAdBottom(this.imgUrl,this.linkType,this.linkUrl,);

  factory CategoryAdBottom.fromJson(Map<String, dynamic> srcJson) => _$CategoryAdBottomFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryAdBottomToJson(this);

}

  
