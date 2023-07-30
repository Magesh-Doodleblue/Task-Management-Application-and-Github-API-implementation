import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget customAppbar() {
  return Container(
    child: Row(
      children: [
        Text(
          "Profile",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

AlertDialog dialogBoxAlert(BuildContext context) {
  return AlertDialog(
    title: Text("Confirm Deletion"),
    content: Text("Do you want to delete the profile image?"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(true);
          Fluttertoast.showToast(
            msg: "Data Deleted Successfully",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
          );
        },
        child: Text("Yes"),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child: Text("No"),
      ),
    ],
  );
}
