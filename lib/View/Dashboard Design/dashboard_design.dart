// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../Model/data.dart';
import '../Projects/widget/project_color.dart';
import '../common/filled_charts.dart';
import 'widget/dashboard_design_widget.dart';

class DashboardDesignScreen extends StatefulWidget {
  final String itemName;
  final String sharedBy;
  final String startTime;
  final String endTime;
  final int percentage;
  // final Color progressBarColor;
  final List<String> xValues;
  final List<double> yValues;

  const DashboardDesignScreen({
    super.key,
    required this.itemName,
    required this.sharedBy,
    required this.startTime,
    required this.endTime,
    required this.percentage,
    // required this.progressBarColor,
    required this.xValues,
    required this.yValues,
  });

  @override
  State<DashboardDesignScreen> createState() => _DashboardDesignScreenState();
}

class _DashboardDesignScreenState extends State<DashboardDesignScreen> {
  bool shouldCheck1 = false;
  bool shouldCheck2 = false;
  bool shouldCheck3 = false;

  String selectedOption = 'Weekly';
  Data data = Data();
  GetColor getColor = GetColor();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.itemName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 14),
              Text(
                'Today - Shared By: ${widget.sharedBy}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  CircularStepProgressIndicator(
                    totalSteps: 100,
                    currentStep: widget.percentage,
                    stepSize: 10,
                    selectedColor: getColor.getSelectedColor(widget.percentage),
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 100,
                    height: 100,
                    selectedStepSize: 10,
                    child: Center(
                        child: Text(
                      "${widget.percentage}%",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                    roundedCap: (_, __) => true,
                  ),
                  Spacer(flex: 1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: 130,
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/man.jpg"),
                              radius: 17,
                            ),
                            const Positioned(
                              left: 20,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/woman.jpg"),
                                radius: 17,
                              ),
                            ),
                            const Positioned(
                              left: 40,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/man2.jpg"),
                                radius: 17,
                              ),
                            ),
                            const Positioned(
                              left: 60,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/woman2.jpg"),
                                radius: 17,
                              ),
                            ),
                            Positioned(
                              left: 80,
                              child: CircleAvatar(
                                backgroundColor: Colors.orange.withOpacity(0.8),
                                radius: 17,
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
                      SizedBox(height: 15),
                      Text(
                        "Deadline",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      SizedBox(height: 10),
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
                          Text("${widget.startTime} - ${widget.endTime}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                  Spacer(flex: 2),
                ],
              ),
              SizedBox(height: 55),
              Text(
                "Project Progress",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              buildCheckBoxWithText("Create user flow", shouldCheck1, (value) {
                setState(() {
                  shouldCheck1 = value!;
                  log("Create user flow: $value");
                });
              }),
              buildCheckBoxWithText("Create wireframe", shouldCheck2, (value) {
                setState(() {
                  shouldCheck2 = value!;
                  log("Create wireframe: $value");
                });
              }),
              buildCheckBoxWithText("Transform to visual design", shouldCheck3,
                  (value) {
                setState(() {
                  shouldCheck3 = value!;
                  log("Transform to visual design: $value");
                });
              }),
              SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    "Project Overview",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  //dropdown
                  buildDropdownSelector(),
                ],
              ),
              SizedBox(height: 25),
              FilledCurveChart(
                //chart
                xValues: widget.xValues,
                yValues: widget.yValues,
              ),
              // You can also display the CircularStepProgressIndicator here with the provided data
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon:
            const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, size: 18),
          color: Colors.black,
          onPressed: () {
            // Do something
            Fluttertoast.showToast(
                msg: "Sorry, No Options is there!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0);
          },
        )
      ],
    );
  }


  Widget buildDropdownSelector() {
    return DropdownButton<String>(
      value: selectedOption,
      icon: Image.asset("assets/icons/down.png", width: 15),
      onChanged: (newValue) {
        setState(() {
          selectedOption = newValue!;
        });
      },
      elevation: 1,
      items: data.durationOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
