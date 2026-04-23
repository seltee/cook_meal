class RecipeItem {
  final String id;
  final String name;
  String imagePath = 'assets/images/fried_eggs.jpg';
  List<RecipeItemRequirement> requirements = [];

  RecipeItem({required this.name, required this.id});

  void addRequirement(String type, int quantity, bool mandatory) {
    requirements.add(
      RecipeItemRequirement(
        quantity: quantity,
        type: type,
        mandatory: mandatory,
      ),
    );
  }

  void setImageAsset(String path) {
    imagePath = path;
  }

  /*
  factory RecipeItem.fromFirestone(
    String firebaseId,
    Map<String, dynamic> item,
  ) {
    
    print("From");
    for (final val in item.keys) {
      print(val);
    }
    
    //final type = item['type'] as String;
    // final amount = item['amount'] as int;

    // return FridgeItem(id: firebaseId, type: type, quantity: amount);
  }
  */
}

class RecipeItemRequirement {
  final String type;
  final int quantity;
  final bool mandatory;

  RecipeItemRequirement({
    required this.type,
    required this.quantity,
    required this.mandatory,
  });
}
