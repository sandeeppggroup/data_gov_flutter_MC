// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/petroleum_product.dart';

class PetroleumChartWidget extends StatefulWidget {
  final List<PetroleumProduct> data;

  const PetroleumChartWidget({super.key, required this.data});

  @override
  _PetroleumChartWidgetState createState() => _PetroleumChartWidgetState();
}

class _PetroleumChartWidgetState extends State<PetroleumChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final groupedData = groupBy(widget.data, (PetroleumProduct p) => '${p.month} ${p.year}');
    final sortedKeys = groupedData.keys.toList()..sort();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Monthly Production of Petroleum Products',
              style: TextStyle(
                color: Color(0xff0f4a3c),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: widget.data.map((p) => p.quantity).reduce((a, b) => a > b ? a : b),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final product = groupedData[sortedKeys[group.x.toInt()]]![rodIndex];
                        return BarTooltipItem(
                          '${product.product}\n${product.quantity.toStringAsFixed(2)}',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                    touchCallback: (FlTouchEvent event, barTouchResponse) {
                      setState(() {
                        if (event is FlPointerHoverEvent || event is FlTapUpEvent) {
                          touchedIndex = barTouchResponse?.spot?.touchedBarGroupIndex ?? -1;
                        } else {
                          touchedIndex = -1;
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              sortedKeys[value.toInt()],
                              style: const TextStyle(
                                color: Color(0xff7589a2),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                        reservedSize: 38,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(groupedData.length, (index) {
                    final monthYear = sortedKeys[index];
                    final products = groupedData[monthYear]!;
                    return BarChartGroupData(
                      x: index,
                      barRods: products.asMap().entries.map((entry) {
                        final isSelected = touchedIndex == index;
                        return BarChartRodData(
                          toY: entry.value.quantity,
                          color: _getBarColor(entry.key, isSelected),
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: widget.data.map((p) => p.quantity).reduce((a, b) => a > b ? a : b),
                            color: const Color(0xffDCF0E9),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                  gridData: const FlGridData(show: false),
                ),
                swapAnimationDuration: const Duration(milliseconds: 250),
              ),
            ),
            const SizedBox(height: 12),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    final products = widget.data.map((e) => e.product).toSet().toList();
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: products.asMap().entries.map((entry) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getBarColor(entry.key, false),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              entry.value,
              style: const TextStyle(fontSize: 12, color: Color(0xff7589a2)),
            ),
          ],
        );
      }).toList(),
    );
  }

  Color _getBarColor(int index, bool isSelected) {
    final colors = [
      const Color(0xff53B175),
      const Color(0xffF8A44C),
      const Color(0xffF7A593),
      const Color(0xffD3B0E0),
      const Color(0xffFDE598),
    ];
    final color = colors[index % colors.length];
    return isSelected ? color.withOpacity(0.8) : color;
  }
}

// Helper function to group list elements (unchanged)
Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}