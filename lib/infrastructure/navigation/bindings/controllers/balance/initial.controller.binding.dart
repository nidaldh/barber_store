import 'package:barbers_store/infrastructure/controller/balance/balance.controller.dart';
import 'package:barbers_store/infrastructure/controller/cart.controller.dart';
import 'package:get/get.dart';

class InitialControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CartController>(CartController());
    Get.put<BalanceController>(BalanceController());
  }
}
