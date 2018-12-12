import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';

import 'package:flutter_milai/network/http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './model/find_menu_model.dart';
import '../index/model/recommend_product_model.dart';
import '../index/views/index_product_view.dart';
import 'dart:convert';
import './model/find_selected_model.dart';
import './views/search_select_cell.dart';

class SearchVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SearchVCState();
  }
}

class _PageData {
  bool hasLoaded; //是否加载过
  int currentPage; //当前加载页
  List<dynamic> datas; //加载的数据
  RefreshController _refreshController = new RefreshController();
  _PageData({this.hasLoaded = false, this.currentPage = 0, this.datas}) {}
}

class _SearchVCState extends State<SearchVC>
    with SingleTickerProviderStateMixin {
  List<FindMenuModel> menuModels = new List();
  int _currentTab = -1;
  TabController _controller;
  List<_PageData> _pageData;

  @override
  void initState() {
    super.initState();

    //获取菜单
    _requestFindMenu();
  }

  //获取菜单
  _requestFindMenu() {
    HttpService.shareInstance().post('MiLaiApi/GetListFindMenu',
        successBlock: (ResponseModel model) {
      menuModels.clear();
      if (model.result != null) {
        if (_currentTab < 0) {
          _currentTab = 0;
        }
        menuModels.addAll(getFindMenuModelList(model.result));
      }
      _controller = new TabController(length: menuModels.length, vsync: this);
      _pageData = new List();
      for (int i = 0; i < menuModels.length; ++i) {
        _pageData.add(new _PageData(currentPage: 1, hasLoaded: false));
      }

      _controller.addListener(_onTabChanged);
      setState(() {});

      _requestSelect(1); //首先加载精选页面
    });
  }

  //分页切换事件
  void _onTabChanged() {
    if (_currentTab == _controller.index) {
      return;
    }
    _currentTab = _controller.index;
    setState(() {}); // 刷新背景图

    _PageData page = _pageData.elementAt(_currentTab);
    if (!page.hasLoaded) {
      switch (_currentTab) {
        case 0: //精选
          _requestSelect(page.currentPage);
          break;
        case 1: //推荐
          _requestRecommend(page.currentPage);
          break;
      }
    }
  }

  //获取精选页面数据
  _requestSelect(int page) {
    _PageData data = _pageData.elementAt(0);
    HttpService.shareInstance().post('MiLaiApi/GetPageListFindSelected',
        params: {
          "MerchantID": "0",
          "PageIndex": page.toString(),
          "PageSize": "20"
        }, successBlock: (ResponseModel model) {
      data.hasLoaded = true;
      if (page == 1 && data.datas != null) {
        data.datas.clear();
      }
      data.currentPage = page;
      if (model.result['Entity'] != null) {
        if (data.datas == null) {
          data.datas = new List();
        }
        print(json.encode(model.result['Entity']));
        data.datas.addAll(getFindSelectedModelList(model.result['Entity']));
        setState(() {});
      }
      if (page != 1) {
        if (data.datas != null &&
            int.parse(model.result['Total']) <= data.datas.length) {
          data._refreshController.sendBack(false, RefreshStatus.noMore);
        } else {
          data._refreshController.sendBack(false, RefreshStatus.idle);
        }
      }
    }, errorBlock: (ResponseModel model) {});
  }

  //获取推荐数据
  _requestRecommend(int page) {
    _PageData data = _pageData.elementAt(1);
    HttpService.shareInstance()
        .post('MiLaiApi/GetPageListRecommendRuleProduct', params: {
      "DisplayPositionType": "1003",
      "MerchantID": "0",
      "PageIndex": page.toString(),
      "PageSize": "3"
    }, successBlock: (ResponseModel model) {
      data.hasLoaded = true;
      if (page == 1 && data.datas != null) {
        data.datas.clear();
      }
      data.currentPage = page;
      if (model.result['Entity'] != null) {
        if (data.datas == null) {
          data.datas = new List();
        }
        data.datas.addAll(getRecommendProductModelList(model.result['Entity']));
        setState(() {});
      }
      if (page != 1) {
        if (data.datas != null &&
            int.parse(model.result['Total']) <= data.datas.length) {
          data._refreshController.sendBack(false, RefreshStatus.noMore);
        } else {
          data._refreshController.sendBack(false, RefreshStatus.idle);
        }
      }
    }, errorBlock: (ResponseModel model) {
      data._refreshController.sendBack(false, RefreshStatus.idle);
      setState(() {});
    });
  }

  //创建精选
  Widget _createSelectedWidget() {
    _PageData pageData = _pageData.elementAt(0);
    if (pageData.datas == null || pageData.datas.length == 0) {
      return new Container();
    }

    return new SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: pageData._refreshController,
      onRefresh: (bool up) {
        if (!up) {
          //加载更多
          _requestSelect(pageData.currentPage + 1);
        }
      },
      child: new ListView.builder(
        itemCount: pageData.datas.length,
        padding: EdgeInsets.only(top: 60),
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: SearchSelectCell(pageData.datas[index]),
          );
        },
      ),
    );
  }

  //创建推荐商品
  Widget _createRecommendWidget() {
    _PageData pageData = _pageData.elementAt(1);
    if (pageData.datas == null || pageData.datas.length == 0) {
      return new Container();
    }

    return new SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: pageData._refreshController,
      onRefresh: (bool up) {
        if (!up) {
          //加载更多
          _requestRecommend(pageData.currentPage + 1);
        }
      },
      child: new ListView.builder(
        itemCount: (pageData.datas.length / 2).ceil(),
        padding: EdgeInsets.only(top: 60),
        itemBuilder: (BuildContext context, int index) {
          return new Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new IndexProductView(pageData.datas[index * 2]),
                  ),
                  new Expanded(
                    flex: 1,
                    child: index * 2 + 1 < pageData.datas.length
                        ? new IndexProductView(pageData.datas[index * 2 + 1])
                        : new Container(),
                  )
                ],
              ));
        },
      ),
    );
  }

  //创建足迹
  Widget _createTraceWidget() {
    if (UserManager.shareInstance().isLogin) {
      return new Container();
    } else {
      return new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset('images/trace_no_login.png'),
            new Container(
              height: 5,
            ),
            new Text(
              '您尚未登录,请登录',
              style: new TextStyle(color: new Color(0xffb1b1b1), fontSize: 12),
            ),
            new Container(
              height: 30,
            ),
            new Container(
              height: 30,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                borderSide: new BorderSide(color: Global.kTintColor),
                child: new Text('登录 / 注册',
                    style:
                        new TextStyle(color: Global.kTintColor, fontSize: 12)),
                onPressed: () {
                  NavigatorUtil.goLogin(context);
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _createTabViewWidget() {
    List<Widget> children = new List();
    children.add(_createSelectedWidget());
    children.add(_createRecommendWidget());
    children.add(new Container());
    children.add(_createTraceWidget());

    return new TabBarView(controller: _controller, children: children);
  }

  @override
  Widget build(BuildContext context) {
    if (menuModels == null || menuModels.length == 0 || _currentTab < 0) {
      return new Container();
    }
    return new Scaffold(
      body: new NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: new SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: Global.kScale * 118.0,
                // 这个高度必须比flexibleSpace高度大
                forceElevated: innerBoxIsScrolled,
                primary: false,
                bottom: PreferredSize(
                    child: new Container(
                      child: new TabBar(
                        controller: _controller,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3,
                        tabs: menuModels
                            .map(
                              (FindMenuModel menu) => new Container(
                                    height: 40,
                                    child: new Tab(
                                      text: menu.title,
                                    ),
                                  ),
                            )
                            .toList(),
                      ),
                    ),
                    preferredSize: new Size(double.infinity, 4)),
                flexibleSpace: new Container(
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          child: new CachedNetworkImage(
                            imageUrl: menuModels[_currentTab].backGroundImgUrl,
                            fit: BoxFit.cover,
                          ),
                          width: double.infinity,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: _createTabViewWidget(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
