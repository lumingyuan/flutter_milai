import 'package:flutter/material.dart';

class CategrayVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CategrayVCState();
  }
}

class _CategrayVCState extends State<CategrayVC> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      child: new GridView.count(
      crossAxisCount: 1,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        new Text('112213123'),
        new Text('afsdfasd'),
        new Text('gdghsdgs'),
        new Text('fsgdfsgfs'),
        new Text('fghjdfgh'),
        new Text('5sdfsdf'),
      ],
    ),
    );
  }
}