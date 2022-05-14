import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/size_config.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          press();
        },
        child: IntrinsicHeight(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 0,
                  // offset: Offset(1,1), // changes position of shadow
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          // padding: const EdgeInsets.all(kDefaultPaddin),
                          // For  demo we use fixed height  and width
                          // Now we dont need them
                          height: 120,
                          width: 120,
                          // decoration: BoxDecoration(
                          //   color: Colors.pink,
                          //   borderRadius: BorderRadius.circular(16),
                          // ),
                          child: Hero(
                            tag: "${product.id}",
                            child:
                                Image.memory(product.image, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              // products is out demo list
                              product.title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "\$${product.price.toString()}",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
