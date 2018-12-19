import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';
import '../model/find_selected_model.dart';

class SearchSelectCell extends StatelessWidget {
  final FindSelectedModel model;

  SearchSelectCell(this.model);

  Widget _createImageWidget() {
    if (this.model.cardImgList.length == 1) {
      //只有一张图片
      return new AspectRatio(
        aspectRatio: 2,
        child: new ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: ImageUtils.imageFromUrl(
            this.model.cardImgList[0],
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (this.model.cardImgList.length == 2) {
      //两张图
      return new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              margin: EdgeInsets.only(right: 5),
              child: new AspectRatio(
                aspectRatio: 1,
                child: new ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: ImageUtils.imageFromUrl(
                    this.model.cardImgList[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Container(
              margin: EdgeInsets.only(left: 5),
              child: new AspectRatio(
                aspectRatio: 1,
                child: new ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: ImageUtils.imageFromUrl(
                    this.model.cardImgList[1],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return new Container(
        child: new Text("TODO...."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        padding: EdgeInsets.all(10),
        child: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(bottom: 10),
              child: new Row(
                children: <Widget>[
                  new SizedBox(
                    width: 40,
                    height: 40,
                    child: new CircleAvatar(
                      backgroundImage:
                          ImageUtils.imageProviderFromUrl(this.model.userHeadImgUrl),
                    ),
                  ),
                  new Container(
                    width: 5,
                  ),
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          this.model.title,
                          style: new TextStyle(
                              fontSize: 14, color: new Color(0xff333333)),
                        ),
                        new Text(
                          this.model.subtitle,
                          style: new TextStyle(
                              fontSize: 11, color: new Color(0xFF999999)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            _createImageWidget(),
            new Container(
                height: 50,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        '${this.model.browseNum} 阅读',
                        style: new TextStyle(
                            color: new Color(0xff999999), fontSize: 11),
                      ),
                    ),
                    new Text(
                      '${this.model.fabulousNum}',
                      style: new TextStyle(
                          color: new Color(0xff999999), fontSize: 11),
                    ),
                    new Container(
                      width: 8,
                    ),
                    new Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: new Color(0xff999999),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
