import 'package:flutter/material.dart';
import '../model/recommend_product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_milai/global.dart';

class IndexProductView extends StatelessWidget {
  final RecommendProductModel productModel;

  IndexProductView(this.productModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
        shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new AspectRatio(
              aspectRatio: 1,
              child: new Container(
                decoration: new BoxDecoration(
                   image: DecorationImage(
                            image: CachedNetworkImageProvider(productModel.imageUrl),
                            fit: BoxFit.cover,
                          ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(left: 8, top: 5, right: 8),
              child: new Text(
                productModel.productName,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(color: Global.kDefTextColor),
                maxLines: 1,
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: new Text(
                '¥${productModel.price}',
                style: new TextStyle(color: Global.kTintColor, fontSize: 12),
              ),
            ),
          ],
        ));
  }
}
