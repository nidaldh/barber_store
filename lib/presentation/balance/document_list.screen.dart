import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/controller/balance/document_list.controller.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:barbers_store/infrastructure/navigation/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListScreen extends GetView<DocumentListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((controller.type == Type.income
                ? Constant.INCOME_TYPE
                : Constant.OUTCOME_TYPE) +
            ' List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: controller.reference.snapshots().cast(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }
            if (snapshot.hasData && snapshot.data != null) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView(
                  children: documents
                      .map((doc) => Card(
                              child: ListTile(
                            title: Text(doc['name'] ?? 'Product Name'),
                            trailing: Text(doc['date'] ?? 'Product Barcode'),
                            subtitle: Text('category: ' + doc['category']),
                            onTap: () async {
                              controller.type == Type.income
                                  ? Get.toNamed(Routes.INCOME_FORM,
                                      arguments: doc.id)
                                  : Get.toNamed(Routes.OUTCOME_FORM,
                                      arguments: doc.id);
                            },
                          )))
                      .toList());
            }
            return Center(child: Text("NO Products"));
          }),
    );
  }
}
