import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';
import 'package:flutter_milai/network/wx_auth_manager.dart';

class LoginVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginVCState();
  }
}

class _LoginVCState extends State<LoginVC> {
  bool _showPassword = false; //是否显示密码
  bool _loginBtnEnable = false;
  bool _codeMode = false; //是否是验证码登录模式
  bool _codeBtnEnable = true;

  int _codeCountDown = 0;

  final FocusNode _accountFocusNode = new FocusNode();
  final FocusNode _passFocusNode = new FocusNode();
  final FocusNode _codeFocusNode = new FocusNode();
  final TextEditingController _accountCtrl = new TextEditingController();
  final TextEditingController _codeCtrl = new TextEditingController();
  final TextEditingController _passCtrl = new TextEditingController();

@override
  void initState() {
    super.initState();

    _accountCtrl.text = "18806869807";
  }

  //关闭
  _onClosePress() {
    Navigator.pop(context);
  }

  //忘记密码
  _onForgetPasswordPress() {}

  //微信登录
  _onWeixinPress() async {
    LoadingDialog.show(context, '正在登录');
    var ret = await WXAuthManager.shareInstance().login();
    if (ret != null) {
      //微信平台验证成功
      ResponseModel model = await HttpService.shareInstance()
          .doPost("MiLaiApi/WeiXinRegister", params: {
        "WeixinUnionId": ret['unionid'] ?? "",
        "NickName": ret["nickname"] ?? "",
        "Sex": (ret["sex"] ?? 1).toString(),
        "HeaderLogo": ret["headimgurl"] ?? "",
        "WeiXinOpenId": ret["openid"] ?? "",
        "Ip": "",
        "Lat": "",
        "Lng": "",
      });

      LoadingDialog.hide(context);
      if (model.isSuccess) {
        _onLoginSuccess(UserModel.fromJson(model.result));
      } else {
        ToastUtils.shortToast(model.message);
      }
    } else {
      LoadingDialog.hide(context);
      ToastUtils.shortToast('登录失败');
    }
  }

  //注册
  _onRegisterPress() {}

  //获取验证码
  _onGetCodePress() async {
    _accountFocusNode.unfocus();

    if (!RegexUtil.isMobileExact(_accountCtrl.text)) {
      ToastUtils.shortToast('请输入正确手机号');
      return;
    }

    ResponseModel ret = await HttpService.shareInstance()
        .doPost('MiLaiApi/LoginSign', params: {"Account": _accountCtrl.text});
    if (ret.isSuccess) {
      _codeBtnEnable = false;
      setState(() {});

      TimerUtil timer = TimerUtil(mTotalTime: 60 * 1000);
      timer.setOnTimerTickCallback((int t) {
        _codeCountDown = (t / 1000).ceil();
        if (_codeCountDown == 0) {
          _codeBtnEnable = true;
        }
        setState(() {});
      });
      timer.startCountDown();
    } else {
      ToastUtils.shortToast(ret.message);
    }
  }

  //登录
  _onLoginPress() async {
    if (_codeMode && (isEmpty(_accountCtrl.text) || isEmpty(_codeCtrl.text))) {
      ToastUtils.shortToast('手机号或验证码为空');
      return;
    }
    if (!_codeMode && (isEmpty(_accountCtrl.text) || isEmpty(_passCtrl.text))) {
      ToastUtils.shortToast('手机号或密码为空');
      return;
    }

    Map<String, String> params = {
      "Account": _accountCtrl.text,
      "Lat": "",
      "Lng": "",
    };
    String url = "";
    LoadingDialog.show(context, '正在登录');
    if (_codeMode) {
      params["Code"] = _codeCtrl.text;
      url = "MiLaiApi/VerificationCodeLogin";
    } else {
      params["Password"] = _passCtrl.text;
      url = "MiLaiApi/UserLogin";
    }
    ResponseModel ret =
        await HttpService.shareInstance().doPost(url, params: params);
    LoadingDialog.hide(context); 
    if (ret != null && ret.isSuccess) {
      _onLoginSuccess(UserModel.fromJson(ret.result));
    } else {
      ToastUtils.shortToast(ret.message);
    }
  }

  //登入成功后调用的
  _onLoginSuccess(UserModel user) {
    UserManager.shareInstance().userModel = user;

    ToastUtils.longToast('登录成功');

    _onClosePress();
    //Future.delayed(Duration(milliseconds: 200), _onClosePress);
  }

  //输入变化
  _onInputChanged(String changed) {
    print(changed);
    if (_codeMode) {
      _loginBtnEnable =
          isNotEmpty(_accountCtrl.text) && isNotEmpty(_codeCtrl.text);
    } else {
      _loginBtnEnable =
          isNotEmpty(_accountCtrl.text) && isNotEmpty(_passCtrl.text);
    }
    setState(() {});
  }

