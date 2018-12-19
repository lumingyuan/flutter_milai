import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';

class PersonTuiKeCardWidget extends StatelessWidget {

  final UserCenterModel userCenter;

  PersonTuiKeCardWidget(this.userCenter);

  @override
  Widget build(BuildContext context) {
    if (userCenter == null || userCenter.distributor == null) {
      return new Container();
    }
    List<Map> params = [
      {"value":"${userCenter.distributor.moneyToday}元", "title":"今日收入", "onPress":(){}},
    {"value":"${userCenter.distributor.moneySUM}元", "title":"累计收入", "onPress":(){}},
    {"value":"${userCenter.distributor.distributorStoreCount}", "title":"我的店铺", "onPress":(){}},
    {"value":"${userCenter.distributor.countTeam}人", "title":"我的团队", "onPress":(){}}];

    List<Widget> widgets = new List();
    for (Map param in params) {
      widgets.add(Expanded(
          child: FlatButton(
        onPressed: param['onPress'],
        padding: EdgeInsets.all(0),
        child: Container(
          child: Column(
            children: <Widget>[
              Text(param['value'],
              style: TextStyle(color: Global.kTintColor, fontSize: 16),),
              Container(
                height: 10,
              ),
              Text(
                param['title'],
                style: TextStyle(color: Color(0xff333333), fontSize: 12),
                maxLines: 1,
              )
            ],
          ),
        ),
      )));
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
              child: Text('推客中心',
                  style: TextStyle(color: Color(0xff333333), fontSize: 14)),
            ),
            Positioned(
              right: 12.5,
              top: 15,
              child: Row(
                      children: <Widget>[
                        Text(
                          '查看更多  ',
                          style:
                              TextStyle(color: Color(0xff666666), fontSize: 10),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff666666),
                          size: 14,
                        ),
                      ],
                    ),
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
