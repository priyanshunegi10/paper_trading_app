import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MiniChart extends StatelessWidget {
  final List<dynamic> sparklineData;
  final bool isProfit;

  const MiniChart({
    super.key,
    required this.sparklineData,
    required this.isProfit,
  });

  @override
  Widget build(BuildContext context) {
    if (sparklineData.isEmpty) {
      return SizedBox();
    }

    // 2. THE MATH: List<dynamic> ko X aur Y coordinates (FlSpot) mein badalna
    // X = Time (0, 1, 2...), Y = Price (64000, 64200...)
    List<FlSpot> spots = [];
    for (int i = 0; i < sparklineData.length; i++) {
      spots.add(FlSpot(i.toDouble(), (sparklineData[i] as num).toDouble()));
    }

    // 3. THE COLOR: Profit hai toh hara, Loss hai toh laal
    Color lineColor = isProfit
        ? Colors.greenAccent.shade400
        : Colors.redAccent.shade400;

    return LineChart(
      LineChartData(
        // Background ka kachra (lines, numbers, borders) saaf karna taaki sirf line dikhe
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),

        // Data points ko graph ke edges tak theek se fit karna
        clipData: const FlClipData.all(),

        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: lineColor,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true, // Graph ke niche halka sa fade/shadow effect
              color: lineColor.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}
