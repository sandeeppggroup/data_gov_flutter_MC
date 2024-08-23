// // lib/widgets/chart_widget.dart
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../models/data_point.dart';

// class ChartWidget extends StatelessWidget {
//   final List<DataPoint> data;

//   const ChartWidget({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         lineBarsData: [
//           LineChartBarData(
//             spots: data.map((point) => FlSpot(point.x, point.y)).toList(),
//             isCurved: true,
//             color: Colors.blue,
//             dotData: const FlDotData(show: false),
//           ),
//         ],
//         titlesData: const FlTitlesData(
//             // bottomTitles: SideTitles(showTitles: true),
//             // leftTitles: SideTitles(showTitles: true),
//             ),
//       ),
//     );
//   }
// }
