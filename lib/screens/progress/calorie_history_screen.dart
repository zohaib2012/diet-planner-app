import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/meal_provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class CalorieHistoryScreen extends StatelessWidget {
  const CalorieHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final dailyGoal = user?.dailyCalories ?? 2000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie History'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<MealProvider>(
        builder: (context, mealProvider, _) {
          final history = mealProvider.getCalorieHistory(7);
          final maxCal = history
              .map((h) => (h['calories'] as double))
              .fold<double>(dailyGoal, (a, b) => a > b ? a : b);
          final chartMax = ((maxCal / 500).ceil() * 500 + 500).toDouble();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Last 7 Days',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Daily goal: ${dailyGoal.toStringAsFixed(0)} kcal',
                  style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 24),

                // Bar chart
                SizedBox(
                  height: 280,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: chartMax,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 500,
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            getTitlesWidget: (value, meta) {
                              final i = value.toInt();
                              if (i < 0 || i >= history.length) return const SizedBox.shrink();
                              final date = history[i]['date'] as DateTime;
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  Helpers.formatDateShort(date),
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 42,
                            interval: 500,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                      ),
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [
                          HorizontalLine(
                            y: dailyGoal,
                            color: AppColors.error.withOpacity(0.6),
                            strokeWidth: 2,
                            dashArray: [8, 4],
                            label: HorizontalLineLabel(
                              show: true,
                              alignment: Alignment.topRight,
                              style: TextStyle(
                                color: AppColors.error.withOpacity(0.8),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              labelResolver: (_) => 'Goal',
                            ),
                          ),
                        ],
                      ),
                      barGroups: List.generate(history.length, (i) {
                        final cal = history[i]['calories'] as double;
                        final overGoal = cal > dailyGoal;
                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: cal,
                              color: overGoal ? AppColors.error : AppColors.primary,
                              width: 22,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                            ),
                          ],
                        );
                      }),
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              '${rod.toY.toStringAsFixed(0)} kcal',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Daily breakdown list
                const Text(
                  'Daily Breakdown',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...history.reversed.map((entry) {
                  final date = entry['date'] as DateTime;
                  final cal = entry['calories'] as double;
                  final overGoal = cal > dailyGoal;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: overGoal
                            ? AppColors.error.withOpacity(0.15)
                            : AppColors.primaryLight,
                        child: Icon(
                          overGoal ? Icons.warning_amber_rounded : Icons.check,
                          color: overGoal ? AppColors.error : AppColors.primary,
                          size: 18,
                        ),
                      ),
                      title: Text(Helpers.formatDate(date)),
                      trailing: Text(
                        '${cal.toStringAsFixed(0)} kcal',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: overGoal ? AppColors.error : AppColors.primary,
                        ),
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
