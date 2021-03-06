import '../global.dart';
import 'package:flutter/services.dart';
import 'response_model.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

export './response_model.dart';

class HttpService {
  static const platform = const MethodChannel('com.milai.flutter/http');
  static const String kHMACKey =
      "574584H38Msx80980026QKzbX588Zv0xh95ph8ZG67dj7x69k5091xvm0013";

  static HttpService _instance;
  static HttpService shareInstance() {
    if (_instance == null) {
      _instance = new HttpService();
    }
    return _instance;
  }

  Dio _dio;

  HttpService() {
    Options op = Options(
      baseUrl: Global.appDomain,
      connectTimeout: 30 * 1000,
      receiveTimeout: 10 * 1000,
      headers: {"Content-Type": "application/json"},
    );
    _dio = new Dio(op);
  }

  // 封装成接口需要的数据
  Future<Map> _packParams(Map params) async {
    if (params == null) {
      params = new Map();
    }
    String date = DateUtil.getDateStrByDateTime(DateTime.now(),
        dateSeparate: '', timeSeparate: '', format: DateFormat.NORMAL);
    date = date.replaceAll(' ', '');

    params['DeviceToken'] = "";
    params['Times'] = date;

    String encryptStr = json.encode(params);

    var hmacSha256 = new Hmac(md5, utf8.encode(kHMACKey));
    params['Mac'] = hmacSha256.convert(utf8.encode(encryptStr)).toString();
    params['Version'] = "";
    params['ActionType'] = "1001";
    params['Data'] =
        await NativeUtils.encryptAES(encryptStr, kHMACKey.substring(0, 16));
    params['UserID'] = UserManager.shareInstance().isLogin
        ? UserManager.shareInstance().userModel.iD
        : "0";

    return {"JsonString": params};
  }

  Future<ResponseModel> doPost(String subUrl,
      {Map<String, String> params, bool encrypt = true}) async {
    String url = Global.appDomain + '/' + subUrl;
    Map postParams = params;
    if (encrypt) {
      postParams = await _packParams(params);
    }

    print('[POST]$url\n$params');
    Response<dynamic> response = await _dio.post(url, data: postParams);

    if (response.statusCode == 200) {
      ResponseModel ret = ResponseModel.fromJson(response.data);
      if (ret.encrypt) {
        ret.result =
            await NativeUtils.decryptAES(ret.result, kHMACKey.substring(0, 16));
      }
      return ret;
    } else {
      return ResponseModel(-1, '服务器被火星劫持了～', false, null);
    }
  }

  // void post(String subUrl,
  //     {Map<String, String> params,
  //     Function successBlock,
  //     Function errorBlock}) async {
  //   print('[POST]url:$subUrl');

  //   String url = Global.appDomain + '/' + subUrl;
  //   try {
  //     if (params == null) {
  //       params = new Map();
  //     }
  //     final String data =
  //         await platform.invokeMethod('POST', {"url": url, "params": params});

  //     ResponseModel response = ResponseModel.fromJson(json.decode(data));
  //     if (response.code == 0) {
  //       if (successBlock != null) {
  //         successBlock(response);
  //       }
  //     } else {
  //       if (errorBlock != null) {
  //         errorBlock(response);
  //       }
  //     }
  //   } on PlatformException catch (e) {
  //     print("post error:" + e.message);
  //     if (errorBlock != null) {
  //       errorBlock(ResponseModel(-1000, e.message, null));
  //     }
  //   }
  // }
}
