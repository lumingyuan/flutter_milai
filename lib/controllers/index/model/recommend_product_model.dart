import 'package:json_annotation/json_annotation.dart'; 
  
part 'recommend_product_model.g.dart';


List<RecommendProductModel> getRecommendProductModelList(List<dynamic> list){
    List<RecommendProductModel> result = [];
    list.forEach((item){
      result.add(RecommendProductModel.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class RecommendProductModel extends Object {

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

  RecommendProductModel(this.imageUrl,this.storeTBID,this.activityInfo,this.productTBID,this.merchantTBID,this.sales,this.productName,this.isFreePostage,this.price,this.isShowSales,this.unit,);

  factory RecommendProductModel.fromJson(Map<String, dynamic> srcJson) => _$RecommendProductModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendProductModelToJson(this);

}

  
