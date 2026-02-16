import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/widgets/social_icon.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: kPlaceholderGrey,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ]
              ),
              child: const Icon(Icons.fastfood, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text('Food Name Placeholder', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kMangoAccent.withValues(alpha: 0.5)),
                ),
                child: const SingleChildScrollView(
                  child: Text(
                    '(Gemini generated report goes here) \n\n'
                    'Calories: 350 kcal\n'
                    'Carbs: 45g\n'
                    'Protein: 12g\n'
                    'Fat: 10g\n\n'
                    '...',
                    style: TextStyle(fontSize: 16, color: kTextBrown, height: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showSharePopOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kMangoPrimary,
                      foregroundColor: kMangoBackground,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                    ),
                    icon: const Icon(Icons.share),
                    label: const Text('Share', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kMangoPrimary, width: 2),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: kMangoPrimary.withValues(alpha: 0.2),
                      highlightColor: kMangoPrimary.withValues(alpha: 0.1),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Saving to device..."),
                            backgroundColor: kMangoPrimary,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: const Center(child: Icon(Icons.download, color: kMangoPrimary, size: 28)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSharePopOut(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kMangoBackground,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 50, height: 6, decoration: BoxDecoration(color: kPlaceholderGrey, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              const Text('Share Result', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextBrown)),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kMangoPrimary, width: 2),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: kPlaceholderGrey),
                        SizedBox(height: 10),
                        Text('(Generated Report Image)', textAlign: TextAlign.center, style: TextStyle(color: kTextBrown, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialIcon(Icons.facebook, Colors.blue),
                  SocialIcon(Icons.alternate_email, Colors.black),
                  SocialIcon(Icons.message, Colors.green),
                  SocialIcon(Icons.more_horiz, kMangoPrimary),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
