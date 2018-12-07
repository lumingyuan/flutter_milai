import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';
import '../model/index_special_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_milai/network/http_service.dart';

class IndexSpecailView extends StatefulWidget {
  List<IndexSpecialModel> specailModels;

  IndexSpecailView({Key key, this.specailModels}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _IndexSpecailViewState();
  }
}

class _IndexSpecailViewState extends State<IndexSpecailView> {
  @override
  void initState() {
    super.initState();
  }

  //创建分类tab
  Widget _createCategroyItems(int index) {
    IndexSpecialModel model = widget.specailModels.elementAt(index);

    List<Tab> tabs = model.specialCategoryList
        .map((SpecialCategoryList category) => new Tab(
              text: category.className,
            ))
        .toList();
    return new Container(
      height: 190,
      child: new DefaultTabController(
        length: model.specialCategoryList.length,
        child: new Scaffold(
          appBar: PreferredSize(
            child: new AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: new TabBar(
                unselectedLabelColor: Global.kDefTextColor,
                labelColor: Global.kTintColor,
                tabs: tabs,
                isScrollable: true,
                indicatorColor: Global.kTintColor,
              ),
            ),
            preferredSize: Size.fromHeight(40),
          ),
          body: new TabBarView(
            children:
                model.specialCategoryList.map((SpecialCategoryList category) {
              return new _SpecailProductView(
                categoryModel: category,
                adExpandTBID: model.adExpandTBID,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.specailModels != null) {
      return new Padding(
        padding: EdgeInsets.only(top: 10),
        child: new ListView.builder(
          physics: new NeverScrollableScrollPhysics(), //禁用滚动事件
          shrinkWrap: true,
          controller: null,
          itemBuilder: (_, int index) {
            IndexSpecialModel model = widget.specailModels.elementAt(index);
            return new Column(
              children: <Widget>[
                new CachedNetworkImage(
                  imageUrl: model.imageUrl,
                ),
                _createCategroyItems(index),
              ],
            );
          },
          itemCount: widget.specailModels.length,
        ),
      );
    } else {
      return new Divider(
        height: 0,
      );
    }
  }
}

class _SpecailProductView extends StatefulWidget {
  SpecialCategoryList categoryModel;
  String adExpandTBID;
  _SpecailProductView({Key key, this.categoryModel, this.adExpandTBID})
      : super(key: key) ;

  @override
  State<StatefulWidget> createState() => new _SpecailProductViewState();
}

class _SpecailProductViewState extends State<_SpecailProductView> {
  List<SpecialProductList> _productModels = new List();

  @override
  void initState() {
    super.initState();

    _loadProduct();
  }

  void _loadProduct() {
    var params = {
      "MerchantID": "0",
      "PageSize": "6",
      "PageIndex": "1",
      "AdExpandTBID": widget.adExpandTBID,
      "AdExpandCategoryTBID": widget.categoryModel.adExpandCategoryTBID,
    };

    HttpService.shareInstance().post("MiLaiApi/GetPageListSpecialProduct",
        params: params, successBlock: (ResponseModel model) {
      _productModels.clear();
      for (Map<String, dynamic> entity in model.result['Entity']) {
        SpecialProductList product = SpecialProductList.fromJson(entity);
        _productModels.add(product);
      }
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new GridView.count(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        childAspectRatio: 150 / 100,
        padding: EdgeInsets.only(left: 10, right: 10),
        children: _productModels.map((SpecialProductList product) {
          return new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.all(5),
                  child: new AspectRatio(
                    aspectRatio: 1,
                    child: new Container(
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                new Text(
                  product.productName,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    color: Global.kDefTextColor,
                    fontSize: 12,
                  ),
                ),
                new Text(
                  '¥${product.price}',
                  style: new TextStyle(color: Global.kTintColor, fontSize: 12),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
