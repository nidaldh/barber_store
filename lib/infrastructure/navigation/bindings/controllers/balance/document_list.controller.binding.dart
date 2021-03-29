import 'package:barbers_store/infrastructure/controller/balance/document_list.controller.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:get/get.dart';

class DocumentListControllerBinding extends Bindings {
  Type type;

  DocumentListControllerBinding(this.type);

  @override
  void dependencies() {
    Get.lazyPut<DocumentListController>(
      () => DocumentListController(type),
    );
  }
}
