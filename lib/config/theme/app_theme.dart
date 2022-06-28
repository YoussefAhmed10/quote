import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qoutes/core/utils/app_colors.dart';
import 'package:qoutes/core/utils/app_string.dart';

ThemeData themeData() {
  return ThemeData(
    primaryColor: HexColor("#f2f2f2"),
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      // backgroundColor: HexColor("#000000"),
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          fontSize: 22,
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold),
    ),
    fontFamily: AppString.fontFamily,
  );
}
