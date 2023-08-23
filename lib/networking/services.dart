import 'package:canteen_test/models/products_list_model.dart';
import 'package:canteen_test/models/user_model.dart';
import 'package:canteen_test/networking/repository.dart';
import 'package:get/get.dart';

class LoginService extends GetConnect {
  Future<UserModel?> login(Map<String, dynamic> data) async {
    final res = await AppRepository().login(data);
    return res;
  }
}

class ProductsListService extends GetConnect {
  Future<ProductsListModel?> getProductList(Map<String, dynamic> data) async {
    final res = await AppRepository().getProductList(data);
    return res;
  }
}

class CartService extends GetConnect {
  Future<bool?> addItemsToCart(Map<String, dynamic> data) async {
    final res = await AppRepository().addItemsToCart(data);
    return res;
  }
}