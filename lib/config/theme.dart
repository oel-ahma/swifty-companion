import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const primaryDarkGray = Color(0x1AFFFFFF);
  static const accentBlue = Color(0xFF2196F3);
  static const textWhite = Colors.white;

  // Create the theme data
  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: primaryDarkGray,

        // Primary and accent colors
        primaryColor: primaryDarkGray,
        colorScheme: const ColorScheme.dark(
          primary: primaryDarkGray,
          secondary: accentBlue,
          surface: primaryDarkGray,
          // background: primaryDarkGray,
          // onBackground: textWhite,
          onSurface: textWhite,
          onPrimary: textWhite,
          onSecondary: textWhite,
        ),

        // Text theme to make all text white by default
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: textWhite),
          bodyMedium: TextStyle(color: textWhite),
          bodySmall: TextStyle(color: textWhite),
          titleLarge: TextStyle(color: textWhite),
          titleMedium: TextStyle(color: textWhite),
          titleSmall: TextStyle(color: textWhite),
          displayLarge: TextStyle(color: textWhite),
          displayMedium: TextStyle(color: textWhite),
          displaySmall: TextStyle(color: textWhite),
          headlineLarge: TextStyle(color: textWhite),
          headlineMedium: TextStyle(color: textWhite),
          headlineSmall: TextStyle(color: textWhite),
          labelLarge: TextStyle(color: textWhite),
          labelMedium: TextStyle(color: textWhite),
          labelSmall: TextStyle(color: textWhite),
        ),

        // AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryDarkGray,
          foregroundColor: textWhite,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: primaryDarkGray, // Match status bar
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          centerTitle: true, // Optional: centers the title
          shadowColor: Colors.transparent,
        ),

        // Progress indicator theme (for loading circles)
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: accentBlue, // This will make CircularProgressIndicator blue
        ),

        // Input decoration theme (for text fields)
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: textWhite),
          hintStyle: TextStyle(color: textWhite.withOpacity(0.7)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textWhite.withOpacity(0.5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: textWhite),
          ),
        ),

        // Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: textWhite,
            backgroundColor: accentBlue,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: textWhite,
          ),
        ),
      );
}
