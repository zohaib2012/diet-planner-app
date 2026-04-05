import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/calorie_calculator.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class BMICalculatorScreen extends StatelessWidget {
  const BMICalculatorScreen({super.key});

  Color _bmiColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue;
      case 'Normal':
        return Colors.green;
      case 'Overweight':
        return Colors.orange;
      case 'Obese':
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ProgressProvider>(
        builder: (context, progressProvider, _) {
          final bmi = progressProvider.latestBMI ??
              (user != null
                  ? CalorieCalculator.calculateBMI(weightKg: user.weightKg, heightCm: user.heightCm)
                  : null);
          final weight = progressProvider.latestWeight ?? user?.weightKg;
          final height = user?.heightCm ?? 170;
          final category = bmi != null ? CalorieCalculator.getBMICategory(bmi) : 'N/A';
          final color = _bmiColor(category);
          final logs = progressProvider.weightLogs;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // BMI display card
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text('Your BMI', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                        const SizedBox(height: 8),
                        Text(
                          bmi != null ? bmi.toStringAsFixed(1) : '--',
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Height & weight info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _infoChip(Icons.height, 'Height', '${height.toStringAsFixed(0)} cm'),
                            _infoChip(Icons.monitor_weight_outlined, 'Weight',
                                weight != null ? '${weight.toStringAsFixed(1)} kg' : '--'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // BMI scale bar
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('BMI Scale', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Row(
                            children: [
                              _scaleSegment(Colors.blue, 'Under', 1),
                              _scaleSegment(Colors.green, 'Normal', 1.3),
                              _scaleSegment(Colors.orange, 'Over', 1),
                              _scaleSegment(Colors.red, 'Obese', 1),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('< 18.5', style: TextStyle(fontSize: 10)),
                            Text('18.5', style: TextStyle(fontSize: 10)),
                            Text('25', style: TextStyle(fontSize: 10)),
                            Text('30', style: TextStyle(fontSize: 10)),
                            Text('40+', style: TextStyle(fontSize: 10)),
                          ],
                        ),
                        if (bmi != null) ...[
                          const SizedBox(height: 8),
                          _bmiIndicator(bmi),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // BMI history
                if (logs.isNotEmpty) ...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('BMI History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  ...logs.reversed.map((log) {
                    final logCategory = log.bmi != null ? CalorieCalculator.getBMICategory(log.bmi!) : 'N/A';
                    final logColor = _bmiColor(logCategory);
                    return Card(
                      margin: const EdgeInsets.only(bottom: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundColor: logColor.withOpacity(0.15),
                          child: Text(
                            log.bmi?.toStringAsFixed(1) ?? '--',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: logColor),
                          ),
                        ),
                        title: Text('${log.weightKg.toStringAsFixed(1)} kg'),
                        subtitle: Text(Helpers.formatDate(log.date)),
                        trailing: Text(logCategory, style: TextStyle(color: logColor, fontWeight: FontWeight.w500)),
                      ),
                    );
                  }),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoChip(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _scaleSegment(Color color, String label, double flex) {
    return Expanded(
      flex: (flex * 10).toInt(),
      child: Container(
        height: 20,
        color: color,
        alignment: Alignment.center,
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _bmiIndicator(double bmi) {
    // Map BMI 15-40 to 0.0-1.0 position
    final fraction = ((bmi - 15) / 25).clamp(0.0, 1.0);
    return LayoutBuilder(
      builder: (context, constraints) {
        final left = fraction * constraints.maxWidth;
        return Stack(
          children: [
            SizedBox(height: 16, width: constraints.maxWidth),
            Positioned(
              left: left.clamp(0, constraints.maxWidth - 14),
              child: const Icon(Icons.arrow_drop_up, size: 18, color: AppColors.textPrimary),
            ),
          ],
        );
      },
    );
  }
}
