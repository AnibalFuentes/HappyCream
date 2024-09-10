import 'package:flutter/material.dart';

class TDrawerTheme {
  TDrawerTheme._();

  static final lightDrawerTheme = DrawerThemeData(
    elevation: 0,
    // scrimColor: Colors.transparent,
    backgroundColor: Colors.deepPurple[300],
    surfaceTintColor: Colors.transparent,
  );

  static final darkDrawerTheme = DrawerThemeData(
    elevation: 0,
    // scrimColor: Colors.transparent,
    backgroundColor: const Color.fromARGB(255, 15, 9, 44),
    surfaceTintColor: Colors.transparent,
  );
}
