import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_meal/core/layout/card_padding.dart';
import 'package:cook_meal/core/layout/column_button.dart';
import 'package:cook_meal/core/layout/column_padding.dart';
import 'package:cook_meal/core/layout/form/form_padding.dart';
import 'package:cook_meal/core/layout/main_loader.dart';
import 'package:cook_meal/features/fridge/data/fridge_item.dart';
import 'package:cook_meal/features/fridge/presentation/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onOpenFridge;

  const DashboardScreen({super.key, required this.onOpenFridge});

  @override
  Widget build(Object context) {
    return FormPadding(
      child: Column(
        children: [
          _Welcome(),
          ColumnPadding(),
          _FridgeStats(),
          SizedBox(height: 8),
          _ManageFridgeItems(onTap: onOpenFridge),
          SizedBox(height: 32),
          _WhatCanIMakeToday(),
        ],
      ),
    );
  }
}

class _Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Hi, ", style: Theme.of(context).textTheme.bodyMedium),
        Text("John", style: Theme.of(context).textTheme.bodyMedium),
        Text("!", style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _FridgeStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fridgeProvider = context.watch<FridgeProvider>();

    return StreamBuilder<QuerySnapshot>(
      stream: fridgeProvider.getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _Loader();
        }

        return _FridgeStatsCard(
          items: snapshot.data!.docs.map((DocumentSnapshot document) {
            final data = document.data();
            if (data == null) {
              return FridgeItem(id: '', type: 'Unknown item', quantity: 1);
            }
            final map = data as Map<String, dynamic>;

            return FridgeItem.fromFirestone(document.id, map);
          }).toList(),
        );
      },
    );
  }
}

class _FridgeStatsCard extends StatelessWidget {
  final List<FridgeItem> items;
  const _FridgeStatsCard({required this.items});

  @override
  Widget build(BuildContext context) {
    final fridgeProvider = context.watch<FridgeProvider>();

    Map<String, String> categories = <String, String>{};
    for (var item in items) {
      final category = fridgeProvider.getTypeCategory(item.type);
      categories[category] = category;
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Container(
          constraints: BoxConstraints(minHeight: 64),
          child: CardPadding(
            child: Center(
              child: items.isEmpty
                  ? Column(
                      children: [
                        Text(
                          'Fridge is empty',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Add your items!',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You have ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              ' ${items.length} ',
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.merge(TextStyle(fontSize: 20)),
                            ),
                            Text(
                              ' ${items.length == 1 ? 'item' : 'items'} in the fridge',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          categories.values.join(' ⚬ '),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ManageFridgeItems extends StatelessWidget {
  final VoidCallback onTap;
  const _ManageFridgeItems({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ColumnButton(
      onTap: onTap,
      child: Text(
        "Manage fridge",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _WhatCanIMakeToday extends StatelessWidget {
  const _WhatCanIMakeToday();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "What can I cook today?",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ColumnPadding(),
        Text("No receipts found", style: Theme.of(context).textTheme.bodyLarge),
        Text(
          "Try updating your fridge",
          style: Theme.of(context).textTheme.bodyMedium?.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
        ),
      ],
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(child: MainLoader()),
    );
  }
}
