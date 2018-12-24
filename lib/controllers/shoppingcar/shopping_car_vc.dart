import 'package:flutter/material.dart';

class ShoppingCardVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ShoppingCardVCState();
  }
}

class _ShoppingCardVCState extends State<ShoppingCardVC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('购物车'),),
    );
  }
}