// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:thiran_task/View/Projects/widget/ongoing_project_widget.dart';

import '../../Model/data.dart';
import '../Dashboard Design/dashboard_design.dart';

class OngoingProjects extends StatelessWidget {
  OngoingProjects({super.key});

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
              String itemName = data.onGoingList[index];
              String sharedBy = data.onGoingsharedBy[index];
              String startTime = data.onGoingstartTime[index];
              String endTime = data.onGoingendTime[index];
              int percentage = data.onGoingListprogressBarPercentage[index];

              List<String> xValues = [
                'Sun',
                'Mon',
                'Tue',
                'Wed',
                'Thur',
                'Fri'
              ];
              List<double> yValues = [5, 4, 6, 4, 7, 3];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardDesignScreen(
                    itemName: itemName,
                    sharedBy: sharedBy,
                    startTime: startTime,
                    endTime: endTime,
                    percentage: percentage,
                    // progressBarColor: progressBarColor,
                    xValues: xValues,
                    yValues: yValues,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
              child: ongoingProjectItemRows(
                  context,
                  // Accessing the itemList, sharedBy, startTime, endTime and
                  //progressBarPercentage from the itemList through the 'data' class instance
                  data.onGoingList[index],
                  data.onGoingsharedBy[index],
                  data.onGoingstartTime[index],
                  data.onGoingendTime[index],
                  data.onGoingListprogressBarPercentage[index]),
            ),
          );
        },
      ),
    );
  }
}
