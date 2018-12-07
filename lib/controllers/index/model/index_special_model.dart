import 'package:json_annotation/json_annotation.dart'; 
  
part 'index_special_model.g.dart';


List<IndexSpecialModel> getIndexSpecialModelList(List<dynamic> list){
    List<IndexSpecialModel> result = [];
    list.forEach((item){
      result.add(IndexSpecialModel.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class IndexSpecialModel extends Object {

  @JsonKey(name: 'AdExpandTBID')
  String adExpandTBID;

  @JsonKey(name: 'ImageUrl')
  String imageUrl;

  @JsonKey(name: 'AdTBID')
  String adTBID;

  @JsonKey(name: 'SpecialCategoryList')
  List<SpecialCategoryList> specialCategoryList;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'SpecialProductList')
  List<SpecialProductList> specialProductList;

  IndexSpecialModel(this.adExpandTBID,this.imageUrl,this.adTBID,this.specialCategoryList,this.title,this.specialProductList,);

  factory IndexSpecialModel.fromJson(Map<String, dynamic> srcJson) => _$IndexSpecialModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IndexSpecialModelToJson(this);

}

  
@JsonSerializable()
  class SpecialCategoryList extends Object {

  @JsonKey(name: 'AdExpandCategoryTBID')
  String adExpandCategoryTBID;

  @JsonKey(name: 'ClassName')
  String className;

  SpecialCategoryList(this.adExpandCategoryTBID,this.className,);

  factory SpecialCategoryList.fromJson(Map<String, dynamic> srcJson) => _$SpecialCategoryListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SpecialCategoryListToJson(this);

}

  
@JsonSerializable()
  class SpecialProductList extends Object {

  @JsonKey(name: 'ImageUrl')
  String imageUrl;

  @JsonKey(name: 'StoreTBID')
  String storeTBID;

  @JsonKey(name: 'ActivityInfo')
  List<dynamic> activityInfo;

  @JsonKey(name: 'ProductTBID')
  String productTBID;

  @JsonKey(name: 'MerchantTBID')
  String merchantTBID;

  @JsonKey(name: 'Sales')
  String sales;

  @JsonKey(name: 'ProductName')
  String productName;

  @JsonKey(name: 'IsFreePostage')
  String isFreePostage;

  @JsonKey(name: 'Price')
  String price;

  @JsonKey(name: 'IsShowSales')
  String isShowSales;

  @JsonKey(name: 'Unit')
  String unit;

  SpecialProductList(this.imageUrl,this.storeTBID,this.activityInfo,this.productTBID,this.merchantTBID,this.sales,this.productName,this.isFreePostage,this.price,this.isShowSales,this.unit,);

  factory SpecialProductList.fromJson(Map<String, dynamic> srcJson) => _$SpecialProductListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SpecialProductListToJson(this);

}

  
