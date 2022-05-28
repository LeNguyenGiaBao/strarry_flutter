import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strarry_flutter/controller.dart';
import 'package:strarry_flutter/size_config.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';
import '../../../size_config.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  final Controller c = Get.put(Controller());

  CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 243, 92, 92),
    );
  }
}
