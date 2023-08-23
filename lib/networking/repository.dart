import 'package:canteen_test/models/products_list_model.dart';
import 'package:canteen_test/networking/api_provider.dart';

import '../models/user_model.dart';

abstract class Repository {
  Future<UserModel>? login(Map<String, dynamic> data) {
    return null;
  }

  Future<ProductsListModel>? getProductList(Map<String, dynamic> data) {
    return null;
  }

  Future<bool>? addItemsToCart(Map<String, dynamic> data) {
    return null;
  }
}

class AppRepository implements Repository {
  final _provider = ApiProvider();

  @override
  Future<UserModel>? login(Map<String, dynamic> data) async {
    final res = await _provider.post('api/cus/v1/login', formData: data);
    return UserModel.fromJson(res);
  }

  @override
  Future<ProductsListModel>? getProductList(Map<String, dynamic> data) async {
    final res =
        await _provider.getData('api/cus/v1/products', queryParameters: data);
    return ProductsListModel.fromJson(res);
  }

  @override
  Future<bool>? addItemsToCart(Map<String, dynamic> data) async {
    final res = await _provider.post('api/cus/v1/add-to-cart', formData: data);
    return res['status'] == 200;
  }
}
