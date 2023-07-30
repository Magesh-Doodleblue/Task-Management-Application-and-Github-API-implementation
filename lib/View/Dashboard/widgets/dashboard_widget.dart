import 'package:flutter/material.dart';

SizedBox sizedBoxCustom(
        {required double valueWidth, required double valueHeight}) =>
    SizedBox(
      height: valueHeight,
      width: valueWidth,
    );
String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Noon';
  } else if (hour >= 17 && hour < 21) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}
