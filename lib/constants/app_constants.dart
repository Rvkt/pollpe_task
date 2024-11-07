import 'package:flutter/material.dart';

class ScreenUtil {
  static late double screenWidth;
  static late double screenHeight;
  static late double screenDensity;
  static late double statusBarHeight;

  static void init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    screenDensity = mediaQueryData.devicePixelRatio;
    statusBarHeight = mediaQueryData.padding.top;
  }
}