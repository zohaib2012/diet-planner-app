import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/progress_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class WeightGraphScreen extends StatefulWidget {
  const WeightGraphScreen({super.key});

  @override
  State<WeightGraphScreen> createState() => _WeightGraphScreenState();
}

class _WeightGraphScreenState extends State<WeightGraphScreen> {
  int _selectedDays = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Trend'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ProgressProvider>(
        builder: (context, progressProvider, _) {
          final history = progressProvider.getWeightHistory(_selectedDays);

          // Compute stats
          double? minWeight, maxWeight, currentWeight;
          if (history.isNotEmpty) {
            minWeight = history.map((w) => w.weightKg).reduce((a, b) => a < b ? a : b);
            maxWeight = history.map((w) => w.weightKg).reduce((a, b) => a > b ? a : b);
            currentWeight = history.last.weightKg;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Toggle buttons
                Center(
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(10),
                    selectedColor: Colors.white,
                    fillColor: AppColors.primary,
                    isSelected: [_selectedDays == 7, _selectedDays == 30, _selectedDays == 90],
                    onPressed: (index) {
                      setState(() {
                        _selectedDays = [7, 30, 90][index];
                      });
                    },
                    children: const [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('7 Days')),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('30 Days')),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('90 Days')),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Chart
                if (history.length < 2)
                  const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Log at least 2 weights to see the graph.',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: 250,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: _calcInterval(minWeight!, maxWeight!),
                        ),
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: (history.length / 5).ceilToDouble().clamp(1, double.infinity),
                              getTitlesWidget: (value, meta) {
                                final i = value.toInt();
                                if (i < 0 || i >= history.length) return const SizedBox.shrink();
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    Helpers.formatDateShort(history[i].date),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 45,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toStringAsFixed(1),
                                  style: const TextStyle(fontSize: 10),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        minY: (minWeight! - 1).floorToDouble(),
                        maxY: (maxWeight! + 1).ceilToDouble(),
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(
                              history.length,
                              (i) => FlSpot(i.toDouble(), history[i].weightKg),
                            ),
                            isCurved: true,
                            color: AppColors.primary,
                            barWidth: 3,
                            dotData: FlDotData(
                              show: history.length <= 15,
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppColors.primary.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 24),

                // Stats row
                if (history.isNotEmpty)
                  Row(
                    children: [
                      _buildStatCard('Min', '${minWeight!.toStringAsFixed(1)} kg', Icons.arrow_downward, Colors.blue),
                      const SizedBox(width: 8),
                      _buildStatCard('Max', '${maxWeight!.toStringAsFixed(1)} kg', Icons.arrow_upward, AppColors.error),
                      const SizedBox(width: 8),
                      _buildStatCard('Current', '${currentWeight!.toStringAsFixed(1)} kg', Icons.monitor_weight, AppColors.primary),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _calcInterval(double min, double max) {
    final range = max - min;
    if (range <= 2) return 0.5;
    if (range <= 5) return 1;
    if (range <= 10) return 2;
    return 5;
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}
