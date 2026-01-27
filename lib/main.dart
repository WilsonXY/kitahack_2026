import 'package:flutter/material.dart';
import 'package:kitahack_2026/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Backend Config ( Firebase )

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform
  // );

  // TODO : Wrap the widget with ProviderScope() Riverpod flutter package
  runApp(const App());
}
