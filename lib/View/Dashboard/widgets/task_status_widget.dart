import 'dart:developer';

import 'package:flutter/material.dart';

class TaskStatusWidget extends StatefulWidget {
  const TaskStatusWidget({super.key});

  @override
  State<TaskStatusWidget> createState() => _TaskStatusWidgetState();
}

class _TaskStatusWidgetState extends State<TaskStatusWidget> {
  Color _getBoxColor(int index) {
    switch (index) {
      case 0:
        return const Color.fromARGB(255, 244, 181, 86);
      case 1:
        return const Color.fromARGB(255, 132, 137, 233);
      case 2:
        return const Color.fromARGB(255, 129, 225, 134);
      case 3:
        return const Color.fromARGB(255, 255, 91, 79);
      default:
        return Colors.grey;
    }
  }

  String selectedBoxName = '';
  List statusNames = ["In Progress", "Ongoing", "Completed", "Cancel"];
  String taskDetails = "";
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double boxWidth = screenWidth * 0.35;
    double boxHeight = screenHeight * 0.1;
    log((boxWidth / boxHeight).toString());
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: boxWidth / boxHeight,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        Color boxColor = _getBoxColor(index);

        return InkWell(
          onTap: () {
            setState(() {
              selectedBoxName = 'You selected "${statusNames[index]}" Status';
              taskDetails = statusNames[index];
            });
            dialogBoxCalling(context, taskDetails);
          },
          child: Container(
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.punch_clock,
                  color: Colors.white,
                ),
                const SizedBox(height: 14),
                Text(
                  statusNames[index] ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> dialogBoxCalling(BuildContext context, String taskDetails) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(selectedBoxName),
          content: Text("Task 1 is $taskDetails"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
