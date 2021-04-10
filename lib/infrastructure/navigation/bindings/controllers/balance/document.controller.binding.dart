import 'package:barbers_store/infrastructure/controller/balance/document.controller.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:get/get.dart';

class DocumentControllerBinding extends Bindings {
  Type type;

  DocumentControllerBinding(this.type);

  @override
  void dependencies() {
    Get.lazyPut<DocumentController>(
      () => DocumentController(type),
    );
  }
}
