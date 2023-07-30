//custom_alert_dialog.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.textField,
  }) : super(key: key);

  final String title, description;
  final bool textField;
  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  TextEditingController nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(widget.description),
          const SizedBox(height: 15),
          widget.textField
              ? TextField(
                  controller: nameEditingController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Please enter the member name',
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 10),
                    border: InputBorder.none,
                  ),
                )
              : Container(),
          const SizedBox(height: 20),
          const Divider(
            height: 1,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              highlightColor: Colors.grey[200],
              onTap: () {
                //
                if (widget.textField) {
                  //checking true or false to validate name
                  if (nameEditingController.text != "") {
                    //snackbar for success
                    var snackdemo = SnackBar(
                      content: Text(
                          'Congrats...! You have added ${nameEditingController.text} to the team...'),
                      backgroundColor: Colors.black54,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(5),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                    Navigator.of(context).pop();
                  } else {
                    //toast for failure
                    Fluttertoast.showToast(
                        msg: "Please type a name to add into the team",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                } else {
                  return;
                }
              },
              child: Center(
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
