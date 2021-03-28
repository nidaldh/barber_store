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
  List<String> dropDownListItem = [];
  late int startDateMicro;
  late int endDateMicro;
  List<DocumentModel> documents = [];
  DateTimeRange initialDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  late String selectedCategory;

  DocumentListController(this.type);

  @override
  void onInit() async {
    if (type == Type.income) {
      reference = _db.collection(Constant.INCOME_COLLECTION);
      dropDownListItem = Categories.incomeCategories;
    } else {
      reference = _db.collection(Constant.OUTCOME_COLLECTION);
      dropDownListItem = Categories.outcomeCategories.toList();
    }
    selectedCategory = 'All';
    dropDownListItem.add('All');
    getDocuments();
    super.onInit();
  }

  Future<void> getDocuments({filter = false}) async {
    reference.get();
    QuerySnapshot querySnapshot = await reference.get();
    documents.clear();

    for (QueryDocumentSnapshot data in querySnapshot.docs) {
      DocumentModel tmpDocument = DocumentModel.fromJson(data.data()!);
      if (filter) {
        if (filterCondition(tmpDocument)) {
          documents.add(tmpDocument);
        }
      } else {
        documents.add(tmpDocument);
      }
    }
    update();
  }

  bool filterCondition(DocumentModel data) {
    if (selectedCategory != 'All' && data.category != selectedCategory) {
      return false;
    }
    if ((endDateMicro > int.parse(data.dateMicroseconds) &&
        int.parse(data.dateMicroseconds) > startDateMicro)) {
      return true;
    }
    return false;
  }
}
