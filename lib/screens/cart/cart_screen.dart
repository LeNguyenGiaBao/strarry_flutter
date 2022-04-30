import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Cart.dart';
import 'package:strarry_flutter/size_config.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          // Text(
          //   "${carts.length} items",
          //   style: Theme.of(context).textTheme.caption,
          // ),
        ],
      ),
    );
  }
}
