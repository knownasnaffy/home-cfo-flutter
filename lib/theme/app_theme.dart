import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryContainer = Color(0xFF131b2e);
  static const Color onSecondary = Color(0xFFffffff);
  static const Color onSecondaryContainer = Color(0xFF237157);
  static const Color onError = Color(0xFFffffff);
  static const Color primaryFixed = Color(0xFFdae2fd);
  static const Color inverseSurface = Color(0xFF2c3134);
  static const Color onTertiary = Color(0xFFffffff);
  static const Color onErrorContainer = Color(0xFF93000a);
  static const Color primaryFixedDim = Color(0xFFbec6e0);
  static const Color onPrimaryFixed = Color(0xFF131b2e);
  static const Color onSecondaryFixed = Color(0xFF002116);
  static const Color surfaceVariant = Color(0xFFdfe3e7);
  static const Color background = Color(0xFFf6fafe);
  static const Color onTertiaryContainer = Color(0xFF76859b);
  static const Color surfaceDim = Color(0xFFd6dade);
  static const Color surfaceContainerHigh = Color(0xFFe4e9ed);
  static const Color secondaryContainer = Color(0xFFa6f2d1);
  static const Color surfaceBright = Color(0xFFf6fafe);
  static const Color tertiaryFixed = Color(0xFFd5e3fd);
  static const Color surfaceContainerLowest = Color(0xFFffffff);
  static const Color onTertiaryFixedVariant = Color(0xFF3a485c);
  static const Color inverseOnSurface = Color(0xFFedf1f5);
  static const Color onPrimaryFixedVariant = Color(0xFF3f465c);
  static const Color outline = Color(0xFF76777d);
  static const Color surfaceContainerLow = Color(0xFFf0f4f8);
  static const Color onSurface = Color(0xFF171c1f);
  static const Color onPrimaryContainer = Color(0xFF7c839b);
  static const Color outlineVariant = Color(0xFFc6c6cd);
  static const Color error = Color(0xFFba1a1a);
  static const Color errorContainer = Color(0xFFffdad6);
  static const Color onTertiaryFixed = Color(0xFF0d1c2f);
  static const Color onSecondaryFixedVariant = Color(0xFF00513b);
  static const Color secondaryFixedDim = Color(0xFF8bd6b6);
  static const Color onPrimary = Color(0xFFffffff);
  static const Color onBackground = Color(0xFF171c1f);
  static const Color primary = Color(0xFF000000);
  static const Color surfaceTint = Color(0xFF565e74);
  static const Color tertiaryContainer = Color(0xFF0d1c2f);
  static const Color secondaryFixed = Color(0xFFa6f2d1);
  static const Color onSurfaceVariant = Color(0xFF45464d);
  static const Color tertiaryFixedDim = Color(0xFFb9c7e0);
  static const Color inversePrimary = Color(0xFFbec6e0);
  static const Color surfaceContainerHighest = Color(0xFFdfe3e7);
  static const Color secondary = Color(0xFF1b6b51);
  static const Color surfaceContainer = Color(0xFFeaeef2);
  static const Color surface = Color(0xFFf6fafe);
  static const Color tertiary = Color(0xFF000000);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: inverseSurface,
        onInverseSurface: inverseOnSurface,
        inversePrimary: inversePrimary,
        surfaceTint: surfaceTint,
      ),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.publicSansTextTheme().copyWith(
        displayLarge: GoogleFonts.publicSans(
          fontSize: 32,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: GoogleFonts.publicSans(
          fontSize: 24,
          height: 1.3,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.publicSans(
          fontSize: 20,
          height: 1.4,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.publicSans(
          fontSize: 18,
          height: 1.6,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.publicSans(
          fontSize: 16,
          height: 1.6,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.publicSans(
          fontSize: 14,
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: GoogleFonts.publicSans(
          fontSize: 14,
          height: 1.2,
          letterSpacing: 0.02,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: GoogleFonts.publicSans(
          fontSize: 12,
          height: 1.2,
          letterSpacing: 0.04,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceContainerLowest,
        foregroundColor: onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceContainerLowest,
        selectedItemColor: onSurface,
        unselectedItemColor: outline,
        elevation: 8,
      ),
    );
  }
}
