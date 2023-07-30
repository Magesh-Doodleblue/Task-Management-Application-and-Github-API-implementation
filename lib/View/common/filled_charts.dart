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
        borderColor: Colors.transparent,
        plotAreaBorderWidth: 0, //removes the border
        primaryXAxis: CategoryAxis(
          //set x axis
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          minorGridLines: const MinorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          // Remove major tick lines
          minorTickLines: const MinorTickLines(size: 0),
          // Remove minor tick lines
        ),
        primaryYAxis: NumericAxis(
          // Set y-axis
          minimum: 0,
          maximum: 10,
          interval: 2,
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          minorGridLines: const MinorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          // Remove major tick lines
          minorTickLines: const MinorTickLines(size: 0),
          // Remove minor tick lines
        ),
        series: <ChartSeries>[
          SplineAreaSeries<ChartData, String>(
            dataSource: _getChartData(xValues, yValues),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            gradient: _createGradient(),
            borderColor: Colors.green, // Border color for filled chart
            borderWidth: 4, // Border width for filled chart
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
