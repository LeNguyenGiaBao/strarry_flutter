import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/screens/cart/cart_screen.dart';
import 'package:strarry_flutter/screens/home/components/body.dart';
import 'package:strarry_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:strarry_flutter/globals.dart' as globals;

class HomeScreen extends StatelessWidget {
  static String routeName = "/product";

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Builder(builder: (BuildContext context) {
        return const Body();
      }),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        "Strarry",
        style: TextStyle(
          // fontSize: getProportionateScreenWidth(20),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      // leading: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(
      //     "Strarry",
      //     style: TextStyle(
      //       fontSize: getProportionateScreenWidth(20),
      //       fontWeight: FontWeight.bold,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
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
