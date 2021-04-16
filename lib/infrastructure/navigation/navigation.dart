import 'package:barbers_store/infrastructure/model/document.model.dart';
import 'package:barbers_store/infrastructure/navigation/bindings/controllers/balance/balance_list.controller.binding.dart';
import 'package:barbers_store/infrastructure/navigation/bindings/controllers/balance/cart.controller.binding.dart';
import 'package:barbers_store/infrastructure/navigation/bindings/controllers/balance/document.controller.binding.dart';
import 'package:barbers_store/infrastructure/navigation/bindings/controllers/balance/document_list.controller.binding.dart';
import 'package:barbers_store/infrastructure/navigation/bindings/controllers/balance/initial.controller.binding.dart';
import 'package:barbers_store/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:barbers_store/presentation/balance/balance.screen.dart';
import 'package:barbers_store/presentation/balance/balance_list.screen.dart';
import 'package:barbers_store/presentation/balance/document_form.screen.dart';
import 'package:barbers_store/presentation/balance/document_list.screen.dart';
import 'package:barbers_store/presentation/cart.screen.dart';
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
      binding: InitialControllerBinding(),
    ),
    GetPage(name: Routes.PRODUCT_LIST, page: () => ProductListScreen()),
    GetPage(
        name: Routes.STORE,
        page: () => StoreScreen(),
        binding: StoreControllerBinding()),
    GetPage(
        name: Routes.INCOME_FORM,
        page: () => FormScreen(),
        binding: DocumentControllerBinding(Type.income)),
    GetPage(
        name: Routes.OUTCOME_FORM,
        page: () => FormScreen(),
        binding: DocumentControllerBinding(Type.outcome)),
    GetPage(
        name: Routes.INCOME_LIST,
        page: () => ListScreen(),
        binding: DocumentListControllerBinding(Type.income)),
    GetPage(
        name: Routes.OUTCOME_LIST,
        page: () => ListScreen(),
        binding: DocumentListControllerBinding(Type.outcome)),
    GetPage(
        name: Routes.BALANCE_LIST,
        page: () => BalanceListScreen(),
        binding: BalanceListControllerBinding()),
    GetPage(
        name: Routes.CART_HOME,
        page: () => CartHome(),
        binding: CartControllerBinding()),
  ];
}
