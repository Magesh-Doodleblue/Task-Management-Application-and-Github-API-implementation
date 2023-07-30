// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:thiran_task/View/Projects/widget/all_project_widget.dart';

import '../../Model/data.dart';
import '../Dashboard Design/dashboard_design.dart';

class AllProjects extends StatelessWidget {
  AllProjects({super.key});

  Data data = Data();

  @override
  Widget build(BuildContext context) {
    return allProjectsBody();
  }

  Padding allProjectsBody() {
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
}
