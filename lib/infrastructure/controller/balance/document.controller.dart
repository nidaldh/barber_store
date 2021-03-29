import 'package:barbers_store/infrastructure/constant/Categories.dart';
import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum Status { add, update }

class DocumentController extends GetxController {
  final Type type;
  Status status = Status.add;
  String? currentId;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference reference;
  late TextEditingController amountController;
  late TextEditingController dateController;
  late TextEditingController noteController;
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late List<String> dropDownListItem;

  DocumentController(this.type);

  @override
  void onInit() {
    amountController = TextEditingController();
    dateController = TextEditingController();
    noteController = TextEditingController();
    nameController = TextEditingController();
    categoryController = TextEditingController();
    if (type == Type.income) {
      reference = _db.collection(Constant.INCOME_COLLECTION);
      categoryController.text = Categories.incomeCategories.first;
      dropDownListItem = Categories.incomeCategories;
    } else {
      reference = _db.collection(Constant.OUTCOME_COLLECTION);
      categoryController.text = Categories.outcomeCategories.first;
      dropDownListItem = Categories.outcomeCategories;
    }

    if (Get.arguments != null) {
      currentId = Get.arguments;
      getDocument(currentId);
    }
    print(dropDownListItem);
    super.onInit();
  }

  void addDocument() {
    _addDocument();
    update();
  }

  void editDocument() {
    reference.doc(currentId).delete();
    _addDocument();
    update();
  }

  void _addDocument() {
    var date = DateTime.parse(dateController.text);

    DocumentModel doc = new DocumentModel(
        name: nameController.text,
        amount: double.parse(amountController.text),
        date: dateController.text,
        category: categoryController.text,
        type: type,
        note: noteController.text,
        dateMicroseconds: date.microsecondsSinceEpoch.toString(),
        id: DateTime.now().microsecondsSinceEpoch.toString());

    reference.doc(doc.id).set(doc.toJson()).then((value) {
      status = Status.update;
      currentId = doc.id;
    });
  }

  Future<void> getDocument(id, {flag = false}) async {
    DocumentSnapshot querySnapshot = await reference.doc(id).get();
    if (querySnapshot.data() != null && querySnapshot.data()!.isNotEmpty) {
      try {
        print(querySnapshot.data());
        _chaneDocument(querySnapshot.data());
      } catch (e) {
        print(e);
      }
    }
    update();
  }

  void _chaneDocument(data) {
    var document = DocumentModel.fromJson(data);

    nameController.text = document.name;
    categoryController.text = document.category;
    amountController.text = document.amount.toString();
    dateController.text = document.date;
    noteController.text = document.note ?? '';
    status = Status.update;
    update();
  }
}
