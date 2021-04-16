import 'package:barbers_store/infrastructure/controller/balance/balance_list.controller.dart';
import 'package:get/get.dart';

class BalanceListControllerBinding extends Bindings {
  BalanceListControllerBinding();

  @override
  void dependencies() {
    Get.lazyPut<BalanceListController>(
      () => BalanceListController(),
    );
  }
}
