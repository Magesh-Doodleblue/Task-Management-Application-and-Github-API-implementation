import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

Widget buildCheckBoxWithText(
  String text,
  bool checkBoxValue,
  ValueChanged<bool?> onChanged,
) {
  return Row(
    children: [
      CustomCheckBox(
        value: checkBoxValue,
        shouldShowBorder: true,
        borderColor: Color.fromARGB(255, 116, 143, 249),
        checkedFillColor: Color.fromARGB(255, 116, 143, 249),
        borderRadius: 5,
        borderWidth: 1,
        checkBoxSize: 18,
        onChanged: onChanged,
      ),
      SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ],
  );
}
