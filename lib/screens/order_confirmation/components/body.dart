import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:strarry_flutter/models/Cart.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/models/Product.dart';
import '../../../size_config.dart';
import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/widget/refresh_widget.dart';
import 'package:strarry_flutter/widget/custom_text_form_field.dart';
import '../../../controller.dart';
import 'package:get/get.dart';

import 'cart_card.dart';
import 'package:strarry_flutter/globals.dart' as globals;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<RefreshIndicatorState> keyRefresh2 =
      GlobalKey<RefreshIndicatorState>();
  final Controller c = Get.find();
  String? email = "";
  List<Cart> carts = [];
  var children = <Widget>[];
  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 400));
    var url_insert_bill_product = Uri.parse(backend + 'bill_product/insert/');

    carts = [];
    children = <Widget>[];
    var url = Uri.parse(backend + 'cart/');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({'id_account': globals.idAccount}); 

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var cartListJson = responseJson['cart'];

      for (var i in cartListJson) {
        // int idCart = i[0];
        // int idAccount = i[1];
        // int idProductCart = i[2];
        int amountProduct = i[3];
        int idProduct = i[4];
        String name = i[5];
        String descriptiton = i[6];
        int price = i[7];
        int quantity = i[8];
        Uint8List image = const Base64Codec().decode(i[9]);
        Product product = Product(
            id: idProduct,
            title: name,
            price: price,
            size: quantity,
            description: descriptiton,
            image: image,
            color: Colors.green);
        Cart cart = Cart(product: product, numOfItem: amountProduct);
        carts.add(cart);

        // insert bill product
        var request_insert_bill_product = http.MultipartRequest('POST', url_insert_bill_product);
        request_insert_bill_product.fields.addAll({
        'id': c.idBill.toString(),
        'id_product': cart.product.id.toString(),
        'amount_product': cart.numOfItem.toString()
      });
      var response_insert_bill_product = await request_insert_bill_product.send();
      }
      for (var i = 0; i < carts.length; i++) {
        children.add(CartCard(cart: carts[i]));
      }

      setState(() {
        carts;
        children;
      });
    } else {
      print(response.reasonPhrase);
    }
    var url1 = Uri.parse(backend + 'account/email/');
    var request1 = http.MultipartRequest('POST', url1);
    request1.fields.addAll({'id_account': globals.idAccount.toString()});

    var response1 = await request1.send();
    if (response1.statusCode == 200) {
      var responseAwait1 = await response1.stream.bytesToString();
      var responseJson1 = jsonDecode(responseAwait1);
      var email1 = responseJson1["email"];
      email = email1.toString();
      setState(() {
        email;
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 300,
              ),
              Positioned(
                  left: (MediaQuery.of(context).size.width - 100) / 3,
                  top: 125,
                  child: Image.asset(
                    'assets/images/logo-removebg-preview.png',
                    width: SizeConfig.screenWidth * 0.4,
                    // height: 100,
                  )),
              Positioned(
                top: 250,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Your order is complete!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi ${email.toString()},',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                Text(
                  'Thank you for purchasing on The Strarry.',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                Text(
                  'Order Code: STRA${c.idBill.toString()}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                // OrderSummary(),
                const SizedBox(height: 20),
                Text(
                  'Order Detail',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const Divider(thickness: 2),
                const SizedBox(height: 5),
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  children: children,
                  // children: [
                  //   ProductCard.summary(
                  //     product: Product.products[0],
                  //     quantity: 2,
                  //   ),
                  //   ProductCard.summary(
                  //     product: Product.products[0],
                  //     quantity: 2,
                  //   ),
                  // ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
