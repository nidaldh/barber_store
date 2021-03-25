import 'package:get/get.dart';
import 'package:barbers_store/infrastructure/controller/store.controller.dart';

class StoreControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreController>(
      () => StoreController(),
    );
  }
}
