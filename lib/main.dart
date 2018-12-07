import 'package:flutter/material.dart';
import 'package:flutter_milai/controllers/mainpage/mainpage_vc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '米来街',
      home: new MainPage(),
    );
  }
}
