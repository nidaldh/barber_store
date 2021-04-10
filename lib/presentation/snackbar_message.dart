import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarMessage {
  static noProduct() => Get.snackbar('Alert', 'No Product with these Barcode',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red[300]);

  static somethingWrong() =>
      Get.snackbar('Error', 'Something went wrong please try again',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red[300]);

  static scanBarcodeAgain() =>
      Get.snackbar('Error', 'Please scan the barcode again',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red[300]);

  static modifySuccess() => Get.snackbar(
        'Success',
        'Product Added/Modified',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
      );

  static productSold() => Get.snackbar(
        'Success',
        'Product sold',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
      );

  static addProductToCart() => Get.snackbar(
        'Success',
        'Added to Cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
      );

  static productInCart() => Get.snackbar(
        'Note',
        'this product already on the cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
        backgroundColor: Colors.blueGrey,
      );

  static removeProductFromCart() => Get.snackbar(
        'Success',
        'Remove from Cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
      );

  static addDocument() => Get.snackbar(
        'Success',
        'Document added successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
      );

  static editDocument() => Get.snackbar(
        'Success',
        'Document modified successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
      );

  static removeDocument() => Get.snackbar(
        'Success',
        'Document deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
      );
}
