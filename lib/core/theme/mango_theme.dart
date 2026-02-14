import 'package:flutter/material.dart';

// Mango app theme and colors
const Color kMangoPrimary = Color(0xFFFF8C00);
const Color kMangoAccent = Color(0xFFFFB300);
const Color kMangoBackground = Color(0xFFFFF3E0);
const Color kTextBrown = Color(0xFF4E342E);
const Color kPlaceholderGrey = Color(0xFFBDBDBD);

ThemeData mangoTheme() {
  return ThemeData(
    primaryColor: kMangoPrimary,
    scaffoldBackgroundColor: kMangoBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: kMangoPrimary,
      foregroundColor: kMangoBackground,
      elevation: 4,
      shadowColor: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: kTextBrown),
      titleLarge: TextStyle(color: kTextBrown, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: kMangoAccent,
    ),
    useMaterial3: true,
  );
}
