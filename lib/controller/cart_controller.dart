import 'package:get/get.dart';

import 'catalog_model.dart';

class CartController extends GetxController {
  final items = <Item>[].obs;

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void add(Item item) {
    items.add(item);
  }

  void remove(Item item) {
    items.remove(item);
    update();
  }

  void clearList() {
    items.clear();
    update();
  }
}