  Widget _buildPassWidget() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Icon(
          Icons.lock_outline,
          size: 20,
          color: Color(0xff999999),
        ),
        new Expanded(
          child: new TextField(
            obscureText: !_showPassword,
            maxLines: 1,
            controller: _passCtrl,
            focusNode: _passFocusNode,
            onChanged: _onInputChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              border: InputBorder.none,
              hintText: '密码',
              hintStyle: TextStyle(color: Color(0xff999999), fontSize: 16),
            ),
          ),
        ),
        new IconButton(
          icon: Image.asset(_showPassword
              ? 'images/open_eye_ico.png'
              : 'images/close_eye_ico.png'),
          onPressed: () {
            _showPassword = !_showPassword;
            setState(() {});
          },
        ),
        new Container(
          width: 1,
          height: 20,
          color: Color(0xff999999),
        ),
        new FlatButton(
          child: Text('忘记密码',
              style: TextStyle(color: Color(0xff999999), fontSize: 13)),
          onPressed: _onForgetPasswordPress,
        )
      ],
    );
  }

  Widget _buildCodeWidget() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Icon(
          Icons.lock_outline,
          size: 20,
          color: Color(0xff999999),
        ),
        new Expanded(
          child: new TextField(
            maxLines: 1,
            onChanged: _onInputChanged,
            controller: _codeCtrl,
            focusNode: _codeFocusNode,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              border: InputBorder.none,
              hintText: '请输入验证码',
              hintStyle: TextStyle(color: Color(0xff999999), fontSize: 16),
            ),
          ),
        ),
        new OutlineButton(
          disabledBorderColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          borderSide: BorderSide(
            color: Global.kTintColor,
          ),
          child: Text(_codeBtnEnable ? '获取验证码' : '$_codeCountDown秒',
              style: TextStyle(
                  color: _codeBtnEnable ? Global.kTintColor : Colors.grey,
                  fontSize: 13)),
          onPressed: _codeBtnEnable ? _onGetCodePress : null,
        )
      ],
    );
  }

  Widget _buildBody() {
    return new Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 50),
              child: new Image.asset('images/logo.png'),
            ),
            new Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.person_outline,
                  size: 20,
                  color: Color(0xff999999),
                ),
                new Expanded(
                  child: new TextField(
                    controller: _accountCtrl,
                    maxLines: 1,
                    onChanged: _onInputChanged,
                    keyboardType: TextInputType.number,
                    focusNode: _accountFocusNode,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 20, right: 20, bottom: 0),
                      border: InputBorder.none,
                      hintText: '请输入手机号',
                      hintStyle:
                          TextStyle(color: Color(0xff999999), fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
            new Container(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Divider(
                height: 1,
              ),
            ),
            _codeMode ? _buildCodeWidget() : _buildPassWidget(),
            new Container(
              padding: EdgeInsets.only(top: 0, bottom: 30),
              child: Divider(
                height: 1,
              ),
            ),
            new Container(
              width: kScreenWidth,
              child: new RaisedButton(
                onPressed: _onLoginPress,
                color: _loginBtnEnable ? Global.kTintColor : Color(0xffc5c5c5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '登 录',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            new Container(
              height: 30,
              child: new Row(
                children: <Widget>[
                  new FlatButton(
                    child: Text(
                      '注册',
                      style: TextStyle(color: Color(0xff999999), fontSize: 13),
                    ),
                    onPressed: _onRegisterPress,
                  ),
                  new Expanded(
                    child: Container(),
                  ),
                  new FlatButton(
                    child: Text(
                      '验证码登录',
                      style: TextStyle(color: Color(0xff999999), fontSize: 13),
                    ),
                    onPressed: () {
                      _codeMode = !_codeMode;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Text(
              '其他登录方式',
              style: TextStyle(color: Color(0xff999999)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: IconButton(
                iconSize: 30,
                icon: Image.asset('images/weixin_ico.png'),
                onPressed: _onWeixinPress,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Color(0xfff0f0f0),
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            new IconButton(
              icon: new Image.asset('images/login_close_ico.png'),
              onPressed: _onClosePress,
            ),
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            print('Tap');
            _accountFocusNode.unfocus();
            _passFocusNode.unfocus();
            _codeFocusNode.unfocus();
          },
          child: new Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.topCenter,
                child: _buildBody(),
              ),
              new Align(
                alignment: Alignment.bottomCenter,
                child: new Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: new FlatButton(
                    onPressed: _onClosePress,
                    child: Text('先不登录 逛一逛 >>',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xff999999))),
                  ),
                ),
              )
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
