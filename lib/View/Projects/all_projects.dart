// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:thiran_task/View/Projects/widget/project_color.dart';

import '../../Model/data.dart';
import '../Dashboard Design/dashboard_design.dart';
import '../common/dialog_box.dart';

class AllProjects extends StatelessWidget {
  AllProjects({super.key});

  Data data = Data();
  GetColor getColor = GetColor();
  //get color object to decide color of circle chart
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: data.itemList.length,
        // Length of the itemList from the Data class
        itemBuilder: (context, index) {
          if (data.itemList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          return GestureDetector(
            onTap: () {
              //passing particular project details to next screen
              String itemName = data.itemList[index];
              String sharedBy = data.sharedBy[index];
              String startTime = data.startTime[index];
              String endTime = data.endTime[index];
              int percentage = data.progressBarPercentage[index];
              List<String> xValues = [
                'Sun',
                'Mon',
                'Tue',
                'Wed',
                'Thur',
                'Fri',
              ];
              List<double> yValues = [];
              //defining the chart Y values based on the percentage
              if (data.progressBarPercentage[index] > 70) {
                yValues = [5, 4, 6, 4, 7, 3];
              } else if (data.progressBarPercentage[index] > 50) {
                yValues = [3, 2, 9, 6, 4, 1];
              } else if (data.progressBarPercentage[index] > 20) {
                yValues = [3, 2, 9, 6, 4, 1];
              } else {
                yValues = [6, 4, 3, 7, 3, 4];
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardDesignScreen(
                    itemName: itemName,
                    sharedBy: sharedBy,
                    startTime: startTime,
                    endTime: endTime,
                    percentage: percentage,
                    xValues: xValues,
                    yValues: yValues,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
              child: allProjectItemRows(
                  context,
                  // Accessing the itemList, sharedBy, startTime, endTime and
                  //progressBarPercentage from the itemList through the 'data' class instance
                  data.itemList[index],
                  data.sharedBy[index],
                  data.startTime[index],
                  data.endTime[index],
                  data.progressBarPercentage[index]),
            ),
          );
        },
      ),
    );
  }

  Row allProjectItemRows(
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
                _showCustomDialog(context);
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
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black54)),
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
          // Use the function to get the appropriate color.
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

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlertDialog(
          title: 'Add Team Member',
          description: 'You can add the team member by typing the name',
          textField: true,
        );
      },
    );
  }
}
