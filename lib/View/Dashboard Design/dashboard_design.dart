// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../common/filled_charts.dart';

class DashboardDesignScreen extends StatelessWidget {
  const DashboardDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("Dashboard Design",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            FilledCurveChart(
              xValues: ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri'],
              yValues: [5, 4, 6, 4, 7, 3],
            ),
          ],
        ),
      ),
    );
  }
}
