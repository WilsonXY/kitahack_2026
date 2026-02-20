import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/theme/mango_theme.dart';
import 'package:kitahack_2026/features/auth/presentation/auth_gate.dart';
import 'package:kitahack_2026/features/nutrition/presentation/snap_page.dart';
import 'package:kitahack_2026/features/nutrition/presentation/result_page.dart';
import 'package:kitahack_2026/pages/history_page.dart';
import 'package:kitahack_2026/core/theme/theme.dart';
import 'package:kitahack_2026/core/theme/util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      // To modify theme, head to https://material-foundation.github.io/material-theme-builder/ 
      title: 'SnapMango',
      debugShowCheckedModeBanner: false,
      theme: theme.light(), // theme.light(), <-- i changed this temporary -- wilson
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      home: const AuthGate(),
      routes: {
        '/snap': (context) => const SnapPage(),
        '/history': (context) => const HistoryPage(),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}