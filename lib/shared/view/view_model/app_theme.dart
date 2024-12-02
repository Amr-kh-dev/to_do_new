import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColorLight = Color(0xFF5D9CEC);
  static Color white = Color(0xFFFFFFFF);
  static Color green = Color(0xFF61E757);
  static Color red = Color(0xFFEC4B4B);
  static Color gry = Color(0xFFC8C9CB);
  static Color primaryColorDark = Color(0xFF5D9CEC);
  static Color black = Color(0xFF141922);

  //////////////////////////////////////////////////////////
  static ThemeData lightMode = ThemeData(
      appBarTheme:
          AppBarTheme(backgroundColor: Colors.transparent, centerTitle: true),
      primaryColor: white,
      scaffoldBackgroundColor: white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: gry,
        selectedItemColor: primaryColorLight,
        unselectedItemColor: white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColorLight,
        foregroundColor: white,
        shape: CircleBorder(side: BorderSide(width: 4, color: white)),
      ),
      textTheme: TextTheme(
          headlineMedium: TextStyle(
              fontSize: 22, color: white, fontWeight: FontWeight.w700),
          titleMedium: TextStyle(
              fontSize: 20, color: black, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(
              fontSize: 14, color: black, fontWeight: FontWeight.w400)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorLight,
      )));
  //////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////
  static ThemeData darkMode = ThemeData(
      appBarTheme:
          AppBarTheme(backgroundColor: Colors.transparent, centerTitle: true),
      primaryColor: primaryColorDark,
      scaffoldBackgroundColor: black,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: gry,
        selectedItemColor: primaryColorLight,
        unselectedItemColor: white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColorLight,
        foregroundColor: white,
        shape: CircleBorder(side: BorderSide(width: 4, color: white)),
      ),
      textTheme: TextTheme(
          headlineMedium: TextStyle(
              fontSize: 22, color: black, fontWeight: FontWeight.w700),
          titleMedium: TextStyle(
              fontSize: 20, color: black, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(
              fontSize: 14, color: black, fontWeight: FontWeight.w400)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorLight,
      )));
}
