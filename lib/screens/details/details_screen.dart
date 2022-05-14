import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/screens/cart/cart_screen.dart';
import 'package:strarry_flutter/screens/details/components/add_to_cart.dart';
import 'package:strarry_flutter/screens/details/components/body.dart';
import 'package:strarry_flutter/globals.dart' as globals;
import 'package:strarry_flutter/screens/sign_in/sign_in_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Body(product: product),
      bottomNavigationBar: AddToCart(product: product),

    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
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
          icon:
              SvgPicture.asset("assets/icons/search.svg", color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
            icon:
                SvgPicture.asset("assets/icons/cart.svg", color: Colors.black),
            onPressed: !globals.isSignIn
                    ? () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      }:
                      () {Navigator.pushNamed(context, CartScreen.routeName);},
            ),
        const SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
