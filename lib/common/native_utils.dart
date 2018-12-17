import 'package:flutter/services.dart';

class NativeUtils {
  static const platform = const MethodChannel('com.milai.flutter/utils');

  /**
   * aes 字符串加密
   */
  static Future<String> encryptAES(String source, String key) async {
    String data = "";
    try {
      data = await platform
          .invokeMethod('encryptAES', {"source": source, "key": key});
    } on PlatformException catch (e) {
      print("native_utils error:" + e.message);
    }
    return data;
  }

/**
 * aes 字符串解密
 */
  static Future<String> decryptAES(String source, String key) async {
    String data = "";
    try {
      data = await platform
          .invokeMethod('decryptAES', {"source": source, "key": key});
    } on PlatformException catch (e) {
      print("native_utils error:" + e.message);
    }
    return data;
  }
}
