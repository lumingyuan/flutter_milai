import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';
import '../model/find_trace_model.dart';

class SearchTrace extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SearchTraceState();
  }
}

class _SearchTraceState extends State<SearchTrace>
    with AutomaticKeepAliveClientMixin {
  int _currentPage = 1;
  bool _isRequesting = false;
  List<FindTraceModel> _traceModels = new List();
  RefreshController _refreshController = new RefreshController();

  @override
  void initState() {
    super.initState();

    print('initState');

    _requestTrace(_currentPage);
  }

  @override
  bool get wantKeepAlive => true;

  _requestTrace(int page) async {
    if (_isRequesting) {
      return;
    }
    _isRequesting = true;

    ResponseModel model = await HttpService.shareInstance().doPost(
        'MiLaiApi/GetPageListUserRebateLog',
        params: {"PageIndex": page.toString(), "PageSize": "20"});
    _isRequesting = false;

    int status = RefreshStatus.idle;
    if (model.isSuccess) {
      _currentPage = page;
      List<dynamic> list = model.result['Entity'];
      if (list != null && list.length > 0) {
        if (page == 1) {
          _traceModels.clear();
        }
        setState(() {
          _traceModels.addAll(getFindTraceModelList(list));
        });

        status = RefreshStatus.idle;
      } else {
        status = RefreshStatus.noMore;
      }
    } else {
      status = RefreshStatus.failed;
    }
    if (page > 1) {
      _refreshController.sendBack(false, status);
    }
  }

  Widget _buildBody() {
    if (_traceModels == null || _traceModels.length == 0) {
      return new Container();
    }
    String curTag = "";
    return Container(
        color: Color(0xfff0f0f0),
        margin: EdgeInsets.only(top: 15),
        child: new SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: (bool up) {
              if (!up) {
                //加载更多
                _requestTrace(_currentPage + 1);
              } else {
                _requestTrace(1);
              }
            },
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                FindTraceModel model = _traceModels.elementAt(index);
                List<Widget> colChildren = new List();
                if (model.browseTime != curTag) {
                  curTag = model.browseTime;
                  colChildren.add(new Container(
                    height: 30,
                    padding: EdgeInsets.only(
                      left: 35,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${model.browseTime}',
                      style: TextStyle(color: Color(0xff696969), fontSize: 12),
                    ),
                  ));
                }
                colChildren.add(new Container(
                  height: 90,
                  margin:
                      EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                  padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      AspectRatio(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: model.imageUrl,
                            )),
                        aspectRatio: 1,
                      ),
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '${model.name}',
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 13),
                              ),
                            ),
                            Text(
                              '¥${model.price}',
                              style: TextStyle(
                                  color: Global.kTintColor, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: colChildren,
                );
              },
              itemCount: _traceModels.length,
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (UserManager.shareInstance().isLogin) {
      return new Scaffold(
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          child: Image.asset('images/trace_edit_ico.png'),
        ),
      );
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
}
