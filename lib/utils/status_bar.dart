import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBar {
  static void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
  }

  static void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }

  static void setCustomStatusBar(Color color, Brightness iconBrightness) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: iconBrightness,
    ));
  }
}
