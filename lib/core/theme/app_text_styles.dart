import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:personal_website/core/utils/adaptation.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle logo(BuildContext context) {
    return TextStyle(
      fontFamily: "BroshK",
      fontSize: isMobile(context) ? 175 : 256,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
      height: 0.65,
    );
  }

  static TextStyle console(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: isMobile(context) ? 16 : 24,
      fontWeight: FontWeight.normal,
      color: AppColors.textConsole,
      height: 1,
    );
  }

  static TextStyle nav(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: isMobile(context) ? 24 : 36,
      fontWeight: FontWeight.normal,
      color: AppColors.textNav,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.textNav,
      decorationThickness: 1.5,
    );
  }

  static TextStyle button(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: isMobile(context) ? 32 : 42,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle back(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: isMobile(context) ? 52 : 64,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle header(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: isMobile(context) ? 50 : 96,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle miniHeader(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: isMobile(context) ? 32 : 64,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle label(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: isMobile(context) ? 26 : 32,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle musicLabel(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: 64,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle musicAuthor(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: 32,
      fontWeight: FontWeight.normal,
      color: AppColors.textNav,
    );
  }

  static TextStyle musicStatus(BuildContext context) {
    return TextStyle(
      fontFamily: "VCROSDMono",
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: AppColors.textConsole,
    );
  }
}
