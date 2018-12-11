import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';

class IndexTitlebar extends StatefulWidget {
  final ScrollController scrollController;
  IndexTitlebar(this.scrollController) : super();

  @override
  State<StatefulWidget> createState() {
    return new _IndexTitlebarState();
  }
}

class _IndexTitlebarState extends State<IndexTitlebar> {
  double _backgroundAlpha = 0.0; //背景透明度

  @override
  void initState() {
    super.initState();

    if (widget.scrollController != null) {
      widget.scrollController.addListener(() {
        double offset = MediaQuery.of(context).size.width * (176-Global.kStateBarHeight-44) / 375;
        if (widget.scrollController.offset < offset) {
          _backgroundAlpha = widget.scrollController.offset < 0
              ? 0
              : widget.scrollController.offset / offset;
        } else {
          _backgroundAlpha = 1.0;
        }
        print('${widget.scrollController.offset}/$offset');
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Global.kStateBarHeight + 44;
    return new Container(
      color: new Color.fromRGBO(0xFC, 0x3A, 0x43, _backgroundAlpha),
      height: height,
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Expanded(
            child: new Container(
              height: 30,
              margin: EdgeInsets.only(bottom: 7, left: 10),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(5),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(
                    Icons.search,
                    color: Global.kDefTextColor,
                    size: 20,
                  ),
                  new Text(
                    '商品搜索',
                    style: new TextStyle(color: Global.kDefTextColor),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            height: 44,
            width: 44,
            alignment: Alignment.center,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Image.asset('images/service_ico.png'),
                new Text(
                  '客服',
                  style: new TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
