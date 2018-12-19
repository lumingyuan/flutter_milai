import 'package:json_annotation/json_annotation.dart'; 
  
part 'find_rank_model.g.dart';


List<FindRankModel> getFindRankModelList(List<dynamic> list){
    List<FindRankModel> result = [];
    list.forEach((item){
      result.add(FindRankModel.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class FindRankModel extends Object {

  @JsonKey(name: 'FindLeaderboardTBID')
  String findLeaderboardTBID;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Subtitle')
  String subtitle;

  @JsonKey(name: 'FindLeaderboardProduct')
  List<FindLeaderboardProduct> findLeaderboardProduct;

  FindRankModel(this.findLeaderboardTBID,this.title,this.subtitle,this.findLeaderboardProduct,);

  factory FindRankModel.fromJson(Map<String, dynamic> srcJson) => _$FindRankModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FindRankModelToJson(this);

}

  
@JsonSerializable()
  class FindLeaderboardProduct extends Object {

  @JsonKey(name: 'RankingType')
  String rankingType;

  @JsonKey(name: 'ProductTBID')
  String productTBID;

  @JsonKey(name: 'Name')
  String name;

  @JsonKey(name: 'ImageUrl')
  String imageUrl;

  @JsonKey(name: 'Price')
  String price;

  @JsonKey(name: 'Value')
  String value;

  FindLeaderboardProduct(this.rankingType,this.productTBID,this.name,this.imageUrl,this.price,this.value,);

  factory FindLeaderboardProduct.fromJson(Map<String, dynamic> srcJson) => _$FindLeaderboardProductFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FindLeaderboardProductToJson(this);

}

  
