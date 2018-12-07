import 'package:flutter/material.dart';
import 'package:flutter_milai/network/http_service.dart';
import 'package:flutter_milai/network/response_model.dart';

import './model/index_model.dart';
import './model/index_special_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './views/index_specail_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

class IndexVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _IndexVCState();
  }
}

class _IndexVCState extends State<IndexVC> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  IndexModel _indexModel; //首页数据
  List<IndexSpecialModel> _specialModels;

  @override
  void initState() {
    super.initState();

    if (_indexModel == null) {
      _refreshIndex();
    }
  }

  Future<Null> _refreshIndex() {
    final Completer<Null> completer = new Completer<Null>();
    HttpService.shareInstance().post('MiLaiApi/GetModelIndex',
        params: {"TerminalType": "1001"}, successBlock: (ResponseModel model) {
        _indexModel = IndexModel.fromJson(model.result);
        if (!mounted) return;
        setState(() { });
      completer.complete(null);
    }, errorBlock: (ResponseModel model) {
      print('error:' + model.message);
      completer.complete(null);
    });

    _refreshTheme();
    return completer.future;
  }

  _refreshTheme() {
    HttpService.shareInstance()
        .post("MiLaiApi/GetListIndexSpecial", params: {"MerchantID": "0", "PageSize": "6"},
            successBlock: (ResponseModel model) {
      setState(() {
        _specialModels = getIndexSpecialModelList(model.result);
      });
    });
  }

  //创建广告轮播图
  Widget _createADSwiper() {
    if (_indexModel == null ||
        _indexModel.adRotationList == null ||
        _indexModel.adRotationList.length == 0) {
      return null;
    }
    return new Swiper(
      itemBuilder: (_, index) => new CachedNetworkImage(
            imageUrl: _indexModel.adRotationList[index].imageUrl,
            fit: BoxFit.cover,
          ),
      itemCount: _indexModel.adRotationList.length,
      pagination: new SwiperPagination(
        builder: DotSwiperPaginationBuilder(
            color: Colors.white, activeColor: Colors.red),
      ),
      scrollDirection: Axis.horizontal,
      autoplay: true,
      onTap: (index) => Navigator.of(context).pushNamed('/test').then((value) {
            print(value);
          }),
    );
  }

  //创建分类视图列表
  List<Widget> _createCategoryChildren() {
    List<Widget> children = new List();
    if (_indexModel != null &&
        _indexModel.categoryList != null &&
        _indexModel.categoryList.length > 0) {
      for (int i = 0; i < _indexModel.categoryList.length; ++i) {
        CategoryList model = _indexModel.categoryList[i];
        children.add(new CachedNetworkImage(
          imageUrl: model.imageUrl,
        ));
      }
    }
    return children;
  }

  //创建广告轮播图
  Widget _createAdCoverFlowSwiper() {
    if (_indexModel.activityAdList2.length == 0) {
      return null;
    }
    return new Column(
      children: <Widget>[
        new CachedNetworkImage(
          imageUrl: _indexModel.activityAdList2[0].imageUrl,
        ),
        new AspectRatio(
          aspectRatio: 375 / 146,
          child: new Swiper(
            itemCount: _indexModel.activityAdList2.length - 1,
            itemBuilder: (_, index) => new Card(
                  child: new CachedNetworkImage(
                    imageUrl: _indexModel.activityAdList2[index + 1].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
            scrollDirection: Axis.horizontal,
            layout: SwiperLayout.DEFAULT,
            autoplayDelay: 3 * 1000,
            scale: 0.8,
            viewportFraction: 0.7,
          ),
        )
      ],
    );
  }

  //创建列表项
  _createItem(index) {
    if (index == 0) {
      //广告轮播
      return new Container(
        width: MediaQuery.of(context).size.width,
        child: new AspectRatio(
          aspectRatio: 375 / 176,
          child: _createADSwiper(),
        ),
      );
    } else if (index == 1) {
      //分类
      return new Container(
        color: Colors.white,
        child: new GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          children: _createCategoryChildren(),
        ),
      );
    } else if (index == 2) {
      //
      if (_indexModel != null &&
          _indexModel.activityAdList1 != null &&
          _indexModel.activityAdList1.length > 0) {
        return new Container(
          child: new Column(
            children: <Widget>[
              new CachedNetworkImage(
                imageUrl: _indexModel.activityAdList1[0].imageUrl,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new CachedNetworkImage(
                      imageUrl: _indexModel.activityAdList1[1].imageUrl,
                    ),
                    flex: 1,
                  ),
                  new Expanded(
                    child: new Column(
                      children: <Widget>[
                        new CachedNetworkImage(
                          imageUrl: _indexModel.activityAdList1[2].imageUrl,
                        ),
                        new CachedNetworkImage(
                          imageUrl: _indexModel.activityAdList1[3].imageUrl,
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        return null;
      }
    } else if (index == 3) {
      if (_indexModel != null &&
          _indexModel.activityAdList2 != null &&
          _indexModel.activityAdList2.length > 0) {
        return new Container(
          width: MediaQuery.of(context).size.width,
          child: _createAdCoverFlowSwiper(),
        );
      } else {
        return null;
      }
    } else if (index == 4) {
      return new IndexSpecailView(
        specailModels: _specialModels,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshIndex,
        child: new ListView.builder(
          itemCount: 5,
          itemBuilder: (_, int index) => _createItem(index),
        ));
  }
}
