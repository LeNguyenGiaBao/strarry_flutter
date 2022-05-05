import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strarry_flutter/models/Cart.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/models/Product.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/constants.dart';
import 'dart:typed_data';
import 'package:strarry_flutter/widget/refresh_widget.dart';
import 'package:strarry_flutter/widget/custom_text_form_field.dart';

import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<RefreshIndicatorState> keyRefresh2 =
      new GlobalKey<RefreshIndicatorState>();

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: RefreshWidget(
          keyRefresh: keyRefresh2,
          onRefresh: loadList,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                'CUSTOMER INFORMATION',
                style: Theme.of(context).textTheme.headline5,
              ),
              CustomTextFormField(
                title: 'Email',
                // onChanged: (String "value") {
                //   return;
                //   // context

                //   //     (email: value));
                // },
              ),
              CustomTextFormField(
                title: 'Full Name',
                // onChanged: (value) {
                //   context
                //       .read<CheckoutBloc>()
                //       .add(UpdateCheckout(fullName: value));
                // },
              ),
              SizedBox(height: 5),
              Text(
                'DELIVERY INFORMATION',
                style: Theme.of(context).textTheme.headline5,
              ),
              CustomTextFormField(
                title: 'Address',
                // onChanged: (value) {
                //   context
                //       .read<CheckoutBloc>()
                //       .add(UpdateCheckout(address: value));
                // },
              ),
              SizedBox(height: 5),
              Container(
                height: 60,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(color: Colors.black),
                // child: ListView.builder(
                //   itemCount: carts.length,
                //   itemBuilder: (context, index) => Padding(
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     child: Dismissible(
                //       key: Key(carts[index].product.id.toString()),
                //       direction: DismissDirection.endToStart,
                //       onDismissed: (direction) {
                //         setState(() {
                //           carts.removeAt(index);
                //         });
                //       },
                //       background: Container(
                //         padding: EdgeInsets.symmetric(horizontal: 20),
                //         decoration: BoxDecoration(
                //           color: Color(0xFFFFE6E6),
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         child: Row(
                //           children: [
                //             Spacer(),
                //             SvgPicture.asset("assets/icons/Trash.svg"),
                //           ],
                //         ),
                //       ),
                //       child: CartCard(cart: carts[index]),
                //     ),
                //   ),
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/payment-selection',
                          );
                        },
                        child: Text(
                          'SELECT A PAYMENT METHOD',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(height: 20),
              // Text(
              //   'ORDER SUMMARY',
              //   style: Theme.of(context).textTheme.headline3,
              // ),
              // OrderSummary()
            ],
          )
          //     } else {
          //       return Text('Something went wrong');
          //     }
          //   },
          // ),
          // child: ListView.builder(
          //   itemCount: carts.length,
          //   itemBuilder: (context, index) => Padding(
          //     padding: EdgeInsets.symmetric(vertical: 10),
          //     child: Dismissible(
          //       key: Key(carts[index].product.id.toString()),
          //       direction: DismissDirection.endToStart,
          //       onDismissed: (direction) {
          //         setState(() {
          //           carts.removeAt(index);
          //         });
          //       },
          //       background: Container(
          //         padding: EdgeInsets.symmetric(horizontal: 20),
          //         decoration: BoxDecoration(
          //           color: Color(0xFFFFE6E6),
          //           borderRadius: BorderRadius.circular(15),
          //         ),
          //         child: Row(
          //           children: [
          //             Spacer(),
          //             SvgPicture.asset("assets/icons/Trash.svg"),
          //           ],
          //         ),
          //       ),
          //       child: CartCard(cart: carts[index]),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
