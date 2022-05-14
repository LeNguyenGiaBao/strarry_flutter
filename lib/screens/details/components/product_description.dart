import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:strarry_flutter/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(40),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              product.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
              top: getProportionateScreenWidth(20),
              left: getProportionateScreenWidth(30),
              right: getProportionateScreenWidth(40)),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "\$${product.price.toString()}",
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenWidth(20),
            left: getProportionateScreenWidth(30),
            right: getProportionateScreenWidth(30),
          ),
          child: Text(
            product.description,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
