import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/screens/cart/cart_screen.dart';
import 'package:strarry_flutter/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg", color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg", color: Colors.black),
          onPressed: () {Navigator.pushNamed(context, CartScreen.routeName);},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
