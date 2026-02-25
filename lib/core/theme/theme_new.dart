import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff904d00),
      surfaceTint: Color(0xff904d00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffff8c00),
      onPrimaryContainer: Color(0xff623200),
      secondary: Color(0xff865224),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffdb881),
      onSecondaryContainer: Color(0xff78471a),
      tertiary: Color(0xff5c6300),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa5b200),
      onTertiaryContainer: Color(0xff3c4200),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff241912),
      onSurfaceVariant: Color(0xff564334),
      outline: Color(0xff897362),
      outlineVariant: Color(0xffddc1ae),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3a2e25),
      inversePrimary: Color(0xffffb77d),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff2f1500),
      primaryFixedDim: Color(0xffffb77d),
      onPrimaryFixedVariant: Color(0xff6e3900),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff2f1500),
      secondaryFixedDim: Color(0xfffdb881),
      onSecondaryFixedVariant: Color(0xff6a3b0f),
      tertiaryFixed: Color(0xffdeec4b),
      onTertiaryFixed: Color(0xff1a1d00),
      tertiaryFixedDim: Color(0xffc2d02e),
      onTertiaryFixedVariant: Color(0xff454b00),
      surfaceDim: Color(0xffead6c9),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e9),
      surfaceContainer: Color(0xffffeadd),
      surfaceContainerHigh: Color(0xfff9e4d7),
      surfaceContainerHighest: Color(0xfff3dfd1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff562b00),
      surfaceTint: Color(0xff904d00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa65900),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff552b00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff976131),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff343900),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6a7300),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff180f08),
      onSurfaceVariant: Color(0xff443325),
      outline: Color(0xff634e3f),
      outlineVariant: Color(0xff7f6958),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3a2e25),
      inversePrimary: Color(0xffffb77d),
      primaryFixed: Color(0xffa65900),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff824500),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff976131),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff7a491c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6a7300),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff525900),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6c3b6),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e9),
      surfaceContainer: Color(0xfff9e4d7),
      surfaceContainerHigh: Color(0xffedd9cc),
      surfaceContainerHighest: Color(0xffe2cec1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff472300),
      surfaceTint: Color(0xff904d00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff713b00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff472300),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6d3e11),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2b2f00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff474d00),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff39291b),
      outlineVariant: Color(0xff594537),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3a2e25),
      inversePrimary: Color(0xffffb77d),
      primaryFixed: Color(0xff713b00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff502800),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6d3e11),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff502800),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff474d00),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff313600),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc8b5a9),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffede3),
      surfaceContainer: Color(0xfff3dfd1),
      surfaceContainerHigh: Color(0xffe5d1c4),
      surfaceContainerHighest: Color(0xffd6c3b6),
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
      primaryContainer: Color(0xffff8c00),
      onPrimaryContainer: Color(0xff623200),
      secondary: Color(0xfffdb881),
      onSecondary: Color(0xff4d2600),
      secondaryContainer: Color(0xff6a3b0f),
      onSecondaryContainer: Color(0xffe9a771),
      tertiary: Color(0xffc2d02e),
      onTertiary: Color(0xff2f3300),
      tertiaryContainer: Color(0xffa5b200),
      onTertiaryContainer: Color(0xff3c4200),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1b110a),
      onSurface: Color(0xfff3dfd1),
      onSurfaceVariant: Color(0xffddc1ae),
      outline: Color(0xffa48c7a),
      outlineVariant: Color(0xff564334),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff3dfd1),
      inversePrimary: Color(0xff904d00),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff2f1500),
      primaryFixedDim: Color(0xffffb77d),
      onPrimaryFixedVariant: Color(0xff6e3900),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff2f1500),
      secondaryFixedDim: Color(0xfffdb881),
      onSecondaryFixedVariant: Color(0xff6a3b0f),
      tertiaryFixed: Color(0xffdeec4b),
      onTertiaryFixed: Color(0xff1a1d00),
      tertiaryFixedDim: Color(0xffc2d02e),
      onTertiaryFixedVariant: Color(0xff454b00),
      surfaceDim: Color(0xff1b110a),
      surfaceBright: Color(0xff43372e),
      surfaceContainerLowest: Color(0xff150c06),
      surfaceContainerLow: Color(0xff241912),
      surfaceContainer: Color(0xff281d15),
      surfaceContainerHigh: Color(0xff33281f),
      surfaceContainerHighest: Color(0xff3f3229),
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
      primaryContainer: Color(0xffff8c00),
      onPrimaryContainer: Color(0xff341800),
      secondary: Color(0xffffd4b4),
      onSecondary: Color(0xff3d1d00),
      secondaryContainer: Color(0xffc08351),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd8e645),
      onTertiary: Color(0xff242800),
      tertiaryContainer: Color(0xffa5b200),
      onTertiaryContainer: Color(0xff1e2100),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1b110a),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff4d7c3),
      outline: Color(0xffc7ad9a),
      outlineVariant: Color(0xffa48c7a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff3dfd1),
      inversePrimary: Color(0xff703a00),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff1f0c00),
      primaryFixedDim: Color(0xffffb77d),
      onPrimaryFixedVariant: Color(0xff562b00),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff1f0c00),
      secondaryFixedDim: Color(0xfffdb881),
      onSecondaryFixedVariant: Color(0xff552b00),
      tertiaryFixed: Color(0xffdeec4b),
      onTertiaryFixed: Color(0xff101300),
      tertiaryFixedDim: Color(0xffc2d02e),
      onTertiaryFixedVariant: Color(0xff343900),
      surfaceDim: Color(0xff1b110a),
      surfaceBright: Color(0xff4f4238),
      surfaceContainerLowest: Color(0xff0d0602),
      surfaceContainerLow: Color(0xff261b13),
      surfaceContainer: Color(0xff31261d),
      surfaceContainerHigh: Color(0xff3c3027),
      surfaceContainerHighest: Color(0xff483b32),
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
      primaryContainer: Color(0xffffb272),
      onPrimaryContainer: Color(0xff170700),
      secondary: Color(0xffffede1),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xfff8b47d),
      onSecondaryContainer: Color(0xff170700),
      tertiary: Color(0xffecfa57),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbecc2a),
      onTertiaryContainer: Color(0xff0b0c00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1b110a),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffede1),
      outlineVariant: Color(0xffd9bdaa),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff3dfd1),
      inversePrimary: Color(0xff703a00),
      primaryFixed: Color(0xffffdcc3),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb77d),
      onPrimaryFixedVariant: Color(0xff1f0c00),
      secondaryFixed: Color(0xffffdcc3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xfffdb881),
      onSecondaryFixedVariant: Color(0xff1f0c00),
      tertiaryFixed: Color(0xffdeec4b),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc2d02e),
      onTertiaryFixedVariant: Color(0xff101300),
      surfaceDim: Color(0xff1b110a),
      surfaceBright: Color(0xff5b4d43),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff281d15),
      surfaceContainer: Color(0xff3a2e25),
      surfaceContainerHigh: Color(0xff463930),
      surfaceContainerHighest: Color(0xff51443b),
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
