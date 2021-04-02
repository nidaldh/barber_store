import 'package:barbers_store/infrastructure/constant/Categories.dart';
import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/controller/balance/balance.controller.dart';
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
  late TextEditingController subCategoryController;
  late List<String> dropDownCategory = [];
  late List<String> dropDownSubCategory = [];

  DocumentController(this.type);

  @override
  void onInit() {
    amountController = TextEditingController();
    dateController = TextEditingController();
    noteController = TextEditingController();
    nameController = TextEditingController();
    categoryController = TextEditingController();
    subCategoryController = TextEditingController();
    if (type == Type.income) {
      reference = _db.collection(Constant.INCOME_COLLECTION);
      categoryController.text = Categories.incomeCategories.first;
      dropDownCategory = Categories.incomeCategories;
    } else {
      reference = _db.collection(Constant.OUTCOME_COLLECTION);
      categoryController.text = Categories.outcomeCategories.first;
      dropDownCategory = Categories.outcomeCategories;
    }

    if (Get.arguments != null) {
      currentId = Get.arguments;
      getDocument(currentId);
    } else {
      print(categoryController.text);
      changeSubCategory(categoryController.text);
    }
    super.onInit();
  }

  void addDocument({DocumentModel? doc}) async {
    if (doc == null) {
      doc = await prepareDocument();
    }
    _addDocument(doc);
    update();
  }

  void editDocument() async {
    reference.doc(currentId).delete();
    DocumentModel doc = await prepareDocument();
    _addDocument(doc);
    update();
  }

  Future<DocumentModel> prepareDocument() async {
    var date = DateTime.parse(dateController.text);

    return DocumentModel(
        name: nameController.text,
        amount: double.parse(amountController.text),
        date: dateController.text,
        category: categoryController.text,
        type: type,
        note: noteController.text,
        dateMicroseconds: date.microsecondsSinceEpoch.toString(),
        subCategory: subCategoryController.text,
        id: DateTime.now().microsecondsSinceEpoch.toString());
  }

  void _addDocument(DocumentModel doc) {
    double currentBalance =
        Get.find<BalanceController>().balance.value.amount ?? 0;
    if(type == Type.outcome){
      currentBalance -= doc.amount;
    }else{
      currentBalance += doc.amount;
    }
    Get.find<BalanceController>().updateBalance(currentBalance);
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
    subCategoryController.text = document.subCategory ?? '';
    amountController.text = document.amount.toString();
    dateController.text = document.date;
    noteController.text = document.note ?? '';
    status = Status.update;
    changeSubCategory(categoryController.text,
        subKey: subCategoryController.text);
    update();
  }

  void changeSubCategory(key, {subKey: ''}) async {
    var subCategory;
    if (type == Type.income) {
      subCategory = Categories.incomeSubCategories;
    } else {
      subCategory = Categories.outcomeSubCategories;
    }

    dropDownSubCategory =
        subCategory.firstWhere((element) => element.key == key).subCategory;

    if (subKey.isNotEmpty) {
      subCategoryController.text = subKey;
    } else {
      subCategoryController.text = dropDownSubCategory.first;
    }
  }
}
