import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double amount;
  final String route;
  final String title;
  final GestureLongPressCallback? longPress;

  AmountCard(
      {required this.color,
      required this.icon,
      required this.amount,
      required this.route,
      required this.title,
      this.longPress});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      child: Card(
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon, color: Colors.black),
                  SizedBox(width: 10),
                  Text(title,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    amount.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          )),
      onTap: () {
        if (route.isNotEmpty) Get.toNamed(route);
      },
      onLongPress: longPress,
    ));
  }
}
