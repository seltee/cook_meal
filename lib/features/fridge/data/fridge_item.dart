class FridgeItem {
  final String id;
  final String type;
  final int quantity;
  FridgeItem({required this.id, required this.type, required this.quantity});

  factory FridgeItem.fromFirestone(
    String firebaseId,
    Map<String, dynamic> item,
  ) {
    /*
    print("From");
    for (final val in item.keys) {
      print(val);
    }
    */
    final type = item['type'] as String;
    final amount = item['amount'] as int;

    return FridgeItem(id: firebaseId, type: type, quantity: amount);
  }
}
