import 'package:nle4malaria/styles/font_size.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static TextStyle titleStyle({Color? color, bool? isBold = false}) =>
      TextStyle(
          fontSize: titleSize,
          color: color,
          fontWeight: isBold! ? FontWeight.bold : FontWeight.normal);

  static TextStyle titleStyle2({Color? color, bool? isBold = false}) =>
      TextStyle(
          fontSize: titleSize,
          // color: blackColor,
          fontWeight: isBold! ? FontWeight.bold : FontWeight.normal);

  static TextStyle subTitleStyle({Color? color, bool? isBold = false}) =>
      TextStyle(
          fontSize: subTitleSize,
          color: color,
          fontWeight: isBold! ? FontWeight.bold : FontWeight.normal,
          fontFamily: 'Roboto');

  static TextStyle headerStyle({Color? color, bool? isBold = false}) =>
      TextStyle(
          fontSize: headerSize, color: color, fontWeight: FontWeight.bold);

  static TextStyle splashScreenStyle({Color? color, bool? isBold = false}) =>
      TextStyle(
          fontSize: 35,
          color: color,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto');
}
