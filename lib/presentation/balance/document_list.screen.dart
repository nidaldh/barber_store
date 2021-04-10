import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/controller/balance/document_list.controller.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:barbers_store/infrastructure/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListScreen extends GetView<DocumentListController> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text((controller.type == Type.income
                  ? Constant.INCOME_TYPE
                  : Constant.OUTCOME_TYPE) +
              ' List'),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.getDocuments(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                    GetBuilder<DocumentListController>(
                        builder: (controller) => Column(
                              children: [
                                Text('Start: ' +
                                    formatter.format(
                                        controller.dateRangeFilter.start)),
                                Text('End: ' +
                                    formatter.format(
                                        controller.dateRangeFilter.end)),
                              ],
                            ))
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Categories'),
                      Flexible(
                        child: GetBuilder<DocumentListController>(
                          builder: (controller) => Container(
                            width: 250,
                            child: DropdownButtonFormField<String>(
                                onChanged: (value) {
                                  controller.selectedCategory = value ?? 'All';
                                  controller.changeSubCategory(value);
                                  Get.appUpdate();
                                },
                                value: controller.selectedCategory,
                                items: controller.dropDownCategory
                                    .map((type) => DropdownMenuItem(
                                          child: Text(type),
                                          value: type,
                                        ))
                                    .toList()),
                          ),
                        ),
                      )
                    ]),
                GetBuilder<DocumentListController>(
                  builder: (controller) {
                    if (controller.selectedCategory == 'All') {
                      return SizedBox(
                        height: 20,
                      );
                    }
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Sub Categories'),
                          Flexible(
                            child: Container(
                              width: 250,
                              child: DropdownButtonFormField<String>(
                                  onChanged: (value) {
                                    controller.selectedSubCategory =
                                        value ?? 'All';
                                    Get.appUpdate();
                                  },
                                  value: controller.selectedSubCategory,
                                  items: controller.dropDownSubCategory
                                      .map((type) => DropdownMenuItem(
                                            child: Text(type),
                                            value: type,
                                          ))
                                      .toList()),
                            ),
                          )
                        ]);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () => Get.toNamed(
                          controller.type == Type.income
                              ? Routes.INCOME_FORM
                              : Routes.OUTCOME_FORM),
                      child: Text('Insert'),
                    ),
                    ElevatedButton(
                      onPressed: () => controller.getDocuments(filter: true),
                      child: Text('Filter'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Total: ' + controller.total.value.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    )),
                GetBuilder<DocumentListController>(builder: (controller) {
                  print(!controller.ready);
                  if (!controller.ready) {
                    return Center(child: LinearProgressIndicator());
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.documents.length,
                      itemBuilder: (context, index) {
                        DocumentModel doc = controller.documents[index];
                        return Card(
                            child: ListTile(
                          title: Text(doc.name),
                          trailing: Text(doc.date),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cat: ' + doc.category),
                              Text('SubCat: ' + (doc.subCategory ?? '')),
                            ],
                          ),
                          leading: Text(doc.amount.toString()),
                          onTap: () async {
                            goToForm(doc);
                          },
                        ));
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? pickedDate = await showDateRangePicker(
        context: context,
        initialDateRange: controller.dateRangeFilter,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (pickedDate != null) {
      controller.startDateMicro = pickedDate.start.microsecondsSinceEpoch;
      controller.endDateMicro = pickedDate.end.microsecondsSinceEpoch;
      controller.dateRangeFilter =
          DateTimeRange(start: pickedDate.start, end: pickedDate.end);
    }
  }

  void goToForm(doc) {
    controller.type == Type.income
        ? Get.toNamed(Routes.INCOME_FORM, arguments: doc.id)
        : Get.toNamed(Routes.OUTCOME_FORM, arguments: doc.id);
  }
}
