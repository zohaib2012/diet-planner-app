import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/diet_plan_provider.dart';
import '../../utils/constants.dart';
import '../../utils/app_routes.dart';

class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DietPlanProvider>(context);
    final plans = provider.plans;

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Diet Plan')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select a plan that fits your lifestyle',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                return _PlanCard(
                  plan: plan,
                  onTap: () => _onPlanTap(context, provider, plan),
                );
              },
            ),
          ),

          // View weekly plan button
          if (provider.activePlan != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.calendar_month),
                  label: const Text('View Weekly Plan', style: TextStyle(fontSize: 16)),
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.weeklyPlan),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onPlanTap(BuildContext context, DietPlanProvider provider, plan) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Select ${plan.planName}?'),
        content: Text('This will set "${plan.planName}" as your active diet plan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {
              provider.selectPlan(plan.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${plan.planName} activated!'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final dynamic plan;
  final VoidCallback onTap;

  const _PlanCard({required this.plan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: plan.isActive
            ? const BorderSide(color: AppColors.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Plan info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.planName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plan.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Active indicator
              if (plan.isActive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Active',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
