import 'package:barbers_store/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:barbers_store/presentation/balance/balance.screen.dart';
import 'package:barbers_store/presentation/store/product_list.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  EnvironmentsBadge({required this.child});

  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.BALANCE,
      page: () => BalanceScreen(),
    ),
    GetPage(name: Routes.PRODUCT_LIST, page: () => ProductListScreen()),
    GetPage(
        name: Routes.STORE,
        page: () => StoreScreen(),
        binding: StoreControllerBinding()),
  ];
}
