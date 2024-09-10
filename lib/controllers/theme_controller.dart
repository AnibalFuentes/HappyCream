import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/utils/theme/theme.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = Rx<ThemeMode>(ThemeMode.system);

  @override
  void onInit() {
    super.onInit();

    _updateThemeModeFromSystem();
  }

  void _updateThemeModeFromSystem() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      themeMode.value =
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

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
