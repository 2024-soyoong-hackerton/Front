// graph.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// 그래프 표시하는 예시 화면
class LineChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Line Chart Example')),
      body: LineChartSample(
        xData: [1, 2, 3, 4, 5], // Example x data
        yData: [8, 3, 6, 2, 10], // Example y data
      ),
    );
  }
}

// 그래프를 그리는 위젯
class LineChartSample extends StatelessWidget {
  final List<double> xData;
  final List<double> yData;

  LineChartSample({required this.xData, required this.yData});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                xData.length,
                    (index) => FlSpot(xData[index], yData[index]),
              ),
              isCurved: true,
              color: Colors.blue,
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            ),
          ],
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black, width: 1),
          ),
        ),
      ),
    );
  }
}
