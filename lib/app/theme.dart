import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  ThemeData themeData = lighTheme;

  bool isDark = false;

  void toggleTheme() {
    isDark = themeMode == ThemeMode.dark ? false : true;
    themeMode = !isDark ? ThemeMode.light : ThemeMode.dark;
    themeData = !isDark ? lighTheme : darkTheme;
    notifyListeners();
  }

  static ThemeData get lighTheme => ThemeData(
    fontFamily: 'Inter',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF42B4CA),
      secondary: Color(0xFFD5E9ED),
      surface: Colors.white,
      onSurface: Color(0xFF414A4C), // Text color
      error: Color(0xFFEA7979),
      tertiary: Color(0xFFB5C4C7),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Color(0xFF42B4CA)),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF42B4CA),
      secondary: Color(0xFF2C3A3D),
      surface: Color(0xFF1E1E1E),
      onSurface: Color(0xFFE0E0E0), // Açık renkli metin
      error: Color(0xFFEA7979),
      tertiary: Color(0xFF4A5A5D),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Color(0xFF42B4CA)),
    ),
  );
}
