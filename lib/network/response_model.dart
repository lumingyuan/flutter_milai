import 'package:json_annotation/json_annotation.dart'; 
  
part 'response_model.g.dart';


@JsonSerializable()
  class ResponseModel extends Object {

  @JsonKey(name: 'Code')
  int code;

  @JsonKey(name: 'Message')
  String message;

  @JsonKey(name: 'Encrypt')
  bool encrypt;

  @JsonKey(name: 'Result')
  dynamic result;

  bool get isSuccess => this.code==0 ;
  
  ResponseModel(this.code,this.message,this.encrypt,this.result,);

  factory ResponseModel.fromJson(Map<String, dynamic> srcJson) => _$ResponseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

}