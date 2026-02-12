import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';


// TODO: to be replaced?
class HistorySummaryItem extends StatelessWidget {
  const HistorySummaryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          height: 100,
          decoration: BoxDecoration(
            color: kPlaceholderGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: Colors.white.withValues(alpha: .3),
            onTap: () {
              Future.delayed(const Duration(milliseconds: 80), () {
                if (!context.mounted) return;
                Navigator.pushNamed(context, '/result');
              });
            },
            child: const Center(),
          ),
        ),
      ),
    );
  }
}
