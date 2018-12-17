import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_milai/controllers/login/login_vc.dart';

class NavigatorUtil {
  static goLogin(BuildContext context) {
    Navigator.push(
        context, new CupertinoPageRoute(builder: (context) => new LoginVC(), fullscreenDialog: true));
  }
}
