import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';
import 'package:flutter_milai/controllers/categray/categray_vc.dart';
import 'package:flutter_milai/controllers/index/index_vc.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text("首页"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.category),
          title: new Text("分类"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: new Text('发现'),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.shopping_cart),
          title: new Text('购物车'),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.person),
          title: new Text('我的'),
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
              new CategrayVC(),
              new CategrayVC(),
              new CategrayVC(),
            ],
            index: _currentIndex,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
      theme: Global.themeData,
    );
  }
}