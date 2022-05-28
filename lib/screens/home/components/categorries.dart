import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../controller.dart';
// import '../home_screen.dart';
// We need satefull widget for our categories
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:strarry_flutter/models/Product.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  // static String routeName = "/categories";

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["All", "Drink", "Milk", "Candy", "Fruit", "Cake"];
  // By default our first item will be selected
  final Controller c = Get.find();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          c.setIdCategory(selectedIndex);
          print(c.idcategory);
          // final Controller c = Get.find();
          // print(c.idcategory);
          // var products = [];
          // if (c.idcategory == 0) {
          //   var url = Uri.parse(backend + 'products/');
          //   var response = await http.get(url);
          //   var json = jsonDecode(response.body);

          //   var productsListJson = json['products'];
          //   for (var p in productsListJson) {
          //     int id = p[0];
          //     String name = p[1];
          //     String descriptiton = p[2];
          //     int price = p[3];
          //     int quantity = p[3];
          //     Uint8List image = const Base64Codec().decode(p[5]);
          //     Product product = Product(
          //         id: id,
          //         title: name,
          //         price: price,
          //         size: quantity,
          //         description: descriptiton,
          //         image: image,
          //         color: Colors.green);

          //     products.add(product);
          //   }
          // } else {
          //   var url1 = Uri.parse(backend + 'products/get/');
          //   var request1 = http.MultipartRequest('POST', url1);
          //   request1.fields.addAll(
          //       {'id_category': c.idcategory.toString()}); // NEED MODIFY

          //   var response1 = await request1.send();
          //   if (response1.statusCode == 200) {
          //     var responseAwait1 = await response1.stream.bytesToString();
          //     var responseJson1 = jsonDecode(responseAwait1);
          //     var productsListJson = responseJson1["products"];
          //     for (var p in productsListJson) {
          //       int id = p[0];
          //       String name = p[1];
          //       String descriptiton = p[2];
          //       int price = p[3];
          //       int quantity = p[3];
          //       Uint8List image = const Base64Codec().decode(p[5]);
          //       Product product = Product(
          //           id: id,
          //           title: name,
          //           price: price,
          //           size: quantity,
          //           description: descriptiton,
          //           image: image,
          //           color: Colors.green);

          //       products.add(product);
          //     }
          //   }
          // }
          // c.setProducts(products);

          // Navigator.pushNamed(context, HomeScreen.routeName);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? kPrimaryColor : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
