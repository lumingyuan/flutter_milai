import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_milai/controllers/login/login_vc.dart';
import '../mangers/user_manager.dart';

class NavigatorUtil {
  static goLogin(BuildContext context) {
    Navigator.push(
        context,
        new CupertinoPageRoute(
            builder: (context) => new LoginVC(), fullscreenDialog: true));
  }

  static pushVC(BuildContext context, Widget vc, {bool needLogin = false}) {
    if (needLogin && !UserManager.shareInstance().isLogin) {
      //检查是否登陆，未登录将跳转到登录页面
      goLogin(context);
      return;
    }
    Navigator.push(
        context,
        new CupertinoPageRoute(
            builder: (context) => vc, fullscreenDialog: false));
  }
}
