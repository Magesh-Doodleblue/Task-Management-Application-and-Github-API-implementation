import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Model/chart.dart';

class FilledCurveChart extends StatelessWidget {
  final List<String> xValues;
  final List<double> yValues;

  const FilledCurveChart(
      {super.key, required this.xValues, required this.yValues});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // Use CategoryAxis for x-axis with specific labels
        primaryYAxis: NumericAxis(
          // Set y-axis properties
          minimum: 0,
          maximum: 10,
          interval: 2,
        ),
        series: <ChartSeries>[
          SplineAreaSeries<ChartData, String>(
            dataSource: _getChartData(xValues, yValues),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: const Color.fromRGBO(0, 255, 0, 1), // Green color fallback
            gradient: _createGradient(),
          ),
        ],
      ),
    );
  }

  List<ChartData> _getChartData(List<String> xValues, List<double> yValues) {
    final List<ChartData> data = [];
    if (xValues.length == yValues.length) {
      for (int i = 0; i < xValues.length; i++) {
        data.add(ChartData(x: xValues[i], y: yValues[i]));
      }
    }
    return data;
  }

  LinearGradient _createGradient() {
    return const LinearGradient(
      colors: [Colors.green, Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
