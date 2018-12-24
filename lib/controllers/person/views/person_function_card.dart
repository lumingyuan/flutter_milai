import 'package:flutter/material.dart';
import 'package:badge/badge.dart';
import 'package:quiver/strings.dart';

class PersonFunctionParams {
  String icon;
  String title;
  VoidCallback onPress;
  String badge;

  PersonFunctionParams(this.icon, this.title, this.onPress, {this.badge = ""});
}

class PersonFunctionCardWidget extends StatelessWidget {
  final List<PersonFunctionParams> params;
  final String title;
  final bool hasMore; //有没有更多

  PersonFunctionCardWidget(this.params, this.title, {this.hasMore = false});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = new List();
    for (PersonFunctionParams param in params) {
      Widget funWidget = FlatButton(
              onPressed: param.onPress,
              padding: EdgeInsets.all(0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Image.asset(param.icon),
                    Container(
                      height: 4,
                    ),
                    Text(
                      param.title,
                      style: TextStyle(color: Color(0xff333333), fontSize: 12),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            );
            if (isEmpty(param.badge) || param.badge == '0') {
              widgets.add(Expanded(child: funWidget));
            } else {
              widgets.add(Expanded(child: Badge.left(
                value: param.badge,
                child: funWidget,
                isRounded: true,
                positionRight: 10,
                positionTop: -10,
                textStyle: TextStyle(fontSize: 12, color: Colors.white),
                borderSize: 1,
              )));
            }
    }

    return new Container(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.all(0),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 20,
              top: 12.5,
              child: Text('$title',
                  style: TextStyle(color: Color(0xff333333), fontSize: 14)),
            ),
            Positioned(
              right: 12.5,
              top: 15,
              child: hasMore
                  ? Row(
                      children: <Widget>[
                        Text(
                          '查看更多订单',
                          style:
                              TextStyle(color: Color(0xff666666), fontSize: 10),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff666666),
                          size: 14,
                        ),
                      ],
                    )
                  : Container(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 15,
              child: Row(
                children: widgets,
              ),
            )
          ],
        ),
      ),
    );
  }
}
