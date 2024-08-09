import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/utils/theme/theme.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
  }

  ThemeData get lightTheme => TAppTheme.lightTheme;
  ThemeData get darkTheme => TAppTheme.darkTheme;
}
