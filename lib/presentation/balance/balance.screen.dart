import 'package:barbers_store/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BalanceScreen extends StatelessWidget {
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
              child: Text('Income')),
          ElevatedButton(
              onPressed: () => Get.toNamed(Routes.OUTCOME_FORM),
              child: Text('Outcome')),
        ],
      ),
    );
  }
}
