import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Cart.dart';

import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  final Function press;

  const CartCard({
    Key? key,
    required this.cart,
    required this.press,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Hero(
                  tag: "${cart.product.id}",
                  child: Image.memory(cart.product.image),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  cart.product.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$${cart.product.price}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.red),
                  children: [
                    TextSpan(
                        text: "    x${cart.numOfItem}",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
