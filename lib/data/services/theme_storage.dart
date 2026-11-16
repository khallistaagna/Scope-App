import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Menyimpan pilihan tema (terang/gelap) pengguna.
class ThemeStorage {
  static const String _key = 'theme_mode';

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<ThemeMode> load() async {
  final saved = await _prefs.getString(_key);

  if (saved == null || saved == ThemeMode.system.name) {
    return ThemeMode.light;
  }

  return ThemeMode.values.firstWhere(
    (mode) => mode.name == saved,
    orElse: () => ThemeMode.light,
  );
}

  Future<void> save(ThemeMode mode) => _prefs.setString(_key, mode.name);
}
