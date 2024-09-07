import 'package:flutter/material.dart';
import 'package:happycream/utils/theme/custom_themes/appbar_theme.dart';
import 'package:happycream/utils/theme/custom_themes/bottom_navigation_bar.dart';
import 'package:happycream/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:happycream/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:happycream/utils/theme/custom_themes/chip_theme.dart';
import 'package:happycream/utils/theme/custom_themes/drawer_theme.dart';
import 'package:happycream/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:happycream/utils/theme/custom_themes/expansion_tile_theme.dart';
import 'package:happycream/utils/theme/custom_themes/icon_button_theme.dart';
import 'package:happycream/utils/theme/custom_themes/icon_theme.dart';
import 'package:happycream/utils/theme/custom_themes/outline_button.dart';
import 'package:happycream/utils/theme/custom_themes/text_theme.dart';
import 'package:happycream/utils/theme/custom_themes/text_field_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.deepPurple.shade300,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      chipTheme: TChipTheme.lightChipTheme,
      checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
      outlinedButtonTheme: TOutlineButtomTheme.lightOutlineButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
      iconButtonTheme: TIconButtonTheme.lightIconButtonTheme,
      iconTheme: TIconTheme.lightIconTheme,
      bottomNavigationBarTheme:
          TBottomNavigationBar.lightBottomNavigationBarTheme,
      drawerTheme: TDrawerTheme.lightDrawerTheme,
      expansionTileTheme: TExpansionTileTheme.lightExpansionTileTheme);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple.shade300,
      scaffoldBackgroundColor: Colors.black87,
      textTheme: TTextTheme.darkTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.datkElevatedButtonTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      chipTheme: TChipTheme.darkChipTheme,
      checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
      outlinedButtonTheme: TOutlineButtomTheme.darkOutlineButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
      iconButtonTheme: TIconButtonTheme.darkIconButtonTheme,
      iconTheme: TIconTheme.darkIconTheme,
      bottomNavigationBarTheme:
          TBottomNavigationBar.darkBottomNavigationBarTheme,
      drawerTheme: TDrawerTheme.darkDrawerTheme,
      expansionTileTheme: TExpansionTileTheme.darkExpansionTileTheme);
}
