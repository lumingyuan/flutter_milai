import 'package:flutter/material.dart';

import 'package:flutter_milai/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';

class LoginVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginVCState();
  }
}

class _LoginVCState extends State<LoginVC> {
  _onClosePress() {
    Navigator.pop(context);
  }

  Widget _buildBody() {
    return new Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 50),
              child: new Image.asset('images/logo.png'),
            ),
            new Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.person_outline,
                  size: 20,
                  color: Color(0xff999999),
                ),
                new Expanded(
                  child: new TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 20, right: 20, bottom: 0),
                      border: InputBorder.none,
                      hintText: '请输入手机号',
                      hintStyle:
                          TextStyle(color: Color(0xff999999), fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
            new Container(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Divider(
                height: 1,
              ),
            ),
            new Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: Color(0xff999999),
                ),
                new Expanded(
                  child: new TextField(
                    obscureText: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 20, right: 20, bottom: 0),
                      border: InputBorder.none,
                      hintText: '密码',
                      hintStyle:
                          TextStyle(color: Color(0xff999999), fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
            new Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(
                height: 1,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Color(0xfff0f0f0),
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            new IconButton(
              icon: new Image.asset('images/login_close_ico.png'),
              onPressed: _onClosePress,
            ),
          ],
        ),
        body: new Stack(
          children: <Widget>[
            new Align(
              alignment: Alignment.topCenter,
              child: _buildBody(),
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 20),
                child: new FlatButton(
                  onPressed: _onClosePress,
                  child: Text('先不登录 逛一逛 >>',
                      style: TextStyle(fontSize: 13, color: Color(0xff999999))),
                ),
              ),
            )
          ],
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
