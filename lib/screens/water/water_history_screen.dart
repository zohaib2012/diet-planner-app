import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/water_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class WaterHistoryScreen extends StatelessWidget {
  const WaterHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water History'),
        backgroundColor: AppColors.waterColor,
        foregroundColor: Colors.white,
      ),
      body: Consumer<WaterProvider>(
        builder: (context, waterProvider, _) {
          final history = waterProvider.getWeekHistory();
          final maxGlasses = history
              .map((l) => l.glassCount)
              .fold<int>(0, (a, b) => a > b ? a : b);
          final chartMax = (maxGlasses < waterProvider.goalGlasses
                  ? waterProvider.goalGlasses
                  : maxGlasses) +
              2;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Last 7 Days',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Daily goal: ${waterProvider.goalGlasses} glasses',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                // Bar chart
                SizedBox(
                  height: 280,
                  child: BarChart(
                    BarChartData(
                      maxY: chartMax.toDouble(),
                      alignment: BarChartAlignment.spaceAround,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipRoundedRadius: 8,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final log = history[group.x];
                            return BarTooltipItem(
                              '${log.glassCount} glasses\n${log.totalMl} ml',
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: (chartMax / 4).ceilToDouble(),
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= history.length) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  Helpers.formatDateShort(history[index].date),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: (chartMax / 4).ceilToDouble(),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(history.length, (index) {
                        final log = history[index];
                        final reachedGoal =
                            log.glassCount >= waterProvider.goalGlasses;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: log.glassCount.toDouble(),
                              color: reachedGoal
                                  ? AppColors.waterColor
                                  : AppColors.waterColor.withOpacity(0.5),
                              width: 22,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Summary list
                ...history.map((log) {
                  final reachedGoal =
                      log.glassCount >= waterProvider.goalGlasses;
                  return ListTile(
                    leading: Icon(
                      reachedGoal ? Icons.check_circle : Icons.circle_outlined,
                      color: reachedGoal ? AppColors.primary : Colors.grey,
                    ),
                    title: Text(Helpers.formatDate(log.date)),
                    trailing: Text(
                      '${log.glassCount} / ${waterProvider.goalGlasses}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: reachedGoal
                            ? AppColors.waterColor
                            : AppColors.textSecondary,
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
