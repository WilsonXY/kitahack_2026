import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/features/nutrition/data/food_provider.dart';
import 'package:kitahack_2026/features/nutrition/models/food_model.dart';

class WeeklySummaryChart extends ConsumerWidget {
  const WeeklySummaryChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(foodHistoryProvider);

    return historyAsync.when(
      data: (foods) {
        final weeklyData = _calculateWeeklyData(foods);
        final totalConsumed = weeklyData.values.fold(0.0, (sum, val) => sum + val);
        const weeklyGoal = 2000.0 * 7; // Assuming 2000 kcal daily goal
        final remaining = (weeklyGoal - totalConsumed).clamp(0.0, weeklyGoal);

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kMangoAccent.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Weekly Calorie Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kTextBrown,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 60,
                        startDegreeOffset: -90,
                        sections: [
                          PieChartSectionData(
                            color: kMangoPrimary,
                            value: totalConsumed,
                            title: '',
                            radius: 25,
                            badgeWidget: _Badge(
                              Icons.restaurant,
                              size: 40,
                              borderColor: kMangoPrimary,
                            ),
                            badgePositionPercentageOffset: .98,
                          ),
                          PieChartSectionData(
                            color: kMangoPrimary.withValues(alpha: 0.1),
                            value: remaining,
                            title: '',
                            radius: 20,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${totalConsumed.round()}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: kTextBrown,
                            ),
                          ),
                          Text(
                            'of ${weeklyGoal.round()} kcal',
                            style: TextStyle(
                              fontSize: 12,
                              color: kTextBrown.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildLegend(),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Map<int, double> _calculateWeeklyData(List<FoodModel> foods) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final Map<int, double> dailyCalories = {};

    for (var i = 1; i <= 7; i++) {
      dailyCalories[i] = 0.0;
    }

    for (var food in foods) {
      if (food.createdAt.isAfter(startOfWeek)) {
        final weekday = food.createdAt.weekday;
        dailyCalories[weekday] = (dailyCalories[weekday] ?? 0.0) +
            food.nutritionResult.nutrition.calories;
      }
    }
    return dailyCalories;
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(color: kMangoPrimary, text: 'Consumed'),
        const SizedBox(width: 20),
        _LegendItem(color: kMangoPrimary.withValues(alpha: 0.1), text: 'Remaining'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12, color: kTextBrown)),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color borderColor;

  const _Badge(this.icon, {required this.size, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(child: Icon(icon, color: borderColor, size: size * .6)),
    );
  }
}
