import 'package:flutter/material.dart';

class TChipTheme {

  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.deepPurple.shade300,
    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
    checkmarkColor: Colors.white
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: const TextStyle(color: Colors.white),
    selectedColor: Colors.deepPurple.shade300,
    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
    checkmarkColor: Colors.white
  );
  
}