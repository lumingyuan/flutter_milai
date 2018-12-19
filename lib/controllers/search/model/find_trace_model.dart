import 'package:json_annotation/json_annotation.dart'; 
  
part 'find_trace_model.g.dart';


List<FindTraceModel> getFindTraceModelList(List<dynamic> list){
    List<FindTraceModel> result = [];
    list.forEach((item){
      result.add(FindTraceModel.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class FindTraceModel extends Object {

  @JsonKey(name: 'UserProductLogTBID')
  String userProductLogTBID;

  @JsonKey(name: 'ProductTBID')
  String productTBID;

  @JsonKey(name: 'Name')
  String name;

  @JsonKey(name: 'ImageUrl')
  String imageUrl;

  @JsonKey(name: 'Price')
  String price;

  @JsonKey(name: 'BelongMDStoreID')
  String belongMDStoreID;

  @JsonKey(name: 'BelongMDType')
  String belongMDType;

  @JsonKey(name: 'InventorySituation')
  String inventorySituation;

  @JsonKey(name: 'BrowseTime')
  String browseTime;

  FindTraceModel(this.userProductLogTBID,this.productTBID,this.name,this.imageUrl,this.price,this.belongMDStoreID,this.belongMDType,this.inventorySituation,this.browseTime,);

  factory FindTraceModel.fromJson(Map<String, dynamic> srcJson) => _$FindTraceModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FindTraceModelToJson(this);

}

  
