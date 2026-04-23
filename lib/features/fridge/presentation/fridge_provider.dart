import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_meal/features/fridge/data/fridge_model.dart';
import 'package:cook_meal/features/fridge/data/fridge_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FridgeProvider extends ChangeNotifier {
  final FridgeModel _model = FridgeModel();

  FridgeModel get model => _model;
  List<FridgeType> get types => model.types;

  String getTypeCategory(String checkType) {
    for (var type in model.types) {
      if (type.name == checkType) {
        return type.category;
      }
    }
    return 'Unknown';
  }

  Future<void> addItem(String type, int amount) async {
    final user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('items')
        .add({
          'type': type,
          'amount': amount,
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  Stream<QuerySnapshot> getItems() {
    final user = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('items')
        .snapshots();
  }

  Future<void> removeItem(String id) async {
    final user = FirebaseAuth.instance.currentUser!;

    if (id.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .doc(id)
          .delete();
    }
  }
}
