import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Cart.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/models/Product.dart';
import '../../../controller.dart';
import '../../../size_config.dart';
import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/widget/refresh_widget.dart';
import 'package:get/get.dart';
import 'package:strarry_flutter/globals.dart' as globals;
import 'package:strarry_flutter/screens/payment/paypal_payment.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> keyRefresh2 =
      GlobalKey<RefreshIndicatorState>();
  final Controller c = Get.find();
  String? email;
  String? fullname;
  String? address;
  String? phone;
  List<Cart> carts = [];

  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 400));

    carts = [];
    var url = Uri.parse(backend + 'cart/');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({'id_account': globals.idAccount.toString()});

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var cartListJson = responseJson['cart'];

      for (var i in cartListJson) {
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
      }

      setState(() {
        carts;
      });
    } else {}
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
          key: _formKey,
          keyRefresh: keyRefresh2,
          onRefresh: loadList,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                'CUSTOMER INFORMATION',
                style: Theme.of(context).textTheme.headline5,
              ),
              buildEmailFormField(),
              buildFullNameFormField(),
              const SizedBox(height: 5),
              Text(
                'DELIVERY INFORMATION',
                style: Theme.of(context).textTheme.headline5,
              ),
              buildAddressFormField(),
              const SizedBox(height: 5),
              buildPhoneFormField(),
              Container(
                height: 60,
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(color: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaypalPayment(
                                  amount: c.money.toDouble(),
                                  currency: 'USD',
                                ),
                              ));
                        },
                        child: Text(
                          'PAYMENT WITH PAYPAL',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => c.setEmail(newValue),
      onChanged: (newValue) => c.setEmail(newValue),
      validator: (value) {
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => c.setFullName(newValue),
      onChanged: (newValue) => c.setFullName(newValue),
      validator: (value) {
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Full Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => c.setAddress(newValue),
      onChanged: (newValue) => c.setAddress(newValue),
      validator: (value) {
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => c.setPhone(newValue),
      onChanged: (newValue) => c.setPhone(newValue),
      validator: (value) {
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
