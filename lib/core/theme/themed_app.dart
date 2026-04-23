import 'package:cook_meal/core/theme/theme.dart';
import 'package:cook_meal/features/settings/presentation/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemedApp extends StatelessWidget {
  final Widget child;

  const ThemedApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return MaterialApp(
      title: "Cook Meal",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: settingsProvider.themeMode,
      home: child,
    );
  }
}
