import 'package:cached_network_image/cached_network_image.dart';
import 'package:canteen_test/models/products_list_model.dart';
import 'package:canteen_test/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../networking/controllers/cart_controller.dart';

class CartListTile extends StatefulWidget {
  const CartListTile({super.key, required this.data});
  final ProductData data;

  @override
  State<CartListTile> createState() => _CartListTileState();
}

class _CartListTileState extends State<CartListTile> {
  CartController? _cartController;

  void _onIncrement() {
      _cartController!.incrementItem(widget.data.id??0, widget.data.price??0.0);
  }

  void _onDecrement() {
   
      _cartController!.decrementItem(widget.data.id??0, widget.data.price??0.0);
    }
  

  @override
  void initState() {
    _cartController = Get.put(CartController(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.tick,
          ),
          child: CachedNetworkImage(
            height: 80,
            width: 80,
            imageUrl: widget.data.productImages!.isNotEmpty
                ? (widget.data.productImages?[0].image ?? '')
                : '',
            errorWidget: (context, url, error) => const Icon(
              Icons.broken_image_rounded,
              color: AppColors.primary,
            ),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.name ?? 'No name',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textStyle.titleMedium!.copyWith(
                  letterSpacing: -0.28,
                ),
              ),
              Text(
                '₹ ${widget.data.price}',
                style: textStyle.titleMedium!.copyWith(
                  letterSpacing: -0.28,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            InkWell(
              onTap: _onDecrement,
              borderRadius: BorderRadius.circular(4),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.remove_rounded,
                  color: AppColors.black,
                ),
              ),
            ),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Obx(() {
                int count=_cartController!.items[widget.data.id.toString()]??0;
                return Text(
                  count == 0 ? '' : '$count',
                  style: textStyle.titleMedium!.copyWith(
                    letterSpacing: -0.28,
                    color: AppColors.black,
                  ),
                );
              }),
            ),
            InkWell(
              onTap: _onIncrement,
              borderRadius: BorderRadius.circular(4),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_rounded,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
