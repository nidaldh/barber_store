import 'package:barbers_store/infrastructure/constant/Categories.dart';
import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/controller/balance/balance.controller.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:barbers_store/presentation/snackbar_message.dart';
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
  DocumentModel? document;

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
      changeSubCategory(categoryController.text);
    }
    super.onInit();
  }

  void addDocument({DocumentModel? doc, update: true}) async {
    if (doc == null) {
      doc = await prepareDocument();
    }
    _addDocument(doc, update: update);
    document = doc;
    SnackBarMessage.addDocument();
    if (update) {
      update();
    }
  }

  void editDocument() async {
    reference.doc(currentId).delete();
    DocumentModel doc = await prepareDocument();
    _addDocument(doc);
    document = doc;
    SnackBarMessage.editDocument();
    update();
  }

  void deleteDocument() async {
    reference.doc(currentId).delete();
    Get.find<BalanceController>().updateBalance(type, -document!.amount);
    Get.back();
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

  void _addDocument(DocumentModel doc, {update: true}) {
    double amount = doc.amount;

    if (document != null && document!.amount > 0) {
      amount = doc.amount - document!.amount;
    }

    Get.find<BalanceController>().updateBalance(type, amount);
    reference.doc(doc.id).set(doc.toJson()).then((value) {
      status = Status.update;
      currentId = doc.id;
      if (update) {
        update();
      }
    });
  }

  Future<void> getDocument(id, {flag = false}) async {
    DocumentSnapshot querySnapshot = await reference.doc(id).get();
    if (querySnapshot.data() != null && querySnapshot.data()!.isNotEmpty) {
      try {
        _chaneDocument(querySnapshot.data());
      } catch (e) {
        print(e);
      }
    }
    update();
  }

  void _chaneDocument(data) {
    document = DocumentModel.fromJson(data);

    if (document!.category.isEmpty ||
        !dropDownCategory.contains(document!.category)) {
      document!.category = dropDownCategory.first;
      document!.subCategory = '';
    } else if (document!.subCategory != null &&
        !dropDownSubCategory.contains(document!.subCategory)) {
      document!.subCategory = '';
    }

    nameController.text = document!.name;
    categoryController.text = document!.category;
    subCategoryController.text = document!.subCategory ?? '';
    amountController.text = document!.amount.toString();
    dateController.text = document!.date;
    noteController.text = document!.note ?? '';
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
