import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/core/theme/sizes.dart';
import 'package:kitahack_2026/features/history/presentation/widgets/history_summary_item.dart';
import 'package:kitahack_2026/features/nutrition/data/food_provider.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('History Page')),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: ref
            .watch(foodHistoryProvider)
            .when(
              data: (foods) {
                if (foods.isEmpty) {
                  return const Center(child: Text("No food logged yet!"));
                }
                return RefreshIndicator(
                  child: ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      final food = foods[index];
                      return HistorySummaryItem(foodModel: food);
                    },
                  ),
                  onRefresh: () async => ref.refresh(foodHistoryProvider),
                );
              },
              error: (error, stack) =>
                  Center(child: Text("Error loading foods ($error)")),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
      ),
    );
  }
}
