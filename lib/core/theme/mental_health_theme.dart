import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mental_health_care/core/theme/app_colors.dart';
import 'package:mental_health_care/core/theme/typography_theme.dart';

final ThemeData mentalHealthThemeDark = buildDarkTheme();

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      backgroundColor: AppColors.mentalDarkThemeColor,
      scaffoldBackgroundColor: AppColors.mentalDarkThemeColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.mentalDarkThemeColor,
          selectedItemColor: AppColors.mentalBrandColor,
          unselectedItemColor: AppColors.mentalOnboardingTextColor),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.mentalDarkThemeColor,
        iconTheme: IconThemeData(color: AppColors.mentalBrandLightColor),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: AppColors.mentalDarkThemeColor,
            statusBarIconBrightness: Brightness.light),
      ),
      iconTheme: IconThemeData(
        color: AppColors.mentalBrandLightColor,
      ),
      cardColor: AppColors.mentalDarkThemeColor,
      canvasColor: AppColors.mentalDarkColor,
      brightness: Brightness.dark,
      primaryColor: AppColors.mentalBrandColor,
      buttonTheme: ButtonThemeData(
          buttonColor: AppColors.mentalBrandColor,
          disabledColor: AppColors.mentalOnboardingTextColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: AppColors.mentalBrandColor,
      )),
      dialogBackgroundColor: AppColors.mentalDarkThemeColor,
      textTheme: mentalHealthTextThemeDark(base.textTheme),
      primaryTextTheme: Typography().white,
      colorScheme: ColorScheme.dark(
          primary: AppColors.mentalBrandColor,
          surface: AppColors.mentalDarkThemeColor,
          background: AppColors.mentalDarkThemeColor,
          brightness: Brightness.dark));
}

final ThemeData mentalHealthThemeLight = buildLightTheme();

ThemeData buildLightTheme() {
  TextStyle _buildTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(color: color, fontSize: size);
  }

  UnderlineInputBorder _buildBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(8),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: _buildBorder(AppColors.mentalOnboardingTextColor),
        errorBorder: _buildBorder(Colors.red),
        focusedBorder: _buildBorder(AppColors.mentalBrandColor),
        disabledBorder: _buildBorder(AppColors.mentalOnboardingTextColor),
        errorStyle: _buildTextStyle(Colors.red),
        labelStyle: _buildTextStyle(AppColors.mentalOnboardingTextColor),
        helperStyle: _buildTextStyle(AppColors.mentalOnboardingTextColor),
        hintStyle: _buildTextStyle(AppColors.mentalOnboardingTextColor),
        prefixStyle: _buildTextStyle(AppColors.mentalOnboardingTextColor),
      ),
      backgroundColor: AppColors.mentalBrandLightColor,
      scaffoldBackgroundColor: AppColors.mentalBrandLightColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.mentalBrandLightColor,
          selectedItemColor: AppColors.mentalBrandColor,
          unselectedItemColor: AppColors.mentalOnboardingTextColor),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.mentalBrandLightColor,
        iconTheme: IconThemeData(color: AppColors.mentalDarkColor),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.mentalBrandLightColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColors.mentalDarkColor,
      ),
      cardColor: AppColors.mentalBrandLightColor,
      canvasColor: AppColors.mentalBrandLightColor,
      brightness: Brightness.light,
      primaryColor: AppColors.mentalBrandColor,
      buttonTheme: ButtonThemeData(
          buttonColor: AppColors.mentalBrandColor,
          disabledColor: AppColors.mentalOnboardingTextColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: AppColors.mentalBrandColor,
      )),
      dialogBackgroundColor: AppColors.mentalBrandLightColor,
      textTheme: mentalHealthTextThemeLight(base.textTheme),
      primaryTextTheme: Typography().black,
      colorScheme: ColorScheme.light(
          primary: AppColors.mentalBrandColor,
          surface: AppColors.mentalBrandLightColor,
          background: AppColors.mentalBrandLightColor,
          brightness: Brightness.light));
}
