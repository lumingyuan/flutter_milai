import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';
import '../model/index_special_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_milai/network/http_service.dart';

class IndexSpecailView extends StatefulWidget {
  final List<IndexSpecialModel> specailModels;

  IndexSpecailView({Key key, this.specailModels}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _IndexSpecailViewState();
  }
}

class _IndexSpecailViewState extends State<IndexSpecailView> {
  int _currentCategory = 0;
  List<SpecialProductList> _productModels = new List();

  @override
  void initState() {
    super.initState();
  }

  void _loadProduct(String adExpandTBID, String adExpandCategoryTBID) async {
    var params = {
      "MerchantID": "0",
      "PageSize": "6",
      "PageIndex": "1",
      "AdExpandTBID": adExpandTBID,
      "AdExpandCategoryTBID": adExpandCategoryTBID,
    };

    ResponseModel model = await HttpService.shareInstance()
        .doPost("MiLaiApi/GetPageListSpecialProduct", params: params);
    if (model.isSuccess) {
      _productModels.clear();
      for (Map<String, dynamic> entity in model.result['Entity']) {
        SpecialProductList product = SpecialProductList.fromJson(entity);
        _productModels.add(product);
      }
      if (!mounted) return;
      setState(() {});
    }
  }

  Widget _createCategroyTab(int index) {
    List<SpecialCategoryList> model =
        widget.specailModels[index].specialCategoryList;
    if (model == null) {
      return null;
    }

    List<Widget> children = new List();
    for (int i = 0; i < model.length; ++i) {
      SpecialCategoryList category = model.elementAt(i);
      children.add(new Expanded(
        flex: 1,
        child: new FlatButton(
          onPressed: () {
            print("${category.className} 点击");
            setState(() {
              _currentCategory = i;
              _loadProduct(widget.specailModels[index].adExpandTBID,
                  category.adExpandCategoryTBID);
            });
          },
          textColor:
              _currentCategory == i ? Global.kTintColor : Global.kDefTextColor,
          child: new Text(category.className),
        ),
      ));
    }
    return new Row(
      children: children,
    );
  }

  //创建分类tab
  Widget _createProductGridView(int index) {
    IndexSpecialModel model = widget.specailModels[index];
    List<SpecialProductList> products = new List();

    if ((_productModels == null || _productModels.length == 0) &&
        _currentCategory == 0) {
      products = model.specialProductList;
    } else {
      products = _productModels;
    }

    if (products == null || products.length == 0) {
      return new Container(
        height: 150,
      );
    } else {
      return new Container(
        height: 150,
        child: new GridView.count(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          childAspectRatio: 150 / 100,
          padding: EdgeInsets.only(left: 10, right: 10),
          children: products.map((SpecialProductList product) {
            return new Container(
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
                    style:
                        new TextStyle(color: Global.kTintColor, fontSize: 12),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }
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
                _createCategroyTab(index),
                _createProductGridView(index),
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
