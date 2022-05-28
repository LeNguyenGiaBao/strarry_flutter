import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/BillProduct.dart';
import 'package:strarry_flutter/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BillDetailCard extends StatelessWidget {
  final Function press;

  const BillDetailCard({
    Key? key,
    required this.billProduct,
    required this.press,
  }) : super(key: key);

  final BillProduct billProduct;

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
                  tag: "${billProduct.product.id}",
                  child: Image.memory(billProduct.product.image),
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
                  billProduct.product.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$${billProduct.product.price}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.red),
                  children: [
                    TextSpan(
                        text: "    x${billProduct.numOfItem}",
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
