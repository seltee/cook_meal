import 'package:cook_meal/features/auth/data/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final AuthModel _model = AuthModel();
  final auth = FirebaseAuth.instance;

  AuthModel get model => _model;
  bool get isLoggedIn => model.user != null;

  AuthProvider() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("Logged in already");
      model.user = user;
      notifyListeners();
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error");
      print(e.toString());
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      model.user = user;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Error");
      print(e.toString());
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      model.user = user;
    }
    notifyListeners();
  }
}
