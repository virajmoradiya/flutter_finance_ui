import 'package:flutter/material.dart';
import 'package:flutter_finance_ui/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.lightPrimary,
      iconTheme: const IconThemeData(color: AppColors.blackColor),
      textTheme: TextTheme(
        bodySmall: commonStyle(fontSize: 21, color: AppColors.blackColor),
        bodyLarge: commonStyle(fontSize: 30, color: AppColors.blackColor, letterSpacing: 1),
        bodyMedium: commonStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.blackColor),
        displayLarge: commonStyle(color: AppColors.lightText, fontSize: 15, fontWeight: FontWeight.w400),
        displaySmall: commonStyle(color: AppColors.lightText, fontSize: 18, letterSpacing: 1),
        displayMedium: commonStyle(color: AppColors.lightText, fontSize: 30, letterSpacing: 1),
        headlineSmall: commonStyle(fontSize: 14, color: AppColors.blackColor),
      ));

  static ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.blackColor,
      iconTheme: const IconThemeData(color: AppColors.lightPrimary),
      textTheme: TextTheme(
        bodySmall: commonStyle(fontSize: 21, color: AppColors.lightPrimary),
        bodyLarge: commonStyle(fontSize: 30, color: AppColors.lightPrimary, letterSpacing: 1),
        bodyMedium: commonStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.lightPrimary),
        displayLarge: commonStyle(color: AppColors.lightText, fontSize: 15, fontWeight: FontWeight.w400),
        displaySmall: commonStyle(color: AppColors.lightText, fontSize: 18, letterSpacing: 1),
        displayMedium: commonStyle(color: AppColors.lightText, fontSize: 30, letterSpacing: 1),
        headlineSmall: commonStyle(fontSize: 14, color: AppColors.blackColor),
      ));

  static TextStyle commonStyle({double? fontSize, FontWeight? fontWeight, Color? color, double? letterSpacing}) {
    return GoogleFonts.inclusiveSans(
        fontSize: fontSize, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing);
  }
}
