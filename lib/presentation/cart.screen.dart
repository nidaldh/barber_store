import 'package:barbers_store/infrastructure/controller/cart.controller.dart';
import 'package:barbers_store/infrastructure/model/product.model.dart';
import 'package:barbers_store/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class CartHome extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: SafeArea(
        child: GetBuilder<CartController>(builder: (controller) {
          if (controller.cart.cartHaveProduct()) {
            return cartList();
          }
          return emptyCart();
        }),
      ),
    );
  }

  Widget cartCard(ProductModel product, index) {
    return GestureDetector(
      onLongPress: () => _showDialog(product),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              controller.increaseProductQuantity(index);
                            }),
                        Text(
                          product.quantity.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              controller.decreaseProductQuantity(index);
                            }),
                      ],
                    ),
                    Text(
                      product.salePrice.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                GetBuilder<CartController>(builder: (controller) {
                  if (controller.cart.haveError && product.error != null) {
                    return Text(product.error!);
                  }
                  return Container();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cartList() {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: controller.cart.products.length,
              itemBuilder: (context, index) {
                return cartCard(controller.cart.products[index], index);
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(controller.cart.total.toString()),
              ElevatedButton(
                  onPressed: () => controller.saleCartProducts(),
                  child: Text('Sale'))
            ],
          ),
        )
      ],
    );
  }

  Widget emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Cart is empty'),
          ElevatedButton(
              onPressed: () => Get.toNamed(Routes.STORE),
              child: Text('Add Products'))
        ],
      ),
    );
  }

  void _showDialog(product) {
    var context = Get.context;
    Get.dialog(AlertDialog(
      title:
          Text('Delete Product'.tr, style: TextStyle(color: Colors.redAccent)),
      content: Text('Are you sure that you want to delete this product?'.tr),
      actions: <Widget>[
        TextButton(
          child: Text(
            'yes'.tr,
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {
            controller.deleteProductFromCart(product);
            Navigator.of(context!).pop();
          },
        ),
        TextButton(
          child: Text('no'.tr, style: TextStyle(color: Colors.lightGreen)),
          onPressed: () {
            Navigator.of(context!).pop();
          },
        ),
      ],
    ));
  }
}
