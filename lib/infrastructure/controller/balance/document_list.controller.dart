import 'package:barbers_store/infrastructure/constant/Categories.dart';
import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Status { add, update }

class DocumentListController extends GetxController {
  final Type type;
  Status status = Status.add;
  String? currentId;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference reference;
  List<String> dropDownCategory = [];
  late int startDateMicro;
  late int endDateMicro;
  List<DocumentModel> documents = [];
  late DateTimeRange dateRangeFilter;
  late String selectedCategory;
  late String selectedSubCategory;
  late List<String> dropDownSubCategory = [];
  late RxDouble total = 0.0.obs;

  DocumentListController(this.type);

  @override
  void onInit() async {
    total.value = 0.0;
    _initDateRange();
    if (type == Type.income) {
      reference = _db.collection(Constant.INCOME_COLLECTION);
      dropDownCategory = Categories.incomeCategories.toList();
    } else {
      reference = _db.collection(Constant.OUTCOME_COLLECTION);
      dropDownCategory = Categories.outcomeCategories.toList();
    }
    selectedCategory = 'All';
    dropDownCategory.add('All');
    changeSubCategory(dropDownCategory.first);

    getDocuments();
    super.onInit();
  }

  Future<void> getDocuments({filter = false}) async {
    reference.get();
    QuerySnapshot querySnapshot = await reference.get();
    documents.clear();
    total.value = 0;
    for (QueryDocumentSnapshot data in querySnapshot.docs) {
      DocumentModel tmpDocument = DocumentModel.fromJson(data.data());
      if (filter) {
        if (filterCondition(tmpDocument)) {
          documents.add(tmpDocument);
          total.value = total.value + tmpDocument.amount;
        }
      } else {
        documents.add(tmpDocument);
        total.value = total.value + tmpDocument.amount;
      }
    }
    update();
  }

  bool filterCondition(DocumentModel data) {
    if (selectedCategory != 'All' && data.category != selectedCategory) {
      return false;
    }
    if (selectedCategory != 'All' &&
        selectedSubCategory != 'All' &&
        data.subCategory != selectedSubCategory) {
      return false;
    }
    if ((dateRangeFilter.end.microsecondsSinceEpoch >
            int.parse(data.dateMicroseconds) &&
        int.parse(data.dateMicroseconds) >
            dateRangeFilter.start.microsecondsSinceEpoch)) {
      return true;
    }
    return false;
  }

  void changeSubCategory(key) {
    dropDownSubCategory.clear();
    var subCategory;
    if (type == Type.income) {
      subCategory = Categories.incomeSubCategories;
    } else {
      subCategory = Categories.outcomeSubCategories;
    }

    if (key == 'All') {
      return;
    }

    dropDownSubCategory.addAll(
        subCategory.firstWhere((element) => element.key == key).subCategory);
    selectedSubCategory = 'All';
    dropDownSubCategory.add('All');
  }

  void _initDateRange() {
    var now = DateTime.now();

    dateRangeFilter = DateTimeRange(
        start: DateTime(now.year, now.day == 1 ? now.month - 1 : now.month),
        end: DateTime(now.year, now.month, now.day));
  }
}
