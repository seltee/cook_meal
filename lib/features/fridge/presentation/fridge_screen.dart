import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_meal/core/layout/form/form_padding.dart';
import 'package:cook_meal/features/fridge/data/fridge_item.dart';
import 'package:cook_meal/features/fridge/presentation/fridge_item_card.dart';
import 'package:cook_meal/features/fridge/presentation/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class FridgeScreen extends StatelessWidget {
  const FridgeScreen({super.key});

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

        return snapshot.data!.docs.isEmpty
            ? _NoItemsPlaceHolder()
            : _ItemsList(
                items: snapshot.data!.docs.map((DocumentSnapshot document) {
                  final data = document.data();
                  if (data == null) {
                    return FridgeItem(
                      id: "",
                      type: "Unknown item",
                      quantity: 1,
                    );
                  }
                  final map = data as Map<String, dynamic>;

                  return FridgeItem.fromFirestone(document.id, map);
                }).toList(),
              );
      },
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: (Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: LoadingAnimationWidget.twoRotatingArc(
            color: Theme.of(context).hintColor,
            size: 40,
          ),
        )),
      ),
    );
  }
}

class _NoItemsPlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Your fridge is empty',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 20),
          ),
          SizedBox(height: 4),
          Text(
            'Add your first item',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemsList extends StatelessWidget {
  final List<FridgeItem> items;
  const _ItemsList({required this.items});

  @override
  Widget build(BuildContext context) {
    return FormPadding(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FridgeItemCard(item: items[index]);
        },
      ),
    );
  }
}
