import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History Page')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            color: kMangoBackground,
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: kMangoAccent, width: 1)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              splashColor: kMangoPrimary.withValues(alpha: 0.2),
              onTap: () {
                Future.delayed(const Duration(milliseconds: 100), () {
                  if (!context.mounted) return;
                  Navigator.pushNamed(context, '/result');
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(width: 80, height: 80, decoration: BoxDecoration(color: kPlaceholderGrey, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.image, color: Colors.white)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Mango Salad', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 8),
                          Text('(brief explanation...)', style: TextStyle(color: kTextBrown)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: kMangoPrimary)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
