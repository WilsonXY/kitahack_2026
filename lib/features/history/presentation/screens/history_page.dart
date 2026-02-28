import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/core/theme/sizes.dart';
import 'package:kitahack_2026/features/history/presentation/widgets/history_summary_item.dart';
import 'package:kitahack_2026/features/nutrition/data/food_provider.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition History'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: kTextBrown,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ref.watch(foodHistoryProvider).when(
              data: (foods) {
                if (foods.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history_toggle_off, size: 80, color: kTextBrown.withValues(alpha: 0.3)),
                        const SizedBox(height: 16),
                        const Text(
                          "No food logged yet!",
                          style: TextStyle(fontSize: 18, color: kTextBrown, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Your analyzed meals will appear here.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  color: kMangoPrimary,
                  onRefresh: () async => ref.refresh(foodHistoryProvider),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: foods.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final food = foods[index];
                      return HistorySummaryItem(foodModel: food);
                    },
                  ),
                );
              },
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 60, color: Colors.red),
                    const SizedBox(height: 16),
                    Text("Error loading history: $error"),
                    TextButton(
                      onPressed: () => ref.refresh(foodHistoryProvider),
                      child: const Text("Retry"),
                    )
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator(color: kMangoPrimary)),
            ),
      ),
    );
  }
}
