import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/models/Product.dart';
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

  Future<void> loadList() async {
    var url = Uri.parse('http://10.0.2.2:8000/products/');
    var response = await http.get(url);
    var json = jsonDecode(response.body);

    print(json);
    var productsListJson = json['products'];
    print(productsListJson);

    for (var p in productsListJson) {
      
  }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg"),
          onPressed: loadList,
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
