import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/storage_service.dart';
import '../../utils/constant.dart';
import '../injector.dart';
import 'dark_theme.dart';
import 'i_theme.dart';
import 'light_theme.dart';

class ThemeManager {
  late ITheme currentTheme;

  final StorageService _storage = injector<StorageService>();

  late ThemeData theme;
  static late ThemeMode mode;

  Future<void> load() async {
    await _getPlatformTheme();
    initTheme();
    mode = currentTheme.mode;
    systemNavigationController();
  }

  void initTheme() {
    theme = currentTheme.themeData(getTextTheme(currentTheme.defaultTextColor));
    _setSystemStatusDefaultColor();
    mode = currentTheme.mode;
  }

  Future<void> _getPlatformTheme() async {
    bool? darkMode = await _storage.getBool(kThemeModeKey);
    if (darkMode != null) {
      currentTheme = darkMode ? DarkTheme() : LightTheme();
    } else {
      // final brightness = PlatformDispatcher.instance.platformBrightness;
      const brightness = Brightness.light;
      currentTheme = brightness == Brightness.dark ? DarkTheme() : LightTheme();
    }
  }

  Future<bool> saveTheme(ITheme newTheme) async {
    currentTheme = newTheme;
    return await _storage.saveValue(kThemeModeKey, newTheme.mode == ThemeMode.dark);
  }

  // static bool get isDark => mode == ThemeMode.dark;

  SystemUiOverlayStyle copySystemUiOverlayStyle({
    Brightness? statusBarBrightness,
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
    Color? systemNavigationBarColor,
    Color? systemNavigationBarDividerColor,
    Brightness? systemNavigationBarIconBrightness,
  }) {
    return SystemUiOverlayStyle(
      statusBarBrightness: statusBarBrightness ?? currentTheme.systemUiOverlayStyle.statusBarBrightness,
      statusBarColor: statusBarColor ?? currentTheme.systemUiOverlayStyle.statusBarColor,
      statusBarIconBrightness: statusBarIconBrightness ?? currentTheme.systemUiOverlayStyle.statusBarIconBrightness,
      systemNavigationBarColor: systemNavigationBarColor ?? currentTheme.systemUiOverlayStyle.systemNavigationBarColor,
      systemNavigationBarDividerColor:
          systemNavigationBarDividerColor ?? currentTheme.systemUiOverlayStyle.systemNavigationBarDividerColor,
      systemNavigationBarIconBrightness:
          systemNavigationBarIconBrightness ?? currentTheme.systemUiOverlayStyle.systemNavigationBarIconBrightness,
      systemNavigationBarContrastEnforced: true,
      systemStatusBarContrastEnforced: true,
    );
  }

  void _setSystemStatusDefaultColor() {
    SystemChrome.setSystemUIOverlayStyle(currentTheme.systemUiOverlayStyle);
  }

  void setPortraitMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void defaultOrientationMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void systemNavigationController({SystemUiMode? mode}) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  // static AppColors get colors => _instance!.currentTheme.themeData().extension<AppColors>()!;
  TextTheme getTextTheme(Color textColor) {
    return TextTheme(
      headlineSmall: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
        overflow: TextOverflow.visible,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        overflow: TextOverflow.visible,
      ),
      headlineLarge: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 28,
        overflow: TextOverflow.visible,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 16,
        overflow: TextOverflow.visible,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        overflow: TextOverflow.visible,
      ),
      bodySmall: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        overflow: TextOverflow.visible,
      ),
      labelLarge: TextStyle(
        color: textColor,
        fontSize: 12,
        overflow: TextOverflow.visible,
      ),
      labelMedium: TextStyle(
        color: textColor,
        fontSize: 10,
        overflow: TextOverflow.visible,
      ),
      labelSmall: TextStyle(
        color: textColor,
        fontSize: 8,
        overflow: TextOverflow.visible,
      ),
    );
  }

  static ThemeManager? _instance;
  ThemeManager._init();
  factory ThemeManager() => _instance ??= ThemeManager._init();
}
