import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GStyles {
  ///Colors
  //static Color get colorPrimary => const Color.fromRGBO(40, 92, 39, 1);
  static Color get colorPrimary => const Color.fromRGBO(21,109,84, 1);
  static Color get colorSecondary => const Color.fromARGB(255, 39, 134, 151);
  static Color get colorCrema => const Color.fromRGBO(240,240,240, 1);
  static Color get colorFail => const Color.fromARGB(255, 197, 37, 37);
  static Color get backgroundCircularIndicatorColor =>
      const Color.fromARGB(255, 243, 243, 243);
  static Color get darkTheme => const Color.fromRGBO(51, 51, 51, 1);

  static Color get drawerSelectColor => Colors.grey.withOpacity(.2);

  ///Gradients
  static LinearGradient get barGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [colorPrimary, colorSecondary],
      );

  ///Fonts
  static String get fontOkine => 'Okine';
  static String get fontMorganite => 'Morganite';
  static String get fontNunitoSans => 'NunitoSans';

  ///Text Styles
  static TextStyle get textBottomNavigationBarItemStyle => TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontFamily: fontOkine,
        fontSize: 13.sp,
      );

  static TextStyle get textBottomNavigationBarItemSelectedStyle =>
      textBottomNavigationBarItemStyle.copyWith(color: Colors.white);

  static TextStyle get bodyText1 => TextStyle(
        fontSize: 12.sp,
        fontFamily: fontNunitoSans,
        color: Colors.black,
      );

  static TextStyle get headline1 => TextStyle(
        fontSize: 32.sp,
        fontFamily: fontOkine,
        //fontWeight: FontWeight.w700,
      );

  static TextStyle get headline2 => headline1.copyWith(
        fontSize: 28.sp,
      );

  static TextStyle get headline3 => headline1.copyWith(
        fontSize: 24.sp,
      );

  static TextStyle get headline4 => headline1.copyWith(
        fontSize: 20.sp,
      );

  static TextStyle get headline5 => headline1.copyWith(
        fontSize: 16.sp,
      );

  static TextStyle get adviceText => TextStyle(
      fontFamily: 'GraphikArabic',
      fontWeight: FontWeight.w700,
      fontSize: 16.sp);

  ///Themes
  static CheckboxThemeData get checkBoxTheme => CheckboxThemeData(
        fillColor: MaterialStateProperty.all(GStyles.colorPrimary),
      );

  static BoxShadow get boxShadowButton =>
      const BoxShadow(color: Colors.black26, blurRadius: 7, spreadRadius: 4);

  static BoxShadow get socialMediaShadowButton =>
      const BoxShadow(color: Colors.black12, blurRadius: 3, spreadRadius: 1);
}
