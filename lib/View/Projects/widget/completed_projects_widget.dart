import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'project_color.dart';

GetColor getColor = GetColor();
//
Row completedProjectItemRows(
  BuildContext context,
  String itemName,
  String sharedBy,
  String startTime,
  String endTime,
  int percentage,
) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(itemName,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text("Today, Shared by - $sharedBy",
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 18),
          const Text("Team",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              var snackdemo = const SnackBar(
                content: Text(
                    'This is Completed project, you cannot add anyone here ;-)'),
                backgroundColor: Colors.black54,
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(5),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
            },
            child: SizedBox(
              width: 120,
              child: Stack(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/man.jpg"),
                    radius: 14,
                  ),
                  const Positioned(
                    left: 16,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/woman.jpg"),
                      radius: 14,
                    ),
                  ),
                  const Positioned(
                    left: 34,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/man2.jpg"),
                      radius: 14,
                    ),
                  ),
                  const Positioned(
                    left: 52,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/woman2.jpg"),
                      radius: 14,
                    ),
                  ),
                  Positioned(
                    left: 70,
                    child: CircleAvatar(
                      backgroundColor: Colors.orange.withOpacity(0.7),
                      radius: 14,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/icons/calendar.png",
                width: 16,
                height: 16,
                color: Colors.black54,
              ),
              const SizedBox(width: 8),
              Text("$startTime - $endTime",
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ],
      ),
      const Spacer(),
      CircularStepProgressIndicator(
        totalSteps: 100,
        currentStep: percentage,
        stepSize: 8,
        selectedColor: getColor.getSelectedColor(percentage),
        unselectedColor: Colors.grey[200],
        padding: 0,
        width: 85,
        height: 85,
        selectedStepSize: 8,
        child: Center(
            child: Text(
          "$percentage%",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        )),
        roundedCap: (_, __) => true,
      ),
    ],
  );
}
