import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/widgets/snapmango_drawer.dart';
import 'package:kitahack_2026/widgets/history_summary_item.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
      appBar: AppBar(
        title: const Text('SnapMango!'),
      ),
      drawer: const SnapMangoDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Material(
                    color: kMangoPrimary,
                    elevation: 7,
                    shape: const CircleBorder(side: BorderSide(color: kMangoAccent, width: 4)),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 120), () {
                          if (!context.mounted) return;
                          Navigator.pushNamed(context, '/snap');
                        });
                      },
                      splashColor: kMangoAccent.withValues(alpha: 0.5),
                      // highlightColor: Colors.transparent,
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: const Center(
                          child: Text(
                            'Snap!',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: kMangoBackground,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'History',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    child: const Text('See All', style: TextStyle(color: kMangoPrimary)),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const HistorySummaryItem();
                },
              ),
              const SizedBox(height: 30),
              // TODO: not sure if we want to implement this
              const Text('Daily Calorie Tips', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: kMangoAccent),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb, color: kMangoPrimary, size: 30),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        "Did you know? Mangos are rich in Vitamin C! Snap your snack to track your intake.",
                        style: TextStyle(color: kTextBrown, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // TODO: not sure if we want to implement this
              const Text('Your Weekly Summary', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPlaceholderGrey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    '[Weekly Summary Placeholder]',
                    style: TextStyle(color: kTextBrown.withValues(alpha: 0.5)),
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
}
