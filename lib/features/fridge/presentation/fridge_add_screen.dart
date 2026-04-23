import 'package:cook_meal/core/layout/card_padding.dart';
import 'package:cook_meal/core/layout/form/form_action_button.dart';
import 'package:cook_meal/core/layout/form/form_padding.dart';
import 'package:cook_meal/core/layout/form/form_quantity.dart';
import 'package:cook_meal/core/layout/mobile_wrapper.dart';
import 'package:cook_meal/features/fridge/data/fridge_type.dart';
import 'package:cook_meal/features/fridge/presentation/fridge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FridgeAddScreen extends StatelessWidget {
  const FridgeAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Item'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: FormPadding(child: const _ItemsList()),
      ),
    );
  }
}

class _ItemsList extends StatefulWidget {
  const _ItemsList();

  @override
  State<_ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<_ItemsList> {
  final _formKey = GlobalKey<FormState>();
  int selected = -1;
  int quantity = 1;

  void saveItem(FridgeProvider fridgeProvider) {
    if (_formKey.currentState!.validate() && selected >= 0) {
      fridgeProvider.addItem(fridgeProvider.types[selected].name, quantity);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Item added!')));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fridgeProvider = context.watch<FridgeProvider>();

    return Form(
      key: _formKey,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
        itemCount: fridgeProvider.types.length,
        itemBuilder: (context, index) {
          return _ItemType(
            type: fridgeProvider.types[index],
            selected: selected == index,
            quantity: quantity,
            setQuantity: (int newQuantity) => setState(() {
              quantity = newQuantity;
            }),
            onTap: () => {
              setState(() {
                selected = index;
              }),
            },
            onAddItem: () => saveItem(fridgeProvider),
          );
        },
      ),
    );
  }
}

class _ItemType extends StatelessWidget {
  final FridgeType type;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onAddItem;
  final int quantity;
  final Function setQuantity;

  const _ItemType({
    required this.type,
    required this.selected,
    required this.onTap,
    required this.onAddItem,
    required this.quantity,
    required this.setQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: selected ? null : onTap,
          child: CardPadding(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: Column(
                children: [
                  Text(type.name, style: Theme.of(context).textTheme.bodyLarge),
                  if (selected) ...[
                    FormQuantity(
                      quantity: quantity,
                      setQuantity: setQuantity,
                      singular: type.singular,
                      multiple: type.multiple,
                      step: type.quantityStep,
                    ),
                    FormActionButton(title: "Add item", onPress: onAddItem),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
