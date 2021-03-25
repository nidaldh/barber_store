import 'package:barbers_store/infrastructure/componet/form_input_field_with_icon.dart';
import 'package:barbers_store/infrastructure/navigation/routes.dart';
import 'package:barbers_store/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends GetView<HomeController> {
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Get.toNamed(Routes.PRODUCT_LIST);
            },
          )
        ],
        title: Text('Barber Store'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () => controller.scanBarcodeNormal(),
                              child: Text('Scan')),
                          Obx(() => (!controller.newProduct.value! &&
                                  controller.product != null)
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                    ),
                                    ElevatedButton(
                                      // : Colors.green,
                                      onPressed: () =>
                                          _asyncInputDialog(context),
                                      child: Text('Sale'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green),
                                    ),
                                  ],
                                )
                              : Container())
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => controller.newProduct.value!
                          ? Text('New Product\n',
                              style: TextStyle(fontSize: 20))
                          : Container()),
                    ])),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                  key: controller.formKey,
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: FormInputFieldWithIcon(
                            controller: controller.barcodeController,
                            iconPrefix: MdiIcons.barcode,
                            labelText: 'Barcode',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Barcode";
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            if (controller.barcodeController!.text.isNotEmpty) {
                              controller.getProduct(
                                  controller.barcodeController!.text,
                                  flag: true);
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormInputFieldWithIcon(
                      controller: controller.nameController,
                      iconPrefix: Icons.drive_file_rename_outline,
                      labelText: 'Product Name',
                      focusNode: controller.nameFocusNode,
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
                      controller: controller.quantityController,
                      labelText: 'Quantity',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter product quantity";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormInputFieldWithIcon(
                      controller: controller.costPriceController,
                      keyboardType: TextInputType.number,
                      labelText: 'Product Cost',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter product cost";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormInputFieldWithIcon(
                      controller: controller.salePriceController,
                      labelText: 'Product Price',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter product price";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Obx(() => controller.newProduct.value!
                              ? Text('Add')
                              : Text('Edit')),
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.formKey.currentState!.save();
                              controller.addProduct();
                            }
                          },
                        ),
                        //
                        Obx(() => (!controller.newProduct.value! &&
                                controller.product != null)
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                  ),
                                  ElevatedButton(
                                      // backgroundColor: Colors.red,
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      child: Text('Delete'),
                                      onPressed: () {
                                        _showDialog();
                                      }),
                                ],
                              )
                            : Container()),
                      ],
                    ),
                  ])),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    var context = Get.context;
    Get.dialog(AlertDialog(
      title:
          Text('Delete Product'.tr, style: TextStyle(color: Colors.redAccent)),
      content: Text('Are you sure that you want to delete this product?'.tr),
      actions: <Widget>[
        TextButton(
          child: Text(
            'yes'.tr,
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {
            controller.deleteProduct();
            Navigator.of(context!).pop();
          },
        ),
        ElevatedButton(
          child: Text('no'.tr, style: TextStyle(color: Colors.lightGreen)),
          onPressed: () {
            Navigator.of(context!).pop();
          },
        ),
      ],
    ));
  }

  void _asyncInputDialog(BuildContext context) async {
    controller.getProduct(controller.barcodeController!.text, flag: true);
    int saleQuantity = 0;
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      title: Text('Sale'.tr),
      content: Form(
        key: _formKey2,
        child: Container(
          width: 300,
          height: 150,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quantity'.tr,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amberAccent)),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty || int.parse(value) < 1) {
                    return 'please enter quantity';
                  } else if (controller.product!.quantity! < 1) {
                    return 'this product is out of stock';
                  } else if (int.parse(value) > controller.product!.quantity!) {
                    return 'You only have ${controller.product!.quantity} Piece';
                  }
                  return null;
                },
                onSaved: (value) => saleQuantity = int.parse(value!),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Row(
                      children: <Widget>[
                        Text('Sale'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                    onPressed: () async {
                      if (_formKey2.currentState!.validate()) {
                        _formKey2.currentState!.save();
                        controller.saleProduct(saleQuantity);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
