import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/controller/balance/document_list.controller.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:barbers_store/infrastructure/navigation/routes.dart';
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
        body: RefreshIndicator(
          onRefresh: () => controller.getDocuments(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GetBuilder<DocumentListController>(
                        builder: (controller) => Column(
                              children: [
                                Text('Start: ' +
                                    controller.dateRangeFilter.start
                                        .toString()),
                                Text('End: ' +
                                    controller.dateRangeFilter.end.toString()),
                              ],
                            ))
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ElevatedButton(
                  onPressed: () => controller.getDocuments(filter: true),
                  child: Text('Filter'),
                ),
                Obx(() => Text(controller.total.value.toString())),
                GetBuilder<DocumentListController>(
                  builder: (controller) => Expanded(
                    child: ListView.builder(
                      itemCount: controller.documents.length,
                      itemBuilder: (context, index) {
                        DocumentModel doc = controller.documents[index];
                        return Card(
                            child: ListTile(
                          title: Text(doc.name),
                          trailing: Text(doc.date),
                          subtitle: Text('cat: ' + doc.category),
                          leading: Text(doc.amount.toString()),
                          onTap: () async {
                            goToForm(doc);
                          },
                        ));
                      },
                    ),
                  ),
                ),
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
