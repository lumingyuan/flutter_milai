import 'package:flutter/material.dart';
import 'dart:ui';

class Global {
  static ThemeData themeData = new ThemeData.light();

  static final appDomain = 'http://api.milaizhan.net/';

  static final Color kTintColor = new Color(0xFFFC3A43);
  static final Color kDefTextColor = new Color(0xFF666666);

  //手机状态栏高度
  static final double kStateBarHeight = MediaQueryData.fromWindow(window).padding.top;
}