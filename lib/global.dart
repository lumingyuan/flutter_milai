import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:event_bus/event_bus.dart';

export 'package:pull_to_refresh/pull_to_refresh.dart';
export 'package:flutter_milai/network/http_service.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:flutter_milai/mangers/user_manager.dart';
export 'package:quiver/strings.dart';
export 'dart:async';
export 'dart:convert';
export 'package:flutter_milai/common/common.dart';
export 'package:quiver/time.dart';
export 'package:event_bus/event_bus.dart';

final double kScreenWidth = MediaQueryData.fromWindow(window).size.width;
final double kScreenHeight = MediaQueryData.fromWindow(window).size.height;

void lLog(String str) {
  print(str);
}

class Global {
  static ThemeData themeData = new ThemeData(
    primaryColor: kTintColor,
    primaryColorBrightness: Brightness.dark,
  );

  static final appDomain = 'http://api1.milaizhan.net';

  static final Color kTintColor = new Color(0xFFFC3A43);
  static final Color kDefTextColor = new Color(0xFF666666);


  //手机状态栏高度
  static final double kStateBarHeight = MediaQueryData.fromWindow(window).padding.top;
  //缩放比例
  static final double kScale = MediaQueryData.fromWindow(window).size.width/375;

  static EventBus eventBus = new EventBus();
}