import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/features/dashboard/presentation/calorie_tips.dart';
import 'package:kitahack_2026/features/dashboard/presentation/widgets/weekly_summary_chart.dart';
import 'package:kitahack_2026/features/history/presentation/widgets/history_summary_item.dart';
import 'package:kitahack_2026/features/nutrition/data/food_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  String _currentTip = "";
  late AnimationController _buttonController;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _buttonScale = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );
    _currentTip = calorieTips[Random().nextInt(calorieTips.length)];
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  void _refreshTip() {
    setState(() {
      _currentTip = calorieTips[Random().nextInt(calorieTips.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMangoBackground,
      appBar: AppBar(
        title: const Text(
          'SnapMango!',
          style: TextStyle(fontWeight: FontWeight.bold, color: kTextBrown),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: ScaleTransition(
                  scale: _buttonScale,
                  child: Material(
                    color: kMangoPrimary,
                    elevation: 8,
                    shape: const CircleBorder(
                      side: BorderSide(color: Colors.white, width: 4),
                    ),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        _buttonController.forward().then((_) {
                          _buttonController.reverse().then((_) {
                            if (context.mounted) {
                              Navigator.pushNamed(context, '/snap');
                            }
                          });
                        });
                      },
                      splashColor: kMangoAccent.withValues(alpha: 0.5),
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: kMangoPrimary.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: Colors.white, size: 40),
                            SizedBox(height: 8),
                            Text(
                              'Snap!',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildSectionTitle('Weekly Progress'),
              const SizedBox(height: 12),
              const WeeklySummaryChart(),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle('Recent History'),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    child: const Text(
                      'See All',
                      style: TextStyle(color: kMangoPrimary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ref.watch(foodHistoryProvider).when(
                    data: (foods) {
                      if (foods.isEmpty) {
                        return _buildEmptyState("No food logged yet!");
                      }
                      final recentFoods = foods.take(3).toList();
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: recentFoods.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return HistorySummaryItem(foodModel: recentFoods[index]);
                        },
                      );
                    },
                    error: (error, stack) =>
                        Center(child: Text("Error: $error", style: const TextStyle(color: Colors.red))),
                    loading: () =>
                        const Center(child: CircularProgressIndicator(color: kMangoPrimary)),
                  ),
              const SizedBox(height: 32),
              _buildSectionTitle('Daily Tip'),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _refreshTip,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kMangoAccent.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kMangoPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.lightbulb_rounded, color: kMangoPrimary, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            _currentTip,
                            key: ValueKey<String>(_currentTip),
                            style: const TextStyle(
                              color: kTextBrown,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: kTextBrown,
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kMangoAccent.withValues(alpha: 0.1), style: BorderStyle.solid),
      ),
      child: Center(
        child: Text(
          message,
          style: TextStyle(color: kTextBrown.withValues(alpha: 0.5), fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
