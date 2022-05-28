import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/screens/details/components/cart_counter.dart';
import 'package:strarry_flutter/screens/details/components/product_description.dart';
import 'package:strarry_flutter/screens/details/components/product_images.dart';
import 'package:strarry_flutter/screens/details/components/top_rounded_container.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: getProportionateScreenWidth(40),
                      ),
                      child: const CartCounter(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
