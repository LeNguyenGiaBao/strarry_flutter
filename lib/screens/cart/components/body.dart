import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strarry_flutter/models/Cart.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/models/Product.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:strarry_flutter/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<RefreshIndicatorState> keyRefresh2 =
      new GlobalKey<RefreshIndicatorState>();
  List<Product> products = [];
  List<Cart> demoCarts = [];
  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 400));

    products = [];
    demoCarts = [];
    var url = Uri.parse(backend + 'products/');
    var response = await http.get(url);
    var json = jsonDecode(response.body);

    var productsListJson = json['products'];
    for (var p in productsListJson) {
      int id = p[0];
      String name = p[1];
      // debugPrint(name);
      String descriptiton = p[2];
      int price = p[3];
      int quantity = p[3];
      Uint8List image = Base64Codec().decode(p[5]);
      Product product = new Product(
          id: id,
          title: name,
          price: price,
          size: quantity,
          description: descriptiton,
          image: image,
          color: Colors.white);

      products.add(product);
    } // printToConsole(products);
    // print(products[0]);
    demoCarts.add(Cart(product: products[0], numOfItem: 2));
    demoCarts.add(Cart(product: products[1], numOfItem: 1));

    // demoCarts = [
    //   Cart(product: products[0], numOfItem: 2),
    //   Cart(product: products[1], numOfItem: 1),
    //   // Cart(product: products[3], numOfItem: 1),
    // ];
  }

// printToConsole(products);
// print(products[0]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: demoCarts.length,
        // itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(demoCarts[index].product.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                demoCarts.removeAt(index);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cart: demoCarts[index]),
          ),
        ),
      ),
    );
  }
}
