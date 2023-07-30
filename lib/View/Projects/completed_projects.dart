// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:thiran_task/View/Projects/widget/completed_projects_widget.dart';

import '../../Model/data.dart';
import '../Dashboard Design/dashboard_design.dart';

class CompletedProjects extends StatelessWidget {
  CompletedProjects({super.key});

  Data data = Data();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: data.onGoingList.length,
        // Length of the itemList from the Data class
        itemBuilder: (context, index) {
          if (data.onGoingList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          return GestureDetector(
            onTap: () {
              //passing particular project details to next screen
              String itemName = data.completedList[index];
              String sharedBy = data.completedsharedBy[index];
              String startTime = data.completedstartTime[index];
              String endTime = data.completedendTime[index];
              int percentage = data.completedListprogressBarPercentage[index];
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
              child: completedProjectItemRows(
                  context,
                  // Accessing the itemList, sharedBy, startTime, endTime and
                  //progressBarPercentage from the itemList through the 'data' class instance
                  data.completedList[index],
                  data.completedsharedBy[index],
                  data.completedstartTime[index],
                  data.completedendTime[index],
                  data.completedListprogressBarPercentage[index]),
            ),
          );
        },
      ),
    );
  }
}
