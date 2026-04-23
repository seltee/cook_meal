import 'package:cook_meal/features/auth/feature/login_screen.dart';
import 'package:cook_meal/features/auth/feature/reg_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentIndex = 0;

  List<Widget> get _screens => [
    LoginScreen(
      openRegistration: () => setState(() {
        _currentIndex = 1;
      }),
    ),
    RegScreen(
      openAutentication: () => setState(() {
        _currentIndex = 0;
      }),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
      body: IndexedStack(index: _currentIndex, children: _screens),
    );
  }
}
