import 'package:barbers_store/infrastructure/componet/form_input_field_with_icon.dart';
import 'package:barbers_store/infrastructure/controller/cart.controller.dart';
import 'package:barbers_store/infrastructure/controller/store.controller.dart';
import 'package:barbers_store/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StoreScreen extends GetView<StoreController> {
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
                          Obx(() => (!controller.newProduct.value &&
                                  controller.product != null)
                              ? Row(
                                  children: [
                                    // SizedBox(
                                    //   width: 20,
                                    // ),
                                    // ElevatedButton(
                                    //   // : Colors.green,
                                    //   onPressed: () =>
                                    //       _asyncInputDialog(context),
                                    //   child: Text('Sale'),
                                    //   style: ElevatedButton.styleFrom(
                                    //       primary: Colors.green),
                                    // ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Get.find<CartController>()
                                              .addProductToCart(
                                                  controller.product!),
                                      child: Text('Add To Cart'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey),
                                    ),
                                  ],
                                )
                              : Container())
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => controller.newProduct.value
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
                          child: Obx(() => controller.newProduct.value
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
                        Obx(() => (!controller.newProduct.value &&
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
}
