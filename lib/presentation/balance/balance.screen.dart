import 'package:barbers_store/infrastructure/controller/balance/balance.controller.dart';
import 'package:barbers_store/infrastructure/navigation/routes.dart';
import 'package:barbers_store/presentation/ui/amount_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BalanceScreen extends GetView<BalanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barber Store'),
      ),
      body: Column(
        children: [mainGridView()],
      ),
    );
  }

  Expanded mainGridView() {
    return Expanded(
        child: StaggeredGridView.count(
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: <Widget>[
        myItem(MdiIcons.barcodeScan, 'Scan Reader', Routes.STORE),
        myItem(MdiIcons.cart, 'Cart', Routes.CART_HOME),
        Obx(() => AmountCard(
              title: 'Outcome',
              color: Colors.redAccent,
              icon: MdiIcons.upload,
              amount: controller.balance.value.outcome != null
                  ? controller.balance.value.outcome!
                  : 0,
              route: Routes.OUTCOME_LIST,
            )),
        Obx(() => AmountCard(
              title: 'Income',
              color: Colors.lightGreen,
              icon: MdiIcons.download,
              amount: controller.balance.value.income != null
                  ? controller.balance.value.income!
                  : 0,
              route: Routes.INCOME_LIST,
            )),
        Obx(() => AmountCard(
              title: 'Balance',
              color: Colors.green,
              icon: MdiIcons.equal,
              amount: controller.balance.value.amount != null
                  ? controller.balance.value.amount!
                  : 0,
              route: '',
              longPress: () => controller.recalculateBalance(),
            )),
      ],
      staggeredTiles: [
        StaggeredTile.extent(1, 150),
        StaggeredTile.extent(1, 150),
        StaggeredTile.extent(1, 150),
        StaggeredTile.extent(1, 150),
        StaggeredTile.extent(2, 150),
      ],
    ));
  }

  Material myItem(IconData icon, String string, String path) {
    return Material(
        child: InkWell(
            child: Card(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      string,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            onTap: () {
              Get.toNamed(path);
            }));
  }
}
