import 'package:barbers_store/presentation/home/controllers/home.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
          elevation: 4.0,
        ),
        body: Column(children: <Widget>[
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(1, 10, 1, 0),
              // child: FirestoreAnimatedList(
              //     linear: true,
              //     emptyChild:
              //         Scaffold(body: Center(child: Text('noChatYet'.tr))),
              //     query: controller.reference.limit(10000),
              //     itemBuilder: (
              //       BuildContext context,
              //       DocumentSnapshot snapshot,
              //       Animation<double> animation,
              //       int index,
              //     ) =>
              //         FadeTransition(
              //           opacity: animation,
              //           child: Card(
              //             child: ListTile(
              //               title: Text(snapshot.data().cast()['name'] ??
              //                   'Product Name'),
              //               trailing: Text(snapshot.data().cast()['barcode'] ??
              //                   'Product Barcode'),
              //               subtitle: Text('Quantity: ' +
              //                       snapshot
              //                           .data()
              //                           .cast()['quantity']
              //                           .toString() ??
              //                   'Product Quantity'),
              //               onTap: () async {
              //                 controller.changeProduct(snapshot.data());
              //                 Get.back();
              //               },
              //             ),
              //           ),
              //         )),
            ),
          )
        ]));
  }
}
