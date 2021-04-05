import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/controller/balance/document_list.controller.dart';
import 'package:barbers_store/infrastructure/model/balance.model.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference reference;
  Rx<BalanceModel> balance = BalanceModel().obs;

  BalanceController();

  @override
  void onInit() async {
    reference = _db.collection(Constant.BALANCE_COLLECTION);
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        try {
          balance.value = BalanceModel.fromJson(change.doc.data()!.cast());
        } catch (e) {
          balance.value = BalanceModel(amount: 0);
        }
      });
    });

    super.onInit();
  }

  Future<void> recalculateBalance() async {
    DocumentListController income = DocumentListController(Type.income);
    DocumentListController outcome = DocumentListController(Type.outcome);
    income.onInit();
    outcome.onInit();
    await income.getDocuments();
    await outcome.getDocuments();

    double incomeAmount = 0;
    for (DocumentModel documentModel in income.documents) {
      incomeAmount += documentModel.amount;
    }
    double outAmount = 0;
    for (DocumentModel documentModel in outcome.documents) {
      outAmount += documentModel.amount;
    }
    double balanceAmount = incomeAmount - outAmount;
    _updateBalance(balanceAmount);
  }

  void _updateBalance(balanceAmount) {
    reference
        .doc(Constant.BALANCE_DOCUMENT)
        .update(BalanceModel(amount: balanceAmount).toJson());
  }

  void updateBalance(type, amount) {
    double currentBalance = balance.value.amount ?? 0;
    if (type == Type.outcome) {
      currentBalance -= amount;
    } else {
      currentBalance += amount;
    }
    _updateBalance(currentBalance);
  }
}
