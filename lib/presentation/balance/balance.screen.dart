import 'package:barbers_store/infrastructure/controller/balance/balance.controller.dart';
import 'package:barbers_store/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BalanceScreen extends GetView<BalanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(MdiIcons.cart),
              onPressed: () {
                Get.toNamed(Routes.STORE);
              })
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text('Start Point'),
          ),
          ElevatedButton(
              onPressed: () => Get.toNamed(Routes.INCOME_FORM),
              child: Text('Income Form')),
          ElevatedButton(
              onPressed: () => Get.toNamed(Routes.OUTCOME_FORM),
              child: Text('Outcome Form')),
          ElevatedButton(
              onPressed: () => Get.toNamed(Routes.INCOME_LIST),
              child: Text('Income List')),
          ElevatedButton(
              onPressed: () => Get.toNamed(Routes.OUTCOME_LIST),
              child: Text('Outcome List')),
          ElevatedButton(
              onPressed: () => Get.toNamed(Routes.CART_HOME),
              child: Text('Cart')),
          ElevatedButton(
              onPressed: () => controller.recalculateBalance(),
              child: Text('Recall')),
          Obx(() => Text(controller.balance.value.amount.toString()))
        ],
      ),
    );
  }
}
