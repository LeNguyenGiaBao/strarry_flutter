import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strarry_flutter/models/Cart.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/models/Product.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
<<<<<<< HEAD
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/constants.dart';
import 'dart:typed_data';
import 'package:strarry_flutter/widget/refresh_widget.dart';

import 'package:strarry_flutter/models/Product.dart';
=======
import 'package:strarry_flutter/constants.dart';
>>>>>>> 4945f2d705c47e5cc58559207f517e4c58f1b558

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<RefreshIndicatorState> keyRefresh2 =
      new GlobalKey<RefreshIndicatorState>();
<<<<<<< HEAD

  List<Cart> carts = [];
  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 400));

    carts = [];
    var url = Uri.parse(backend + 'cart/');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({'id_account': '1'}); // NEED MODIFY

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var cartListJson = responseJson['cart'];

      for (var i in cartListJson) {
        int idCart = i[0];
        int idAccount = i[1];
        int idProductCart = i[2];
        int amountProduct = i[3];
        int idProduct = i[4];
        String name = i[5];
        String descriptiton = i[6];
        int price = i[7];
        int quantity = i[8];
        Uint8List image = Base64Codec().decode(i[9]);
        Product product = new Product(
            id: idProduct,
            title: name,
            price: price,
            size: quantity,
            description: descriptiton,
            image: image,
            color: Colors.green);
        Cart cart = new Cart(product: product, numOfItem: amountProduct);
        carts.add(cart);
      }

      setState(() {
        carts;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    loadList();
  }
=======
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
>>>>>>> 4945f2d705c47e5cc58559207f517e4c58f1b558

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
<<<<<<< HEAD
      child: RefreshWidget(
        keyRefresh: keyRefresh2,
        onRefresh: loadList,
        child: ListView.builder(
          itemCount: carts.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(carts[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  carts.removeAt(index);
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
=======
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
>>>>>>> 4945f2d705c47e5cc58559207f517e4c58f1b558
              ),
              child: CartCard(cart: carts[index]),
            ),
          ),
        ),
      ),
    );
  }
}
