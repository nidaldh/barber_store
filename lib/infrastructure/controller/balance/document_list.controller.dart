import 'package:barbers_store/infrastructure/constant/Categories.dart';
import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum Status { add, update }

class DocumentListController extends GetxController {
  final Type type;
  Status status = Status.add;
  String? currentId;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference reference;
  late List<String> dropDownListItem;

  DocumentListController(this.type);

  @override
  void onInit() async {
    if (type == Type.income) {
      reference = _db.collection(Constant.INCOME_COLLECTION);
      dropDownListItem = Categories.incomeCategories;
    } else {
      reference = _db.collection(Constant.OUTCOME_COLLECTION);
      dropDownListItem = Categories.outcomeCategories;
    }

    super.onInit();
  }
}
