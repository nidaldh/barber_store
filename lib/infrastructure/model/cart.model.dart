import 'package:barbers_store/infrastructure/model/product.model.dart';
import 'package:get/get.dart';

class CartModel {
  int count;
  double total;
  double discount;
  List<ProductModel> products;
  bool haveError;

  CartModel(
      {required this.total,
      required this.count,
      required this.products,
      required this.haveError,
      required this.discount});

  void calculateItemCount() => count = products.length;

  void addProductToCart(ProductModel product) => products.add(product);

  void removeProductToCart(ProductModel product) =>
      products.removeWhere((element) => element.barcode == product.barcode);

  void increaseProductQuantity(index) => products[index].quantity++;

  void decreaseProductQuantity(index) => products[index].quantity--;

  Future<void> calculateCartTotal() async {
    total = 0;
    for (var value in products) {
      total += (value.quantity * (value.salePrice ?? 1));
    }
    total -= discount;
    Get.appUpdate();
  }

  void clearError() => haveError = false;

  void cartHaveError() => haveError = true;

  bool cartHaveProduct() => products.isNotEmpty;
}
