import 'package:flutter/material.dart';

class TestVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TestVCState();
  }
}

class TestVCState extends State<TestVC> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          new Text('1'),
          new Text('2'),
        ],
      ),
    );
  }
}