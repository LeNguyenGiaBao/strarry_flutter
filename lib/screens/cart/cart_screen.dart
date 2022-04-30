import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Cart.dart';
<<<<<<< HEAD
import 'package:strarry_flutter/size_config.dart';

=======
>>>>>>> 4945f2d705c47e5cc58559207f517e4c58f1b558
import 'components/body.dart';
import 'components/check_out_card.dart';
import '../../../size_config.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
<<<<<<< HEAD

=======
>>>>>>> 4945f2d705c47e5cc58559207f517e4c58f1b558
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
<<<<<<< HEAD
          // Text(
          //   "${carts.length} items",
          //   style: Theme.of(context).textTheme.caption,
          // ),
=======
          Text(
            "${5} items",
            // "5 items",
            style: Theme.of(context).textTheme.caption,
          ),
>>>>>>> 4945f2d705c47e5cc58559207f517e4c58f1b558
        ],
      ),
    );
  }
}
