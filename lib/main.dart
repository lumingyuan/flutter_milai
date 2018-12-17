import 'package:flutter/material.dart';
import 'package:flutter_milai/controllers/mainpage_vc.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  _test()  async {
    String keyStr = '574584H38Msx80980026QKzbX588Zv0xh95ph8ZG67dj7x69k5091xvm0013';
      var key = utf8.encode(keyStr);
      var src = utf8.encode('hello,milai');
      var hmacSha256= new Hmac(md5, key);
      var result = hmacSha256.convert(src);

    print(result.toString());

  //  final tmpKey = keyStr.substring(0, 16);
  //   final cryptor = new Encrypter(new AES(tmpKey));
  //   final String encrypt = cryptor.encrypt('hello,milaihello,milaihello,milaihello,milaihello,milai    ');
  //   final String decrypt = cryptor.decrypt(encrypt);
  // // final iv = '8bytesiv';
  // // final tmpKey = keyStr.substring(0, 16);
  // // final encryptor = Encrypter(Salsa20(tmpKey, iv));
  // // String text = 'hello,milai';
  // // String base64Text = base64.encode(utf8.encode(text));
  // // String encrypt  = encryptor.encrypt(base64Text);
  // // var decrypt = utf8.decode(base64.decode(encryptor.decrypt(encrypt)));
  //   print('encrypt ' + encrypt);
  //   print('decrypt ' + decrypt);
  }

  @override
  Widget build(BuildContext context) {

    _test();



    return new MainPage();
  }
}
