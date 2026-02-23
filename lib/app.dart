import 'package:flutter/material.dart';
import 'package:kitahack_2026/core/navigation/main_wrapper.dart';
import 'package:kitahack_2026/features/auth/presentation/screens/auth_gate.dart';
import 'package:kitahack_2026/features/nutrition/presentation/screen/result_page.dart';
import 'package:kitahack_2026/features/nutrition/presentation/screen/snap_page.dart';
import 'package:kitahack_2026/features/history/presentation/screens/history_page.dart';
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
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      home: const AuthGate(),
      routes: {
        '/snap': (context) => const SnapPage(),
        '/history': (context) => const HistoryPage(),
        '/result': (context) => const ResultPage(),
        '/main' : (context) => const MainWrapper()
      },
    );
  }
}