import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/injection_container.dart';
import 'app_colors.dart';

class Themes {
  static ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    colorScheme: const ColorScheme.light(primary: AppColors.primary),
    primaryColorDark: AppColors.primary,
    appBarTheme: ThemeData().appBarTheme.copyWith(
          toolbarHeight: 60.h,
          centerTitle: false,
          scrolledUnderElevation: 0,
          iconTheme: const IconThemeData.fallback().copyWith(
            color: AppColors.primary,
            size: 16.sp,
          ),
          actionsIconTheme: IconThemeData(
            size: 24.sp,
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
            fontSize: 18.sp,
            fontFamily: sl<SharedPreferences>().getString('lang') == 'ar'
                ? 'ibm-plex-sans-arabic'
                : 'roboto',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
    textTheme: Typography.englishLike2018.apply(
      fontSizeFactor: 1.sp,
      bodyColor: Colors.black,
      fontFamily: 'ibm-plex-sans-arabic',
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontFamily: sl<SharedPreferences>().getString('lang') == 'ar'
              ? 'ibm-plex-sans-arabic'
              : 'roboto',
        ),
      ),
    ),
    snackBarTheme: const SnackBarThemeData().copyWith(
      contentTextStyle: TextStyle(
        fontSize: 14.sp,
        fontFamily: sl<SharedPreferences>().getString('lang') == 'ar'
            ? 'ibm-plex-sans-arabic'
            : 'roboto',
      ),
    ),
  );
}
