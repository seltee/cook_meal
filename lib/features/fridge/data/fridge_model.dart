import 'package:cook_meal/features/fridge/data/fridge_item.dart';
import 'package:cook_meal/features/fridge/data/fridge_type.dart';
import 'package:uuid/uuid.dart';

class FridgeModel {
  late final uuid = Uuid();

  List<FridgeItem> items = [];
  List<FridgeType> types = [
    FridgeType(
      name: 'Eggs',
      singular: 'pc',
      multiple: 'pcs',
      quantityStep: 1,
      category: 'Dairy & Eggs',
    ),
    FridgeType(
      name: 'Butter',
      singular: 'gr',
      multiple: 'grs',
      quantityStep: 10,
      category: 'Dairy & Eggs',
    ),
    FridgeType(
      name: 'Lemon',
      singular: 'pc',
      multiple: 'pcs',
      quantityStep: 1,
      category: 'Fruits',
    ),
    FridgeType(
      name: 'Sunflower oil',
      singular: 'ml',
      multiple: 'mls',
      quantityStep: 100,
      category: 'Fats, Oils, & Sauces',
    ),
    FridgeType(
      name: 'Salt',
      singular: 'gr',
      multiple: 'grs',
      quantityStep: 10,
      category: 'Condiments & Spices',
    ),
    FridgeType(
      name: 'Sugar',
      singular: 'gr',
      multiple: 'grs',
      quantityStep: 10,
      category: 'Condiments & Spices',
    ),
    FridgeType(
      name: 'Flour',
      singular: 'gr',
      multiple: 'grs',
      quantityStep: 10,
      category: 'Condiments & Spices',
    ),
    FridgeType(
      name: 'Baking powder',
      singular: 'gr',
      multiple: 'grs',
      quantityStep: 5,
      category: 'Condiments & Spices',
    ),
    FridgeType(
      name: 'Baking soda',
      singular: 'gr',
      multiple: 'grs',
      quantityStep: 5,
      category: 'Condiments & Spices',
    ),
    FridgeType(
      name: 'Vanilla extract',
      singular: 'gr',
      multiple: 'grs',
      quantityStep: 5,
      category: 'Condiments & Spices',
    ),
    FridgeType(
      name: 'Greek yogurt',
      singular: 'ml',
      multiple: 'mls',
      quantityStep: 50,
      category: 'Dairy & Eggs',
    ),
    FridgeType(
      name: 'Extra virgin olive oil',
      singular: 'ml',
      multiple: 'mls',
      quantityStep: 100,
      category: 'Fats, Oils, & Sauces',
    ),
  ];
}

/*
Fruits: Fresh, frozen, canned, and dried fruits (e.g., apples, berries, citrus).
Vegetables: Leafy greens, root vegetables, cruciferous vegetables, and tubers.
Grains & Cereals: Bread, pasta, rice, oats, tortillas, and quinoa.
Dairy & Eggs: Milk, cheese, yogurt, butter, and cream.
Meat & Poultry: Beef, chicken, pork, lamb, and processed meats (bacon, sausage).
Seafood: Fish (salmon, tuna), shellfish (shrimp, crab).
Legumes, Nuts, & Seeds: Beans, lentils, chickpeas, almonds, walnuts, chia seeds.
Beverages: Water, juice, tea, coffee, soda, milk alternatives.
Fats, Oils, & Sauces: Olive oil, coconut oil, salad dressings, soy sauce, mayonnaise.
Baked Products: Bread, bagels, cookies, cakes, pastries.
Condiments & Spices: Ketchup, mustard, herbs, salt, pepper.
Canned & Pantry Goods: Soups, canned vegetables, pasta sauce, peanut butter.
Frozen Foods: Prepared meals, frozen veggies, ice cream. 
*/
