import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/main.dart';
import 'package:strarry_flutter/models/Product.dart';
import 'dart:convert';
import 'package:strarry_flutter/globals.dart' as globals;
import 'package:strarry_flutter/counter_provider.dart';
import 'package:strarry_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:strarry_flutter/globals.dart' as globals;

import '../../../constants.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  Future<bool> updateCart(String idProduct, String amountProduct) async {
    String idAccount = globals.idAccount;

    var request =
        http.MultipartRequest('POST', Uri.parse(backend + 'cart/update/'));
    request.fields.addAll({
      'id_account': idAccount,
      'id_product': idProduct,
      'amount_product': amountProduct
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var updateSuccess = responseJson["success"];
      if (updateSuccess == 'true') {
        return true;
      } else {
        return false;
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return //ChangeNotifierProvider(
        // create: (context) => CounterProvider(),
        Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: product.color,
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/add_to_cart.svg",
                color: product.color,
              ),
              onPressed: !globals.isSignIn
                  ? () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    }
                  : () async {
                      var isUpdateSuccess = await updateCart(
                          product.id.toString(),
                          Provider.of<CounterProvider>(context, listen: false)
                              .counter
                              .toString());
                      if (isUpdateSuccess == true) {
                        _showToast(context, true);
                      }
                    },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: product.color,
                onPressed: () {},
                child: Text(
                  "Buy Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // ),//
    );
  }

  void _showToast(BuildContext context, bool isSuccess) {
    final scaffold = ScaffoldMessenger.of(context);
    if (isSuccess == true) {
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Added to cart'),
        ),
      );
    } else {
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Add failed'),
        ),
      );
    }
  }
}
