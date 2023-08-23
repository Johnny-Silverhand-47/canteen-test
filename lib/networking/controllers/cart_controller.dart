import 'package:canteen_test/networking/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_flush_bar.dart';

class CartController extends GetxController {
  CartController({required this.context});
  final BuildContext context;
  final CartService _cartService = Get.put(CartService());

  String _message = '';
  String get message => _message;

  final Rx<Status> _status = Status.initialized.obs;
  Rx<Status> get status => _status;

  RxMap<String, dynamic> items = <String, dynamic>{}.obs;

  RxDouble total = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(_status, (value) {
      if (value == Status.error) {
        AppMessenger.of(context).error(message);
        _status.value = Status.initialized;
      }
      if (value == Status.success) {
        AppMessenger.of(context)
            .success('${items.length} items added to cart!');
        items.clear();//resetting items map and total amount
        total = 0.0.obs;
        _status.value = Status.initialized;
      }
    });
  }

  void _updateList(int key, int value) {
    if (value == 0) {
      items.remove(key.toString());
    } else {
      items[key.toString()] = value;
    }
  }

  void incrementItem(int key,double price) {
    int qunatity = items[key.toString()]??0;
    if (qunatity <= 10) {//restricting count at 10
      qunatity++;
      _updateList(key, qunatity);
      _updateTotal(price);
    } else {
      AppMessenger.of(context).info('Allowed maximum quantity is 10!');
    }
  }

  void decrementItem(int key,double price) {
    int quantity = items[key.toString()]??0;
    if (quantity >= 1) {
      quantity--;
      _updateList(key, quantity);
      _updateTotal(-price);
    }
  }

  int getCount(int key) {
    if (items.containsKey(key)) {
      return items[key];
    } else {
      return 0;
    }
  }

  void _updateTotal(double amount) {
    total = total + (amount) as RxDouble;
  }

  Future<void> addItemsToCart() async {
    if (_status.value == Status.loading) return;
    try {
      _status.value = Status.loading;
      items.forEach((key, value) async {//adding each item in the map one by one since API only allows one at a time
        final data = <String, dynamic>{
          'product': key,
          'quantity': value.toString(),
        };
        await _cartService.addItemsToCart(data);
      });
      _status.value = Status.success;
    } catch (e) {
      _message = e.toString();
      _status.value = Status.error;
    }
  }
}
