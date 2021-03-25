import 'package:barbers_store/infrastructure/model/product.model.dart';
import 'package:barbers_store/presentation/snackbar_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  var newProduct = false.obs;
  final formKey = GlobalKey<FormState>();
  ProductModel? product;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference reference;
  TextEditingController? quantityController;
  TextEditingController? salePriceController;
  TextEditingController? costPriceController;
  TextEditingController? nameController;
  TextEditingController? barcodeController;
  FocusNode? nameFocusNode;

  @override
  void onInit() {
    reference = _db.collection('product');
    quantityController = TextEditingController();
    salePriceController = TextEditingController();
    costPriceController = TextEditingController();
    nameController = TextEditingController();
    barcodeController = TextEditingController();
    nameFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      barcodeController!.text = barcodeScanRes;
      if (barcodeScanRes.isNotEmpty || barcodeScanRes != '-1') {
        getProduct(barcodeScanRes);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void addProduct() {
    if (barcodeController!.text.isEmpty || barcodeController!.text == '-1') {
      SnackBarMessage.scanBarcodeAgain();
    } else {
      if (product != null && product!.barcode != barcodeController!.text) {
        reference.doc(product!.barcode).delete();
      }
      product = ProductModel(
          barcodeController!.text,
          nameController!.text,
          double.parse(salePriceController!.text),
          double.parse(costPriceController!.text),
          int.parse(quantityController!.text));
      reference
          .doc(barcodeController!.text)
          .set(product!.toJson())
          .then((value) {
        newProduct.value = false;
        SnackBarMessage.modifySuccess();
      });
    }
  }

  void saleProduct(saleQuantity) {
    if (barcodeController!.text.isEmpty || barcodeController!.text == '-1') {
      SnackBarMessage.scanBarcodeAgain();
    } else {
      reference.doc(barcodeController!.text).update(
          {'quantity': product!.quantity! - saleQuantity}).then((value) {
        product!.quantity = product!.quantity! - saleQuantity as int?;
        quantityController!.text = product!.quantity.toString();
        SnackBarMessage.productSold();
      }).catchError((e) {
        SnackBarMessage.somethingWrong();
      });
    }
  }

  void deleteProduct() {
    if (barcodeController!.text.isEmpty || barcodeController!.text == '-1') {
      SnackBarMessage.scanBarcodeAgain();
    } else {
      reference.doc(barcodeController!.text).delete().then((value) {
        newProduct.value = true;
        product = null;
        quantityController!.text = '';
        salePriceController!.text = '';
        costPriceController!.text = '';
        nameController!.text = '';
        barcodeController!.text = '';
        Get.snackbar(
          'Success',
          'Product Deleted',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Get.theme!.snackBarTheme.backgroundColor,
        );
      }).catchError((e) {
        SnackBarMessage.somethingWrong();
      });
    }
  }

  Future<void> getProduct(barcode, {flag = false}) async {
    DocumentSnapshot querySnapshot = await reference.doc(barcode).get();
    if (querySnapshot.data() != null && querySnapshot.data()!.isNotEmpty) {
      try {
        changeProduct(querySnapshot.data());
      } catch (e) {
        newProduct.value = true;
        product = null;
        nameFocusNode!.requestFocus();
        clearInputs();
        if (flag) {
          SnackBarMessage.noProduct();
        }
      }
    } else {
      newProduct.value = true;
      product = null;
      nameFocusNode!.requestFocus();
      clearInputs();
      if (flag) {
        SnackBarMessage.noProduct();
      }
    }
  }

  void changeProduct(productJson) {
    product = ProductModel.fromJson(productJson);

    nameController!.text = product!.name!;
    salePriceController!.text = product!.salePrice.toString();
    costPriceController!.text = product!.costPrice.toString();
    quantityController!.text = product!.quantity.toString();
    barcodeController!.text = product!.barcode!;
    newProduct.value = false;
    FocusScopeNode currentFocus = FocusScope.of(Get.context!);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.focusedChild?.unfocus();
    }
    formKey.currentState!.validate();
  }

  void clearInputs() {
    nameController!.text = '';
    salePriceController!.text = '';
    costPriceController!.text = '';
    quantityController!.text = '';
  }
}
