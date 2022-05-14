import 'package:flutter/material.dart';
import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/screens/details/components/cart_counter.dart';
import 'package:strarry_flutter/screens/details/components/color_and_size.dart';
import 'package:strarry_flutter/screens/details/components/product_description.dart';
import 'package:strarry_flutter/screens/details/components/product_images.dart';
import 'package:strarry_flutter/screens/details/components/top_rounded_container.dart';

import '../../../components/default_button.dart';
import '../../../size_config.dart';
import 'add_to_cart.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
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
                    // TopRoundedContainer(
                    //   color: Colors.white,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(
                    //       left: SizeConfig.screenWidth * 0.15,
                    //       right: SizeConfig.screenWidth * 0.15,
                    //       // bottom: getProportionateScreenWidth(15),
                    //       // top: getProportionateScreenWidth(15),
                    //     ),
                    //     child: AddToCart(product: product),
                    //   ),
                    // ),
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
