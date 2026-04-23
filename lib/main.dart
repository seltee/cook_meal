import 'package:cook_meal/core/layout/main_screen.dart';
import 'package:cook_meal/core/layout/mobile_wrapper.dart';
import 'package:cook_meal/core/theme/themed_app.dart';
import 'package:cook_meal/features/auth/feature/auth_provider.dart';
import 'package:cook_meal/features/fridge/presentation/fridge_provider.dart';
import 'package:cook_meal/features/recipes/presentation/recipes_provider.dart';
import 'package:cook_meal/features/settings/presentation/settings_provider.dart';
import 'package:cook_meal/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider(prefs)),
        ChangeNotifierProvider(create: (_) => FridgeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RecipesProvider()),
      ],
      child: ThemedApp(child: MobileWrapper(child: MainScreen())),
    ),
  );
}
