import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff88511e),
      surfaceTint: Color(0xff88511e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdcc3),
      onPrimaryContainer: Color(0xff6c3a07),
      secondary: Color(0xff745944),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdcc3),
      onSecondaryContainer: Color(0xff5a422e),
      tertiary: Color(0xff5c6237),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe1e7b0),
      onTertiaryContainer: Color(0xff454a21),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff221a14),
      onSurfaceVariant: Color(0xff51443b),
      outline: Color(0xff847469),
      outlineVariant: Color(0xffd6c3b6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f28),
      inversePrimary: Color(0xffffb77d),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff2f1500),
      primaryFixedDim: Color(0xffffb77d),
      onPrimaryFixedVariant: Color(0xff6c3a07),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff2a1707),
      secondaryFixedDim: Color(0xffe3c0a6),
      onSecondaryFixedVariant: Color(0xff5a422e),
      tertiaryFixed: Color(0xffe1e7b0),
      onTertiaryFixed: Color(0xff191e00),
      tertiaryFixedDim: Color(0xffc5cb96),
      onTertiaryFixedVariant: Color(0xff454a21),
      surfaceDim: Color(0xffe7d7cd),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e9),
      surfaceContainer: Color(0xfffbebe1),
      surfaceContainerHigh: Color(0xfff5e5db),
      surfaceContainerHighest: Color(0xffefe0d6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff562b00),
      surfaceTint: Color(0xff88511e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9a5f2b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff48311f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff846752),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff343912),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6b7144),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff17100a),
      onSurfaceVariant: Color(0xff40342b),
      outline: Color(0xff5e5046),
      outlineVariant: Color(0xff796a60),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f28),
      inversePrimary: Color(0xffffb77d),
      primaryFixed: Color(0xff9a5f2b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff7d4815),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff846752),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6a4f3b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6b7144),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff53582e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd3c4ba),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e9),
      surfaceContainer: Color(0xfff5e5db),
      surfaceContainerHigh: Color(0xffeadad0),
      surfaceContainerHighest: Color(0xffdecfc5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff472300),
      surfaceTint: Color(0xff88511e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6f3c09),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3d2716),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5d4430),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2a2f09),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff474c23),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff352a21),
      outlineVariant: Color(0xff54473d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f28),
      inversePrimary: Color(0xffffb77d),
      primaryFixed: Color(0xff6f3c09),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff502800),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5d4430),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff442e1c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff474c23),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff30350f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4b6ad),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffeeee4),
      surfaceContainer: Color(0xffefe0d6),
      surfaceContainerHigh: Color(0xffe1d2c8),
      surfaceContainerHighest: Color(0xffd3c4ba),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb77d),
      surfaceTint: Color(0xffffb77d),
      onPrimary: Color(0xff4d2600),
      primaryContainer: Color(0xff6c3a07),
      onPrimaryContainer: Color(0xffffdcc3),
      secondary: Color(0xffe3c0a6),
      onSecondary: Color(0xff422c1a),
      secondaryContainer: Color(0xff5a422e),
      onSecondaryContainer: Color(0xffffdcc3),
      tertiary: Color(0xffc5cb96),
      onTertiary: Color(0xff2e330d),
      tertiaryContainer: Color(0xff454a21),
      onTertiaryContainer: Color(0xffe1e7b0),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff19120c),
      onSurface: Color(0xffefe0d6),
      onSurfaceVariant: Color(0xffd6c3b6),
      outline: Color(0xff9e8e82),
      outlineVariant: Color(0xff51443b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefe0d6),
      inversePrimary: Color(0xff88511e),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff2f1500),
      primaryFixedDim: Color(0xffffb77d),
      onPrimaryFixedVariant: Color(0xff6c3a07),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff2a1707),
      secondaryFixedDim: Color(0xffe3c0a6),
      onSecondaryFixedVariant: Color(0xff5a422e),
      tertiaryFixed: Color(0xffe1e7b0),
      onTertiaryFixed: Color(0xff191e00),
      tertiaryFixedDim: Color(0xffc5cb96),
      onTertiaryFixedVariant: Color(0xff454a21),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff413731),
      surfaceContainerLowest: Color(0xff140d08),
      surfaceContainerLow: Color(0xff221a14),
      surfaceContainer: Color(0xff261e18),
      surfaceContainerHigh: Color(0xff312822),
      surfaceContainerHighest: Color(0xff3c332c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd4b4),
      surfaceTint: Color(0xffffb77d),
      onPrimary: Color(0xff3d1d00),
      primaryContainer: Color(0xffc3824b),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffad5bb),
      onSecondary: Color(0xff352110),
      secondaryContainer: Color(0xffaa8b73),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdbe1ab),
      onTertiary: Color(0xff232804),
      tertiaryContainer: Color(0xff8f9564),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff19120c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffedd9cc),
      outline: Color(0xffc1aea2),
      outlineVariant: Color(0xff9e8d82),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefe0d6),
      inversePrimary: Color(0xff6d3b08),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff1f0c00),
      primaryFixedDim: Color(0xffffb77d),
      onPrimaryFixedVariant: Color(0xff562b00),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff1e0d01),
      secondaryFixedDim: Color(0xffe3c0a6),
      onSecondaryFixedVariant: Color(0xff48311f),
      tertiaryFixed: Color(0xffe1e7b0),
      onTertiaryFixed: Color(0xff101300),
      tertiaryFixedDim: Color(0xffc5cb96),
      onTertiaryFixedVariant: Color(0xff343912),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff4d433c),
      surfaceContainerLowest: Color(0xff0c0603),
      surfaceContainerLow: Color(0xff241c16),
      surfaceContainer: Color(0xff2f2620),
      surfaceContainerHigh: Color(0xff3a312a),
      surfaceContainerHighest: Color(0xff453c35),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffede1),
      surfaceTint: Color(0xffffb77d),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xfffcb377),
      onPrimaryContainer: Color(0xff170700),
      secondary: Color(0xffffede1),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffdfbca2),
      onSecondaryContainer: Color(0xff170700),
      tertiary: Color(0xffeff5bd),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc1c793),
      onTertiaryContainer: Color(0xff0a0d00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff19120c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffede1),
      outlineVariant: Color(0xffd2bfb3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefe0d6),
      inversePrimary: Color(0xff6d3b08),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb77d),
      onPrimaryFixedVariant: Color(0xff1f0c00),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe3c0a6),
      onSecondaryFixedVariant: Color(0xff1e0d01),
      tertiaryFixed: Color(0xffe1e7b0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc5cb96),
      onTertiaryFixedVariant: Color(0xff101300),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff594e47),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff261e18),
      surfaceContainer: Color(0xff382f28),
      surfaceContainerHigh: Color(0xff433a33),
      surfaceContainerHighest: Color(0xff4f453e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
