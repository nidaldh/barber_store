import 'package:barbers_store/infrastructure/controller/cart.controller.dart';
import 'package:barbers_store/infrastructure/controller/store.controller.dart';
import 'package:barbers_store/infrastructure/model/product.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: controller.reference.snapshots(),
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
                            color: getColor(doc['quantity']),
                            child: ListTile(
                              title: Text(doc['name'] ?? 'Product Name'),
                              trailing:
                                  Text(doc['barcode'] ?? 'Product Barcode'),
                              subtitle: Text(
                                  'Quantity: ' + doc['quantity'].toString()),
                              onTap: () async {
                                controller.changeProduct(doc.data());
                                Get.back();
                              },
                              onLongPress: () {
                                Get.find<CartController>().addProductToCart(
                                    ProductModel.fromMap(doc.data() as Map));
                              },
                            ),
                          ))
                      .toList());
            }
            return Center(child: Text("NO Products"));
          }),
    );
  }

  Color getColor(var quantity) {
    if (quantity != null && quantity < 1) {
      return Colors.redAccent;
    }
    return Colors.white;
  }
}
