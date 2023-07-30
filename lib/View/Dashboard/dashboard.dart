// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../Model/data.dart';
import '../Projects/widget/project_color.dart';
import '../common/style.dart';
import 'widgets/task_status_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedOption = 'All Task';

  Data data = Data();
  GetColor getColor = GetColor();
  //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxCustom(valueHeight: 10, valueWidth: 0),
              customAppbar(),
              sizedBoxCustom(valueHeight: 20, valueWidth: 0),
              greetingsToUser(),
              sizedBoxCustom(valueHeight: 10, valueWidth: 0),
              userName(),
              sizedBoxCustom(valueHeight: 25, valueWidth: 0),
              const SizedBox(height: 250, child: TaskStatusWidget()),
              //color color 4 boxes
              dailyTaskRow(), //dropdown with daily task text
              sizedBoxCustom(valueHeight: 15, valueWidth: 0),

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    //
                  },
                  child: ListView.builder(
                    itemCount: data.itemList.length,
                    itemBuilder: (context, index) {
                      if (data.itemList.isEmpty) {
                        return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.black));
                      }
                      return listOfDailyTasks(data.itemList[index],
                          data.progressBarPercentage[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card listOfDailyTasks(String itemList, int progressBarPercentage) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 30, left: 5, right: 5),
        child: Row(
          children: [
            //hard coding listview item with children
            sizedBoxCustom(valueWidth: 10, valueHeight: 0),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 0.7, color: Colors.black)),
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Icon(Icons.check, size: 10, color: Colors.black),
              ),
            ),
            sizedBoxCustom(valueWidth: 15, valueHeight: 0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemList,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 15),
                SizedBox(
                  width: 150,
                  child: StepProgressIndicator(
                    //progress indicator bar
                    totalSteps: 100,
                    currentStep: progressBarPercentage,
                    size: 6.5,
                    padding: 0,
                    selectedColor:
                        getColor.getSelectedColor(progressBarPercentage),
                    unselectedColor: Colors.transparent,
                    roundedEdges: const Radius.circular(10),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const SizedBox(
              width: 80,
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/man.jpg"),
                    radius: 16,
                  ),
                  Positioned(
                    left: 20,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/woman.jpg"),
                      radius: 16,
                    ),
                  ),
                  Positioned(
                    left: 40,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/woman3.jpg"),
                      radius: 16,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxCustom(valueWidth: 10, valueHeight: 0),
            Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.black.withOpacity(0.8)),
            sizedBoxCustom(valueWidth: 10, valueHeight: 0)
          ],
        ),
      ),
    );
  }

  Text userName() {
    return Text(
      "Alex Marconi",
      style: AppStyle.customTextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text greetingsToUser() {
    return Text(
      "Hello",
      style: AppStyle.customTextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),
    );
  }

  Row dailyTaskRow() {
    return Row(
      children: [
        const Text(
          "Daily Task",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        buildDropdownSelector(),
      ],
    );
  }

  SizedBox sizedBoxCustom(
          {required double valueWidth, required double valueHeight}) =>
      SizedBox(
        height: valueHeight,
        width: valueWidth,
      );

  Row customAppbar() {
    return const Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/avatar.jpg"),
          radius: 30,
        ),
        Spacer(),
        InkWell(
          child: ImageIcon(
            AssetImage("assets/icons/search.png"),
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget buildDropdownSelector() {
    return DropdownButton<String>(
      value: selectedOption,
      onChanged: (newValue) {
        setState(() {
          selectedOption = newValue!;
        });
      },
      elevation: 0,
      items: data.dropdownOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
