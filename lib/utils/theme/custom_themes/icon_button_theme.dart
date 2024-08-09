import 'package:flutter/material.dart';

class TIconButtonTheme {
  TIconButtonTheme._();

  // Tema claro
  static IconButtonThemeData lightIconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      //backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.grey.withOpacity(0.2);
          }
          return null;
        },
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.all(8.0)),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );

  // Tema oscuro
  static IconButtonThemeData darkIconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      //backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.white.withOpacity(0.2);
          }
          return null;
        },
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.all(8.0)),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );
}
