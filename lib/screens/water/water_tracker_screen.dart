import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/water_provider.dart';
import '../../utils/constants.dart';

class WaterTrackerScreen extends StatelessWidget {
  const WaterTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
        backgroundColor: AppColors.waterColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/water-history'),
          ),
        ],
      ),
      body: Consumer<WaterProvider>(
        builder: (context, waterProvider, _) {
          final log = waterProvider.getTodayLog();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Progress summary card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          '${log.glassCount} / ${log.goalGlasses}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.waterColor,
                          ),
                        ),
                        const Text(
                          'glasses today',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: log.progress.clamp(0.0, 1.0),
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(5),
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.waterColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${log.totalMl} ml consumed',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Water glasses grid
                _buildGlassGrid(log.glassCount, log.goalGlasses),
                const SizedBox(height: 20),

                // Add / Remove buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => waterProvider.removeGlass(),
                      icon: const Icon(Icons.remove),
                      label: const Text('Remove'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: AppColors.textPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    ElevatedButton.icon(
                      onPressed: () => waterProvider.addGlass(),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Glass'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.waterColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Goal setting
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Daily Goal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.flag, color: AppColors.waterColor),
                            const SizedBox(width: 8),
                            Text(
                              '${waterProvider.goalGlasses} glasses '
                              '(${waterProvider.goalGlasses * waterProvider.glassSizeMl} ml)',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Slider(
                          value: waterProvider.goalGlasses.toDouble(),
                          min: 1,
                          max: 16,
                          divisions: 15,
                          activeColor: AppColors.waterColor,
                          label: '${waterProvider.goalGlasses} glasses',
                          onChanged: (value) {
                            waterProvider.setGoalGlasses(value.round());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds a grid of glass icons: filled for consumed, outlined for remaining.
  Widget _buildGlassGrid(int filled, int goal) {
    final total = filled > goal ? filled : goal;
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: List.generate(total, (index) {
        final isFilled = index < filled;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isFilled ? Icons.local_drink : Icons.local_drink_outlined,
              size: 40,
              color: isFilled ? AppColors.waterColor : Colors.grey[350],
            ),
            Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: 11,
                color: isFilled ? AppColors.waterColor : Colors.grey,
              ),
            ),
          ],
        );
      }),
    );
  }
}
