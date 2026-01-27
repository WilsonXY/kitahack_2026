import 'package:flutter/material.dart';
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
      title: 'Strava but for Calory Tracker',
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.light,
      home: Scaffold(body: Center(child: Text("Text"))),
    );
  }
}