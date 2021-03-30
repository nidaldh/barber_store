import 'package:barbers_store/infrastructure/componet/form_input_field_with_icon.dart';
import 'package:barbers_store/infrastructure/constant/Constant.dart';
import 'package:barbers_store/infrastructure/controller/balance/document.controller.dart';
import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormScreen extends GetView<DocumentController> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((controller.type == Type.income
                ? Constant.INCOME_TYPE
                : Constant.OUTCOME_TYPE) +
            ' Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories'),
                      Flexible(
                        child: GetBuilder<DocumentController>(
                          builder: (controller) => Container(
                            width: 250,
                            child: DropdownButtonFormField<String>(
                                onChanged: (value) {
                                  controller.categoryController.text = value!;
                                  print(value);
                                  controller.changeSubCategory(value);
                                  Get.appUpdate();
                                },
                                value: controller.categoryController.text,
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
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SubCategory'),
                      Flexible(
                        child: GetBuilder<DocumentController>(
                          builder: (controller) => Container(
                            width: 250,
                            child: DropdownButtonFormField<String>(
                                onChanged: (value) {
                                  controller.subCategoryController.text =
                                      value!;
                                  Get.appUpdate();
                                },
                                value: controller.subCategoryController.text,
                                items: controller.dropDownSubCategory
                                    .map((type) => DropdownMenuItem(
                                          child: Text(type),
                                          value: type,
                                        ))
                                    .toList()),
                          ),
                        ),
                      )
                    ]),
                SizedBox(
                  height: 20,
                ),
                FormInputFieldWithIcon(
                  controller: controller.nameController,
                  onSaved: (value) =>
                      controller.nameController.text = value ?? '',
                  iconPrefix: Icons.drive_file_rename_outline,
                  labelText: 'Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter product name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FormInputFieldWithIcon(
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      controller.amountController.text = value ?? '',
                  iconPrefix: Icons.drive_file_rename_outline,
                  labelText: 'amount',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Amount";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DateTimeField(
                  validator: (value) {
                    if (value == null) {
                      return 'dateError'.tr;
                    }
                    if (value.compareTo(DateTime.now()) > 0) {
                      return 'dateErrorFuture'.tr;
                    }
                    return null;
                  },
                  format: format,
                  controller: controller.dateController,
                  onSaved: (value) =>
                      controller.dateController.text = value.toString(),
                  onShowPicker: (context, currentValue) async {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'date'.tr,
                      prefixIcon: Icon(Icons.date_range_outlined)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 4,
                  controller: controller.noteController,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      controller.noteController.text = value ?? '',
                  decoration: InputDecoration(
                    hintText: "Enter your text here",
                    filled: true,
                    labelText: 'note',
                  ),
                ),
                ElevatedButton(
                    child: GetBuilder<DocumentController>(
                        builder: (c) => Text(
                            controller.status == Status.add ? 'Add' : 'Edit')),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.status == Status.add
                            ? controller.addDocument()
                            : controller.editDocument();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
