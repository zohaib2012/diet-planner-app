import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/constants.dart';

class UnitSettingsScreen extends StatelessWidget {
  const UnitSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ThemeProvider>();
    final isMetric = provider.unitSystem == 'metric';

    return Scaffold(
      appBar: AppBar(title: Text('Units')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Measurement System', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: 'metric',
                    groupValue: provider.unitSystem,
                    onChanged: (v) => provider.setUnitSystem(v!),
                    title: Text('Metric', style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text('kg, cm, ml'),
                    activeColor: AppColors.primary,
                  ),
                  Divider(height: 0),
                  RadioListTile<String>(
                    value: 'imperial',
                    groupValue: provider.unitSystem,
                    onChanged: (v) => provider.setUnitSystem(v!),
                    title: Text('Imperial', style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text('lbs, ft/in, oz'),
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text('Preview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _previewRow('Weight', isMetric ? '70.0 kg' : '154.3 lbs'),
                    Divider(),
                    _previewRow('Height', isMetric ? '170 cm' : "5'7\""),
                    Divider(),
                    _previewRow('Water', isMetric ? '250 ml' : '8.5 oz'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
