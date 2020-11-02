import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/font_family.dart';

import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.montserrat,
    brightness: Brightness.light,
    primarySwatch:
        MaterialColor(AppColors.greenBlue[500].value, AppColors.greenBlue),
    primaryColor: AppColors.greenBlue[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.greenBlueAccent[200],
    accentColorBrightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.greenBlue[50],
    visualDensity: VisualDensity.adaptivePlatformDensity);
