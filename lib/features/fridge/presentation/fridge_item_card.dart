import 'package:cook_meal/core/layout/card_padding.dart';
import 'package:cook_meal/features/fridge/data/fridge_item.dart';
import 'package:cook_meal/features/fridge/presentation/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FridgeItemCard extends StatelessWidget {
  final FridgeItem item;
  const FridgeItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final fridgeProvider = context.watch<FridgeProvider>();

    return SizedBox(
      width: double.infinity,
      child: Dismissible(
        onDismissed: (direction) => fridgeProvider.removeItem(item.id),
        key: Key(item.id),
        child: Card(
          child: InkWell(
            child: CardPadding(
              child: Text(
                item.type,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
