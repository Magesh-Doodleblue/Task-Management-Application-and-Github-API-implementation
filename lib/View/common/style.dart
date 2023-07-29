import 'package:flutter/material.dart';

class AppStyle {
  static TextStyle customTextStyle(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    //
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }
}
