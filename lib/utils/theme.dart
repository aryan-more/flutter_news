import 'package:flutter/material.dart';

extension AppThemeData on ThemeData {
  AppTheme get theme => brightness == Brightness.light ? lightTheme : darkTheme;
}

class AppTheme {
  final Color background;
  final Color action;
  final Color accent;
  final bool isLightTheme;
  final Color textColor;

  const AppTheme({
    required this.background,
    required this.action,
    required this.accent,
    required this.isLightTheme,
    required this.textColor,
  });
  static ThemeData themeData(AppTheme appTheme) {
    ThemeData base = appTheme.isLightTheme ? ThemeData.light() : ThemeData.dark();

    return base.copyWith(
        scaffoldBackgroundColor: appTheme.background,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: appTheme.background,
          titleTextStyle: TextStyle(
            color: appTheme.textColor,
            fontSize: 25,
          ),
          iconTheme: IconThemeData(
            color: appTheme.action,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: appTheme.action,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: appTheme.action,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            fixedSize: const Size(
              double.infinity,
              50,
            ),
            textStyle: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: appTheme.action,
          selectionColor: appTheme.accent,
          selectionHandleColor: appTheme.action,
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: appTheme.action,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: appTheme.action,
            ),
          ),
          floatingLabelStyle: TextStyle(
            color: appTheme.action,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: appTheme.action,
            ),
          ),
        ),
        splashColor: appTheme.accent);
  }
}

const lightTheme = AppTheme(
  background: Colors.white,
  action: Colors.green,
  accent: Colors.greenAccent,
  isLightTheme: true,
  textColor: Colors.black,
);
const darkTheme = AppTheme(
  background: Colors.black,
  action: Colors.green,
  accent: Colors.greenAccent,
  isLightTheme: false,
  textColor: Colors.white,
);
