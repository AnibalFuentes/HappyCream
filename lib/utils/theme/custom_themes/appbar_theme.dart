import 'package:flutter/material.dart';

class TAppBarTheme {

  TAppBarTheme._();

  static  final lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.deepPurple[300],
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.black,size: 24),
    actionsIconTheme: const IconThemeData(color: Colors.black,size: 24),
    titleTextStyle: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color:Colors.black)
  );

   static  final darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.deepPurple[300],
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black,size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white,size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color:Colors.white)
  );
  
}