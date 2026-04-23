import 'package:cook_meal/features/fridge/data/fridge_item.dart';
import 'package:cook_meal/features/recipes/data/recipe_item.dart';
import 'package:cook_meal/features/recipes/data/recipes_model.dart';
import 'package:flutter/material.dart';

class RecipesProvider extends ChangeNotifier {
  final RecipesModel _model = RecipesModel();

  RecipesModel get model => _model;
  List<RecipeItem> get items => model.items;

  List<RecipeItem> getAvailableItems(List<FridgeItem> fridgeItems) {
    return [];
    return model.items;
  }
}
