import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_meal/core/layout/form/form_padding.dart';
import 'package:cook_meal/core/layout/main_loader.dart';
import 'package:cook_meal/features/fridge/data/fridge_item.dart';
import 'package:cook_meal/features/fridge/presentation/fridge_provider.dart';
import 'package:cook_meal/features/recipes/data/recipe_item.dart';
import 'package:cook_meal/features/recipes/presentation/recipes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Available'),
              Tab(text: 'All'),
            ],
          ),
          Expanded(
            child: FormPadding(
              child: TabBarView(children: [_AvailableRecipes(), _AllRecipes()]),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailableRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipesProvider = context.watch<RecipesProvider>();
    final fridgeProvider = context.watch<FridgeProvider>();

    return StreamBuilder<QuerySnapshot>(
      stream: fridgeProvider.getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoader();
        }

        final fridgeItems = snapshot.data!.docs.map((
          DocumentSnapshot document,
        ) {
          final data = document.data();
          if (data == null) {
            return FridgeItem(id: '', type: 'Unknown item', quantity: 1);
          }
          final map = data as Map<String, dynamic>;

          return FridgeItem.fromFirestone(document.id, map);
        }).toList();
        final availableList = recipesProvider.getAvailableItems(fridgeItems);

        if (availableList.isNotEmpty) {
          return _ReceiptsListView(
            items: recipesProvider.getAvailableItems(fridgeItems),
          );
        } else {
          return _NoReciptsPlaceHolder();
        }
      },
    );
  }
}

class _AllRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipesProvider = context.watch<RecipesProvider>();

    return _ReceiptsListView(items: recipesProvider.items);
  }
}

class _ReceiptsListView extends StatelessWidget {
  final List<RecipeItem> items;
  const _ReceiptsListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 3 / 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {},
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(item.imagePath, fit: BoxFit.cover),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 12,
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Positioned(
                  right: 16,
                  top: 12,
                  child: Text(
                    "●",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NoReciptsPlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.no_food, size: 48, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Nor recipts available',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 20),
          ),
          SizedBox(height: 4),
          Text(
            'Try adding more food to your fridge',
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
