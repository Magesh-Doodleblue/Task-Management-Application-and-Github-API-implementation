import 'package:flutter/material.dart';

class GetColor {
  Color getSelectedColor(int percentage) {
    if (percentage >= 20 && percentage < 45) {
      return Colors.orange;
      // You can replace this with the color you want for the 20-40 range.
    } else if (percentage >= 45 && percentage < 65) {
      return Color.fromARGB(255, 116, 143, 249);
      // You can replace this with the color you want for the 40-60 range.
    } else if (percentage >= 60 && percentage <= 100) {
      return Colors.greenAccent.shade400;
      // You can replace this with the color you want for the 60-100 range.
    } else {
      return Colors
          .transparent; // This will be the default color when percentage is outside the specified ranges.
    }
  }
}
