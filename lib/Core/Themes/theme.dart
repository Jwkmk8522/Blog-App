import 'package:blog_app/Core/Themes/app_pallate.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallate.borderColor]) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color, width: 3),
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallate.backgroundColor,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 50,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.w800,
      ),
      titleSmall: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(fontSize: 14, color: Colors.white),
      labelLarge: TextStyle(fontSize: 14, color: AppPallate.greyColor),
      labelMedium: TextStyle(fontSize: 18, color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      border: _border(),
      errorBorder: _border(AppPallate.errorColor),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallate.gradient1),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppPallate.backgroundColor,
      titleTextStyle: TextStyle(
        color: AppPallate.whiteColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
