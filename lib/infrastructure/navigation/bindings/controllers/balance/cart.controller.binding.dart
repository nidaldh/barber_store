import 'package:barbers_store/infrastructure/controller/balance/document.controller.dart';
import 'package:barbers_store/infrastructure/controller/store.controller.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:get/get.dart';

class CartControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StoreController>(
      StoreController(),
    );
    Get.lazyPut<DocumentController>(
      () => DocumentController(Type.income),
    );
  }
}
