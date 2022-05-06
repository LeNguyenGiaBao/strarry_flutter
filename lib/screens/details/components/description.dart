import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Product.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              product.description,
              style: const TextStyle(height: 1.5, fontSize: 20),
            ),
          ),
          const SizedBox(height: kDefaultPaddin*2),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              product.price.toString() + " VND",
              style: const TextStyle(
                  height: 1.5,
                  fontSize: 30,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
