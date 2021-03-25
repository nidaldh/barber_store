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
        backgroundColor: Get.theme!.snackBarTheme.backgroundColor,
      );

  static productSold() => Get.snackbar(
        'Success',
        'Product sold',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Get.theme!.snackBarTheme.backgroundColor,
      );
}
