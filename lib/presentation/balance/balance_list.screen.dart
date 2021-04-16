import 'package:barbers_store/infrastructure/controller/balance/balance_list.controller.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BalanceListScreen extends GetView<BalanceListController> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Balance List'),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.getBalance(),
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
                    GetBuilder<BalanceListController>(
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
                    ElevatedButton(
                      onPressed: () => controller.getBalance(filter: true),
                      child: Text('Filter'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Income: ' +
                                      controller.totalIncome.value.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Outcome: ' +
                                      controller.totalOutcome.value.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Balance: ' +
                                      controller.total.value.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                GetBuilder<BalanceListController>(builder: (controller) {
                  if (!controller.ready) {
                    return Center(child: LinearProgressIndicator());
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.documents.length,
                      itemBuilder: (context, index) {
                        DocumentModel doc = controller.documents[index];
                        return Card(
                            color: (doc.type == Type.income)
                                ? Colors.green
                                : Colors.red,
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
}
