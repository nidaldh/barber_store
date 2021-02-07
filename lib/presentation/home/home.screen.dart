import 'package:barbers_store/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'HomeScreen is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () => controller.scanBarcodeNormal(),
                        child: Text("Start barcode scan")),
                    Obx(() => Text('Scan result : ${controller.scanBarcode}\n',
                        style: TextStyle(fontSize: 20)))
                  ]))
        ],
      ),
    );
  }
}
