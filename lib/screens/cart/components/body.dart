import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:strarry_flutter/models/Cart.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/screens/details/details_screen.dart';
import '../../../controller.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/widget/refresh_widget.dart';
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
  int money = 0;
  List<Cart> carts = [];
  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 400));

    carts = [];
    var url = Uri.parse(backend + 'cart/');
    var request = http.MultipartRequest('POST', url);
    request.fields
        .addAll({'id_account': globals.idAccount.toString()}); // NEED MODIFY

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
        money += price * amountProduct;
        Cart cart = Cart(product: product, numOfItem: amountProduct);
        carts.add(cart);
      }
      print(money);
      c.setMoney(money);

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
        child: ListView.builder(
          itemCount: carts.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(carts[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  carts.removeAt(index);
                });
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/icons/Trash.svg",
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              child: CartCard(
                cart: carts[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        product: carts[index].product,
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
