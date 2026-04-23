import 'package:cook_meal/features/recipes/data/recipe_item.dart';

class RecipesModel {
  List<RecipeItem> items = [];

  RecipesModel() {
    items.add(
      RecipeItem(id: '1', name: 'Fried eggs')
        ..setImageAsset('assets/images/fried_eggs.jpg')
        ..addRequirement('Eggs', 2, true)
        ..addRequirement('Sunflower oil', 20, true)
        ..addRequirement('Salt', 3, false),
    );
    items.add(
      RecipeItem(id: '2', name: 'Yogurt cake')
        ..setImageAsset('assets/images/yogurt_cake.jpg')
        ..addRequirement('Flour', 60, true)
        ..addRequirement('Eggs', 3, true)
        ..addRequirement('Baking powder', 2, true)
        ..addRequirement('Baking soda', 2, true)
        ..addRequirement('Salt', 2, true)
        ..addRequirement('Sugar', 200, true)
        ..addRequirement('Vanilla extract', 5, true)
        ..addRequirement('Greek yogurt', 220, true)
        ..addRequirement('Extra virgin olive oil', 200, true),
    );
    items.add(
      RecipeItem(id: '3', name: 'Lemon drizzle cake')
        ..setImageAsset('assets/images/lemon_drizzle_cake.jpg')
        ..addRequirement('Butter', 225, true)
        ..addRequirement('Sugar', 225, true)
        ..addRequirement('Flour', 225, true)
        ..addRequirement('Eggs', 4, true)
        ..addRequirement('Lemon', 1, true),
    );
  }
}
