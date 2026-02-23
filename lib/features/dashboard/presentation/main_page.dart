import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/features/dashboard/presentation/calorie_tips.dart';
import 'package:kitahack_2026/widgets/history_summary_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
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
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
      appBar: AppBar(
        title: const Text('SnapMango!'),
      ),
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
                  child: ScaleTransition(
                    scale: _buttonScale,
                    child: Material(
                      color: kMangoPrimary,
                      elevation: 7,
                      shape: const CircleBorder(side: BorderSide(color: kMangoAccent, width: 4)),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
              const Text('Daily Calorie Tips', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: _refreshTip,
                child: Container(
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
                      Expanded(
                        child: ClipRect(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              final inAnimation = Tween<Offset>(
                                      begin: const Offset(1.0, 0.0), end: Offset.zero)
                                  .animate(animation);
                              final outAnimation = Tween<Offset>(
                                      begin: const Offset(-1.0, 0.0), end: Offset.zero)
                                  .animate(animation);
                              if (child.key == ValueKey<String>(_currentTip)) {
                                return SlideTransition(
                                  position: inAnimation,
                                  child: child,
                                );
                              } else {
                                return SlideTransition(
                                  position: outAnimation,
                                  child: child,
                                );
                              }
                            },
                            child: Text(
                              _currentTip,
                              key: ValueKey<String>(_currentTip),
                              style: const TextStyle(color: kTextBrown, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
