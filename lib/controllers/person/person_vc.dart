import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';

import './views/person_function_card.dart';
import './views/person_tuike_card.dart';
import './setting/setting_vc.dart';


class PersonVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PersonVCState();
  }
}

class _PersonVCState extends State<PersonVC> {
  final List<PersonFunctionParams> _orderParams = [
    new PersonFunctionParams('images/person_order_1.png', '待付款', (){}),
    new PersonFunctionParams('images/person_order_2.png', '待发货', (){}),
    new PersonFunctionParams('images/person_order_3.png', '待收货', (){}),
    new PersonFunctionParams('images/person_order_4.png', '已完成', (){}),
    new PersonFunctionParams('images/person_order_5.png', '售后服务', (){}),
  ];

  final List<PersonFunctionParams> _activityParams = [
    new PersonFunctionParams('images/person_activity_1.png', '我的米粒', (){}),
    new PersonFunctionParams('images/person_activity_2.png', '我的粮票', (){}),
    new PersonFunctionParams('images/person_activity_3.png', '我的砍价', (){}),
    new PersonFunctionParams('images/person_activity_4.png', '我的拼团', (){}),
    new PersonFunctionParams('images/person_activity_5.png', '我的足迹', (){}),
  ];

  final List<PersonFunctionParams> _toolParasm = [
    new PersonFunctionParams('images/person_tool_1.png', '我的收藏', (){}),
    new PersonFunctionParams('images/person_tool_2.png', '收货地址', (){}),
    new PersonFunctionParams('images/person_tool_3.png', '客  服', (){}),
    new PersonFunctionParams('images/person_tool_4.png', '意见反馈', (){}),
    new PersonFunctionParams('images/person_tool_5.png', '帮  助', (){}),
  ];

  UserCenterModel _userCenterModel;  
  EventBus eventBus = new EventBus();

  @override
  void initState() {
    super.initState();

    Global.eventBus.on<UserChangedEvent>().listen((event){
      _requestCenter();
    });
  }

  _requestCenter() async {
    if (!UserManager.shareInstance().isLogin) {
      return;
    }

    ResponseModel model = await HttpService.shareInstance().doPost('MiLaiApi/GetUserCenter');
    if (model.isSuccess) {
      _userCenterModel = UserCenterModel.fromJson(model.result);
      setState(() {});
    } else {
      ToastUtils.shortToast(model.message);
    }
  }

  Widget _buildUserWidget() {
    String imageUrl = "";
    String phone = "";
    String code = "";
    String name = "";
    bool isTuike = false;
    if (UserManager.shareInstance().isLogin) {
      UserModel user = UserManager.shareInstance().userModel;
      imageUrl = user.headImageUrl;
      name = user.nickName;
      code = user.iD;
      phone = user.mobile;
      isTuike = user.isPush == 'True';
    }
    return new Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: Image.asset('images/person_head_ico.png'),
          ),
        ),
        Container(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20,
              margin: EdgeInsets.only(bottom: 8),
              child: Text('$name', style: TextStyle(color: Colors.white, fontSize: 17)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/person_phone_ico.png'),
                Container(
                  width: 3,
                ),
                Text('$phone',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                Container(
                  width: 10,
                ),
                Image.asset('images/person_tuike_code_ico.png'),
                Container(
                  width: 3,
                ),
                Text(
                  '$code',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Container(
                  width: 3,
                ),
                isTuike
                    ? Image.asset('images/person_tuike_ico.png')
                    : Container(),
              ],
            )
          ],
        ),
      ],
    );
  }

  //创建用户信息和订单
  Widget _buildUserAndOrder() {
    return Container(
        height: 180 * Global.kScale + 95,
        child: Stack(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 375 / 180,
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: new Image.asset(
                    'images/person_head_bg.png',
                    fit: BoxFit.cover,
                  ),
                )),
            Positioned(
              right: 10,
              top: Global.kStateBarHeight,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Image.asset('images/person_setting_ico.png'),
                      onPressed: () {
                        NavigatorUtil.pushVC(context, new SettingVC(), needLogin: true);
                      },
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Image.asset('images/person_chat_ico.png'),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 20,
              bottom: 130,
              child: _buildUserWidget(),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: PersonFunctionCardWidget(_orderParams, '我的订单', hasMore: true,),
            )
          ],
        ));
  }

  Widget _buildTuiKeWidget() {
    UserModel user = UserManager.shareInstance().userModel;
    bool isTuike = false;
    if (user != null) {
      isTuike = boolValueOf(user.isDistributor);
    }
    if (isTuike) {
      return Container(
        padding: EdgeInsets.all(10),
        child: PersonTuiKeCardWidget(_userCenterModel),
      );
    }
    return Container();
  }
  
  Widget _buildApplyTuikeiWidget() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff0f0f0),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          _buildUserAndOrder(),
          
          _buildTuiKeWidget(),

          _buildApplyTuikeiWidget(),

          Container(
            padding: EdgeInsets.all(10),
            child: PersonFunctionCardWidget(_activityParams, '我的活动'),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: PersonFunctionCardWidget(_toolParasm, '我的工具'),
          ),
        ],
      ),
    );
  }
}
