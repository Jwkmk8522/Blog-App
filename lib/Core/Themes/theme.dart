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
        fontSize: 52,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),

      enabledBorder: _border(),
      focusedBorder: _border(AppPallate.gradient1),
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppPallate.backgroundColor),
  );
}
