import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';
import 'package:flutter_milai/controllers/categray/categray_vc.dart';
import 'package:flutter_milai/controllers/index/index_vc.dart';
import 'search/search_vc.dart';
import 'package:flutter_milai/network/wx_auth_manager.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    //微信注册
    WXAuthManager.shareInstance().register();
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      iconSize: 24,
      items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text("首页", style: new TextStyle(fontSize: 10)),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.category),
          title: new Text("分类", style: new TextStyle(fontSize: 10)),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: new Text('发现', style: new TextStyle(fontSize: 10)),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.shopping_cart),
          title: new Text('购物车', style: new TextStyle(fontSize: 10)),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.person),
          title: new Text('我的', style: new TextStyle(fontSize: 10)),
        )
      ],
      currentIndex: _currentIndex,
      fixedColor: Colors.red,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
    return new MaterialApp(
      home: new Scaffold(
        body: new SafeArea(
          top: false,
          child: new IndexedStack(
            children: <Widget>[
              new IndexVC(),
              new CategrayVC(),
              new SearchVC(),
              new CategrayVC(),
              new CategrayVC(),
            ],
            index: _currentIndex,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomPadding: false,
      ),
      theme: Global.themeData,
    );
  }
}