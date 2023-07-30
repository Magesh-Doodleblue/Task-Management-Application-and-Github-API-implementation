// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../Model/data.dart';
import '../common/dialog_box.dart';

class AllProjects extends StatelessWidget {
  AllProjects({super.key});

  Data data = Data();

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
          return Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25),
            child: allProjectItemRows(
              context,
              data.itemList[index],
              // Accessing the item from the itemList through the 'data' class instance
              data.sharedBy[index],
              // Assuming you have a 'sharedBy' list defined somewhere else
              data.startTime[index],
              // Assuming you have a 'startTime' list defined somewhere else
              data.endTime[index],
              // Assuming you have an 'endTime' list defined somewhere else
              data.progressBarPercentage[index],
              // Accessing the progressBarPercentage from the Data class through the 'data' instance
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
            const SizedBox(height: 12),
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
                      radius: 16,
                    ),
                    const Positioned(
                      left: 18,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/woman.jpg"),
                        radius: 16,
                      ),
                    ),
                    const Positioned(
                      left: 38,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/man2.jpg"),
                        radius: 16,
                      ),
                    ),
                    const Positioned(
                      left: 58,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/woman2.jpg"),
                        radius: 16,
                      ),
                    ),
                    Positioned(
                      left: 78,
                      child: CircleAvatar(
                        backgroundColor: Colors.orange.withOpacity(0.7),
                        radius: 16,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/calendar.png",
                  width: 20,
                  height: 20,
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
          stepSize: 10,
          selectedColor: const Color.fromARGB(255, 116, 143, 249),
          unselectedColor: Colors.grey[200],
          padding: 0,
          width: 90,
          height: 90,
          selectedStepSize: 10,
          child: Center(
              child: Text(
            "$percentage%",
            style: const TextStyle(fontWeight: FontWeight.bold),
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
