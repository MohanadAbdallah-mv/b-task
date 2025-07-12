import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  //400 regular,medium500 , light 300, bold 600
  // static TextStyle regular24White = GoogleFonts.inter(
  //     fontWeight: FontWeight.w400,
  //     fontSize: 24,
  //     color: AppColors.darkBlueColor);
  static TextStyle bold13Black = GoogleFonts.dosis(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: const Color(0xff474443),
  );
  static TextStyle bold24Black = GoogleFonts.georama(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.appBarTitleColor,
  );
  static TextStyle activeProgress = GoogleFonts.georama(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static TextStyle inactiveProgress = GoogleFonts.georama(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.inactiveProgressIndicatorColor,
  );
  static TextStyle normalText = GoogleFonts.georama(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.normalTextColor,
  );
  static TextStyle textFieldTitle = GoogleFonts.georama(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textFieldTitleColor,
  );
  static TextStyle buttonText = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
