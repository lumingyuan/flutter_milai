import 'package:json_annotation/json_annotation.dart'; 
  
part 'response_model.g.dart';


@JsonSerializable()
  class ResponseModel extends Object {

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'result')
  dynamic result;

  ResponseModel(this.code,this.message,this.result,);

  bool get isSuccess => this.code==0 ;

  factory ResponseModel.fromJson(Map<String, dynamic> srcJson) => _$ResponseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

}