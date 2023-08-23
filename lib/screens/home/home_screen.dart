import 'package:canteen_test/networking/controllers/auth_controller.dart';
import 'package:canteen_test/networking/controllers/product_controller.dart';
import 'package:canteen_test/screens/home/widgets/cart_list_tile.dart';
import 'package:canteen_test/theme/colors.dart';
import 'package:canteen_test/utils/build_context.dart';
import 'package:canteen_test/utils/constants.dart';
import 'package:canteen_test/widgets/custom_button.dart';
import 'package:canteen_test/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/products_list_model.dart';
import '../../networking/controllers/cart_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductsController? _productsController;
  CartController? _cartController;
  final AuthController _authController = Get.put(AuthController());

  String _getFormattedDate() {
    String date = '';
    var outputFormat = DateFormat('dd E MMMM yyyy');
    date = outputFormat.format(DateTime.now());
    return date;
  }

  void _logOut() {
    _authController.unAuthenticate();
  }

  @override
  void initState() {
    _productsController = Get.put(ProductsController(context: context));
    _cartController = Get.put(CartController(context: context));
    _productsController!.getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: Obx(() {
        if (_productsController!.status.value == Status.success) {
          RxList<ProductData> productList = _productsController!.productList;
          if (productList.isNotEmpty) {
            return SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.responsive(35)),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        _getFormattedDate(),
                        style: textStyle.labelLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: context.responsive(35)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Canteen',
                          style: textStyle.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: _logOut,
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.logout,
                              color: AppColors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: RefreshIndicator.adaptive(
                        onRefresh: () async {
                          _productsController!.getProductList();
                        },
                        child: NotificationListener(
                          onNotification: (ScrollEndNotification t) {
                            if (t.metrics.pixels > 0 && t.metrics.atEdge) {
                              _productsController!.loadMoreProducts();
                            }
                            return true;
                          },
                          child: ListView.separated(
                            padding: EdgeInsets.only(
                                top: context.responsive(30), bottom: 90),
                            itemBuilder: (context, index) {
                              return CartListTile(
                                data: productList.value[index],
                              );
                            },
                            separatorBuilder: (_, __) => SizedBox(
                              height: context.responsive(24),
                            ),
                            itemCount: productList.value.length,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: 300,
              alignment: Alignment.center,
              child: const Text('No products found!'),
            );
          }
        } else if (_productsController!.status.value == Status.loading) {
          return Container(
            height: 300,
            alignment: Alignment.center,
            child: const CustomLoadingWidget(),
          );
        } else if (_productsController!.status.value == Status.error) {
          return Container(
            height: 300,
            alignment: Alignment.center,
            child: Text(
              _productsController!.message,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
      bottomSheet: Obx(
        () {
          if (_cartController != null &&
              _cartController!.total.value.abs() != 0.0) {
            return Container(
              color: AppColors.primary,
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total ₹ ${_cartController!.total.value.abs().toStringAsFixed(2)}',
                    style: textStyle.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  CustomButton.secondary(
                    text: 'Place Order',
                    height: 40,
                    width: 130,
                    isloading: _cartController!.status.value == Status.loading,
                    onTap: () => _cartController!.addItemsToCart(),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
