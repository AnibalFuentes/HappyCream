import 'package:flutter/material.dart';

class TDrawerTheme {
  TDrawerTheme._();

  static final lightDrawerTheme = DrawerThemeData(
    elevation: 0,
    scrimColor: Colors.black,
    backgroundColor: Colors.deepPurple[300],
    surfaceTintColor: Colors.transparent,
  );

  static final darkDrawerTheme = DrawerThemeData(
    elevation: 0,
    scrimColor: Colors.white,
    backgroundColor: Colors.deepPurple[300],
    surfaceTintColor: Colors.transparent,
  );
}
