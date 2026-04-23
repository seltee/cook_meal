import 'package:cook_meal/features/auth/feature/auth_provider.dart';
import 'package:cook_meal/features/auth/feature/auth_screen.dart';
import 'package:cook_meal/features/dashboard/presentation/dashboard_screen.dart';
import 'package:cook_meal/features/fridge/presentation/fridge_add_screen.dart';
import 'package:cook_meal/features/fridge/presentation/fridge_screen.dart';
import 'package:cook_meal/features/recipes/presentation/recipes_screen.dart';
import 'package:cook_meal/features/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> get _screens => [
    DashboardScreen(onOpenFridge: () => setState(() => _currentIndex = 1)),
    const FridgeScreen(),
    const RecipesScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (!authProvider.isLoggedIn) {
      return AuthScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Cook Meal',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.merge(TextStyle(fontSize: 24)),
          ),
        ),
      ),
      body: IndexedStack(
        // This keeps state when switching tabs
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: _currentIndex <= 1
          ? FloatingActionButton.small(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FridgeAddScreen(),
                  ),
                );
              },
              child: SizedBox(
                width: 20,
                height: 20,
                child: const Icon(Icons.add, size: 20),
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Symbols.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.inventory, size: 28),
            label: 'Fridge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.receipt, size: 28),
            label: 'Receipts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.settings, size: 28),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
