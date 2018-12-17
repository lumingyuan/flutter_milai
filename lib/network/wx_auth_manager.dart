import 'package:flutter_wechat/flutter_wechat.dart';
import 'package:flutter_milai/global.dart';
import 'package:dio/dio.dart';

class WXAuthManager {

  static final String wxAppId = 'wx71bf4de81800da53';
  static final String wxAppSecret = 'c2dbba0699f03ca7e8d9675fab02a593';

  static WXAuthManager _instance;
  static WXAuthManager shareInstance() {
    if (_instance == null) {
      _instance = new WXAuthManager();
    }
    return _instance;
  }

  //注册微信appid
  Future<dynamic> register() async {
    return await FlutterWechat.registerWechat(WXAuthManager.wxAppId);
  }

  //微信登录
  Future<dynamic> login() async {
    var retCode = await FlutterWechat.login();
    int code = int.tryParse(retCode) ?? 0;
    if (code == 0) {
      //验证成功
      Map retAuth = await _getAuthAccessToken(retCode);
      if (retAuth.containsKey('errcode')) {
        lLog('wx_login_error_' + retAuth['errmsg']);
      } else {
        //获取成功
        var userInfo = await _getUserInfo(retAuth['access_token'], retAuth['openid']);
        return userInfo;
      }
      lLog(retAuth.toString());
      return null;
    } else {
      return null; 
    }
  }

  // 获取access_token
  Future<dynamic> _getAuthAccessToken(String code) async {
    Dio dio = new Dio();
    Response<String> response = await dio.get("https://api.weixin.qq.com/sns/oauth2/access_token?appid=${WXAuthManager.wxAppId}&secret=${WXAuthManager.wxAppSecret}&code=$code&grant_type=authorization_code");
    return json.decode(response.data);
  }

  Future<dynamic> _getUserInfo(String accessToken, String uuid) async {
    if (isEmpty(accessToken) || isEmpty(uuid)) {
      return null;
    }
    Dio dio  = new Dio();
    Response<String> response = await dio.get("https://api.weixin.qq.com/sns/userinfo?access_token=$accessToken&openid=$uuid");
    return json.decode(response.data);
  }
}