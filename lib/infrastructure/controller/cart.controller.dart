import 'package:barbers_store/infrastructure/constant/Categories.dart';
import 'package:barbers_store/infrastructure/controller/balance/document.controller.dart';
import 'package:barbers_store/infrastructure/controller/store.controller.dart';
import 'package:barbers_store/infrastructure/model/cart.model.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:barbers_store/infrastructure/model/product.model.dart';
import 'package:barbers_store/presentation/snackbar_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartController extends GetxController {
  late CartModel cart;

  CartController();

  @override
  void onInit() {
    cart = CartModel(
        total: 0, count: 0, products: <ProductModel>[], haveError: false);
    super.onInit();
  }

  void addProductToCart(ProductModel product) {
    product.quantity = 1;
    if (!cart.products.contains(product)) {
      cart.addProductToCart(product);
      cart.calculateCartTotal();
      SnackBarMessage.productSold();
    }
  }

  void deleteProductFromCart(ProductModel product) {
    cart.removeProductToCart(product);
    cart.calculateCartTotal();
  }

  void increaseProductQuantity(index) {
    cart.increaseProductQuantity(index);
    cart.calculateCartTotal();
  }

  void decreaseProductQuantity(index) {
    if (cart.products[index].quantity > 1) {
      cart.decreaseProductQuantity(index);
      cart.calculateCartTotal();
    }
  }

  void saleCartProducts() async {
    await _validateCate();
    if (!cart.haveError) {
      for (ProductModel cartProduct in cart.products) {
        _saleProduct(cartProduct);
      }
      _addIncome();
      cart.products.clear();
    }
    update();
  }

  Future<void> _validateCate() async {
    StoreController storeController = Get.find<StoreController>();
    int index = 0;
    bool haveError = false;
    for (ProductModel cartProduct in cart.products) {
      var storeProduct =
          await storeController.getProductInfo(cartProduct.barcode);
      if (storeProduct.quantity < cartProduct.quantity) {
        cart.products[index].error = 'we only have ' +
            storeProduct.quantity.toString() +
            ' item in stock';
        haveError = true;
      } else {
        cart.products[index].error = null;
      }
      print(storeProduct);
      cart.products[index].storeQuantity = storeProduct.quantity;
      index++;
    }
    if (haveError) {
      cart.cartHaveError();
    } else {
      cart.clearError();
    }
  }

  void _saleProduct(ProductModel product) {
    StoreController storeController = Get.find<StoreController>();
    storeController.reference.doc(product.barcode).update(
        {'quantity': product.storeQuantity! - product.quantity}).then((value) {
      SnackBarMessage.productSold();
    }).catchError((e) {
      SnackBarMessage.somethingWrong();
    });
  }

  Future<void> _addIncome() async {
    var doc = await prepareDocument();
    DocumentController documentController = Get.find<DocumentController>();
    documentController.addDocument(doc: doc);
  }

  Future<DocumentModel> prepareDocument() async {
    String note = await prepareDocumentNote();
    return DocumentModel(
        name: 'Sale Products',
        amount: cart.total,
        date: DateFormat('yyyy-MM-dd').add_Hm().format(DateTime.now()),
        category: Categories.cartIncomeCategory,
        type: Type.income,
        note: note,
        dateMicroseconds: DateTime.now().microsecondsSinceEpoch.toString(),
        subCategory: Categories.cartIncomeSubCategory,
        id: DateTime.now().microsecondsSinceEpoch.toString());
  }

  Future<String> prepareDocumentNote() async {
    String note = '';
    for (var value in cart.products) {
      note += 'Name: ' +
          value.name +
          ', Qty: ' +
          value.quantity.toString() +
          ', Price: ' +
          value.salePrice.toString() +
          '\n';
    }
    return note;
  }
}
