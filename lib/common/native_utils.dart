import 'package:flutter/services.dart';

class NativeUtils {
  static const platform = const MethodChannel('com.milai.flutter/utils');


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

 static Future<Null> test() async {
    try {
      await platform
          .invokeMethod('test');
    } on PlatformException catch (e) {
      print("native_utils error:" + e.message);
    }
  }

  

}
