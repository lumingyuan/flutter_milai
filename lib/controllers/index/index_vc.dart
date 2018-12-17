import 'package:flutter/material.dart';
import 'package:flutter_milai/network/http_service.dart';
import 'package:flutter_milai/network/response_model.dart';

import './model/index_model.dart';
import './model/index_special_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './views/index_specail_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import './views/index_product_view.dart';
import './model/recommend_product_model.dart';
import './views/index_titlebar.dart';

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
  List<RecommendProductModel> _recommendProductModels = new List();

  ScrollController _scrollController = new ScrollController();
  int _curProductPage = 1;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _requestProduct(++_curProductPage);
      }
    });

    if (_indexModel == null) {
      _requestIndex();
    }
  }

  Future<Null> _requestIndex() async {
    final Completer<Null> completer = new Completer<Null>();

    ResponseModel model = await HttpService.shareInstance()
        .doPost('MiLaiApi/GetModelIndex', params: {"TerminalType": "1001"});
    completer.complete(null);
    if (model.isSuccess) {
      _indexModel = IndexModel.fromJson(model.result);
      if (mounted) {
        setState(() {});
      }
    }

    _requestTheme();

    _curProductPage = 1;
    _requestProduct(_curProductPage);
    //return completer.future;
  }

  _requestTheme() async {
    ResponseModel model = await HttpService.shareInstance().doPost(
        'MiLaiApi/GetListIndexSpecial',
        params: {"MerchantID": "0", "PageSize": "6"});
    if (model.isSuccess) {
      _specialModels = getIndexSpecialModelList(model.result);
      setState(() {});
    }
  }

  _requestProduct(int page) async {
    if (_isRequesting) {
      return;
    }
    _isRequesting = true;
    ResponseModel model = await HttpService.shareInstance()
        .doPost("MiLaiApi/GetPageListRecommendRuleProduct", params: {
      "MerchantID": "0",
      "PageSize": "3",
      "PageIndex": page.toString(),
      "DisplayPositionType": "1002"
    });
    _isRequesting = false;
    if (model.isSuccess) {
      if (_curProductPage == 1) {
        _recommendProductModels.clear();
      }

      List list = model.result['Entity'];
      for (Map item in list) {
        RecommendProductModel model = RecommendProductModel.fromJson(item);
        _recommendProductModels.add(model);
      }
      setState(() {});
    }
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
    if (_indexModel == null ||
        _indexModel.activityAdList2 == null ||
        _indexModel.activityAdList2.length == 0) {
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

  //创建精选好铺
  Widget _createFeaturedShop() {
    if (_indexModel == null ||
        _indexModel.featuredShop == null ||
        _indexModel.featuredShop.length < 1) {
      return null;
    }
    return new Column(
      children: _indexModel.featuredShop.map((FeaturedShop shop) {
        return new CachedNetworkImage(
          imageUrl: shop.imageUrl,
          placeholder: new Image.asset("images/no_picture.png"),
        );
      }).toList(),
    );
  }

  //创建商品列表
  Widget _createProductList() {
    List<Widget> children = new List();
    children.add(new CachedNetworkImage(
      imageUrl: _indexModel.recommendProductBgUrl,
    ));

    for (int i = 0; i < (_recommendProductModels.length / 2.0).ceil(); ++i) {
      int start = i * 2;
      RecommendProductModel model1 = _recommendProductModels[start];
      RecommendProductModel model2;
      if (start + 1 < _recommendProductModels.length) {
        model2 = _recommendProductModels[start + 1];
      }
      children.add(new Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new IndexProductView(model1),
              ),
              new Expanded(
                flex: 1,
                child: model2 != null
                    ? new IndexProductView(model2)
                    : new Container(),
              )
            ],
          )));
    }

    return new Column(
      children: children,
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
          padding: EdgeInsets.all(0),
          crossAxisCount: 5,
          physics: new NeverScrollableScrollPhysics(),
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
    } else if (index == 5) {
      return _createFeaturedShop();
    } else if (index == 6) {
      return _createProductList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _requestIndex,
            child: new ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(0),
              itemCount: 7,
              itemBuilder: (_, int index) => _createItem(index),
            )),
        new IndexTitlebar(_scrollController),
      ],
    );
  }
}
