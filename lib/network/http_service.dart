import '../global.dart';
import 'package:flutter/services.dart';
import 'response_model.dart';
import 'dart:convert';

export './response_model.dart';

class HttpService {
  static const platform = const MethodChannel('com.milai.flutter/http');

  static HttpService _instance;
  static HttpService shareInstance() {
    if (_instance == null) {
      _instance = new HttpService();
    }
    return _instance;
  }

  // Dio _dio;

  // HttpService() {
  //   print('httpservice init');

  //   Options op = Options(
  //     baseUrl:Global.appDomain,
  //     connectTimeout: 10*1000,
  //     receiveTimeout: 3*1000,
  //     headers: {"Content-Type":"application/json"},
  //   );
  //   _dio = new Dio(op);
  // }

  void post(String subUrl, {Map<String, String> params, Function successBlock, Function errorBlock}) async {
    print('[POST]url:$subUrl');

    String url = Global.appDomain + '/' + subUrl;
    try {
      if (params == null) {
        params = new Map();
      }
      final String data =
          await platform.invokeMethod('GET', {"url": url, "params": params});

      ResponseModel response = ResponseModel.fromJson(json.decode(data));
      if (response.code == 0) {
        if (successBlock != null) {
          successBlock(response);
        }
      } else {
        if (errorBlock != null) {
          errorBlock(response);
        }
      }
    } on PlatformException catch (e) {
      print("post error:" + e.message);
        if (errorBlock != null) {
          errorBlock(ResponseModel(-1000, e.message, null));
        }
    }
  }
}
