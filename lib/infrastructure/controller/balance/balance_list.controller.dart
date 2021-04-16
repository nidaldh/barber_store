import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanceListController extends GetxController {
  String? currentId;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference incomeReference;
  late CollectionReference outComeReference;
  late int startDateMicro;
  late int endDateMicro;
  List<DocumentModel> documents = [];
  late DateTimeRange dateRangeFilter;
  late RxDouble total = 0.0.obs;
  late RxDouble totalIncome = 0.0.obs;
  late RxDouble totalOutcome = 0.0.obs;
  late bool ready = false;

  BalanceListController();

  @override
  void onInit() async {
    total.value = 0.0;
    _initDateRange();
    incomeReference = _db.collection(Constant.INCOME_COLLECTION);
    outComeReference = _db.collection(Constant.OUTCOME_COLLECTION);
    getBalance();

    super.onInit();
  }

  Future<void> getBalance({filter: true}) async {
    ready = false;
    update();
    documents.clear();
    totalIncome.value = await getIncomes(filter);
    totalOutcome.value = await getOutComes(filter);
    documents.sort();
    total.value = totalIncome.value - totalOutcome.value;
    ready = true;
    update();
  }

  Future<double> getOutComes(filter) async {
    QuerySnapshot querySnapshot = await outComeReference.get();
    return await prepareDocument(querySnapshot, filter);
  }

  Future<double> getIncomes(filter) async {
    QuerySnapshot querySnapshot = await incomeReference.get();
    return await prepareDocument(querySnapshot, filter);
  }

  Future<double> prepareDocument(querySnapshot, filter) async {
    double total = 0.0;
    for (QueryDocumentSnapshot data in querySnapshot.docs) {
      DocumentModel tmpDocument = DocumentModel.fromJson(data.data());
      if (filter) {
        if (filterCondition(tmpDocument)) {
          documents.add(tmpDocument);
          total = total + tmpDocument.amount;
        }
      } else {
        documents.add(tmpDocument);
        total = total + tmpDocument.amount;
      }
    }
    return total;
  }

  bool filterCondition(DocumentModel data) {
    var tmp = DateTimeRange(
        start: DateTime(dateRangeFilter.start.year, dateRangeFilter.start.month,
            dateRangeFilter.start.day - 1),
        end: DateTime(dateRangeFilter.end.year, dateRangeFilter.end.month,
            dateRangeFilter.end.day + 1));
    if ((tmp.end.microsecondsSinceEpoch > int.parse(data.dateMicroseconds) &&
        int.parse(data.dateMicroseconds) > tmp.start.microsecondsSinceEpoch)) {
      return true;
    }
    return false;
  }

  void _initDateRange() {
    var now = DateTime.now();

    dateRangeFilter = DateTimeRange(
        start: DateTime(now.year, now.day == 1 ? now.month - 1 : now.month),
        end: DateTime(now.year, now.month, now.day));
  }
}
