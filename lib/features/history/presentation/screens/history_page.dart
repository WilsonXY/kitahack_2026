import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/core/theme/sizes.dart';
import 'package:kitahack_2026/features/history/presentation/widgets/history_summary_item.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History Page')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              HistorySummaryItem(),
              HistorySummaryItem(),
              HistorySummaryItem(),
              HistorySummaryItem(),
              HistorySummaryItem(),
            ],
          ),
        ),
      )
    );
  }
}
