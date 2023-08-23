import 'package:canteen_test/networking/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/products_list_model.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_flush_bar.dart';

class ProductsController extends GetxController {
  ProductsController({required this.context});
  final BuildContext context;
  final ProductsListService _productsListService =
      Get.put(ProductsListService());
  String _message = '';
  String get message => _message;

  final Rx<Status> _status = Status.initialized.obs;
  Rx<Status> get status => _status;

  final RxBool _moreLoading = false.obs;
  RxBool get moreLoading => _moreLoading;

  final RxList<ProductData> _productList = <ProductData>[].obs;
  RxList<ProductData> get productList => _productList;

  int _currentPage = 1;
  int _perPage = 0;
  int _currentPageContentLength = 0;
  // int _totalContentLength = 0;

  @override
  void onInit() {
    super.onInit();
    ever(_status, (value) {
      if (value == Status.error) {
        AppMessenger.of(context).error(message);
      }
    });
    ever(_moreLoading, (value) {
      if(value){
        AppMessenger.of(context).info('Loading more products!');
      }
    });
  }

  Future<void> getProductList() async {
    if (_status.value == Status.loading) return;
    try {
      _currentPage = 0;
      _status.value = Status.loading;
      final data = <String, dynamic>{'page': _currentPage.toString()};
      final res = await _productsListService.getProductList(data);
      _productList.value = res?.products?.productData ?? [];
      _perPage = res?.products?.perPage ?? 0;
      _currentPageContentLength = _productList.length;
      _status.value = Status.success;
    } catch (e) {
      _message = e.toString();
      _status.value = Status.error;
    }
  }

  Future<void> loadMoreProducts() async {
    if (_currentPageContentLength != _perPage || _moreLoading.value) return;
    try {
      _moreLoading.value = true;
      _currentPage++;
      final data = <String, dynamic>{'page': _currentPage.toString()};
      final res = await _productsListService.getProductList(data);
      final tempList = res?.products?.productData ?? [];
      _productList.addAll(tempList);
      _currentPageContentLength = tempList.length;
      _moreLoading.value = false;
    } catch (e) {
      _message = e.toString();
      _currentPage--;
      _moreLoading.value = false;
    }
  }
}
