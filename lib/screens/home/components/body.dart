import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/screens/details/details_screen.dart';
import 'package:strarry_flutter/widget/refresh_widget.dart';
import '../../../controller.dart';
import 'categorries.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  static String routeName = "/body";

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<RefreshIndicatorState> keyRefresh2 =
      GlobalKey<RefreshIndicatorState>();
  final Controller c = Get.find();
  List<Product> products = [];
  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 400));

    // print(c.idcategory);
    products = [];
    if (c.idcategory == 0) {
      var url = Uri.parse(backend + 'products/');
      var response = await http.get(url);
      var json = jsonDecode(response.body);

      var productsListJson = json['products'];
      for (var p in productsListJson) {
        int id = p[0];
        String name = p[1];
        String descriptiton = p[2];
        int price = p[3];
        int quantity = p[3];
        Uint8List image = const Base64Codec().decode(p[5]);
        Product product = Product(
            id: id,
            title: name,
            price: price,
            size: quantity,
            description: descriptiton,
            image: image,
            color: Colors.green);

        products.add(product);
      }
    } else {
      var url1 = Uri.parse(backend + 'products/get/');
      var request1 = http.MultipartRequest('POST', url1);
      request1.fields
          .addAll({'id_category': c.idcategory.toString()}); // NEED MODIFY

      var response1 = await request1.send();
      if (response1.statusCode == 200) {
        var responseAwait1 = await response1.stream.bytesToString();
        var responseJson1 = jsonDecode(responseAwait1);
        var productsListJson = responseJson1["products"];
        for (var p in productsListJson) {
          int id = p[0];
          String name = p[1];
          String descriptiton = p[2];
          int price = p[3];
          int quantity = p[3];
          Uint8List image = const Base64Codec().decode(p[5]);
          Product product = Product(
              id: id,
              title: name,
              price: price,
              size: quantity,
              description: descriptiton,
              image: image,
              color: Colors.green);

          products.add(product);
        }
      }
    }

    setState(() {
      products;
    });
  }

  @override
  void initState() {
    super.initState();
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        //   child: Text("The Cat",
        //       style: Theme.of(context)
        //           .textTheme
        //           .headline5
        //           ?.copyWith(fontWeight: FontWeight.bold)),
        // ),
        // IconButton(
        //   icon: SvgPicture.asset(
        //     "assets/icons/search.svg",
        //     // By default our  icon color is white
        //     color: kTextColor,
        //   ),
        //   onPressed: loadList,
        // ),
        const Categories(),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: RefreshWidget(
                keyRefresh: keyRefresh2,
                onRefresh: loadList,
                child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kDefaultPaddin,
                      crossAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => ItemCard(
                          product: products[index],
                          press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  product: products[index],
                                ),
                              )),
                        )),
              )),
        ),
      ],
    );
  }

  // Future _getThingsOnStartup() async {
  //   await Future.delayed(const Duration(seconds: 2));
  // }
}

// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     @override
//     void initState() {
//       _getThingsOnStartup().then((value) {
//         print('Async done');
//       });
//       super.initState();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//           child: Text(
//             "Women",
//             style: Theme.of(context)
//                 .textTheme
//                 .headline5
//                 .copyWith(fontWeight: FontWeight.bold),
//           ),
//         ),
//         Categories(),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//             child: GridView.builder(
//                 itemCount: products.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: kDefaultPaddin,
//                   crossAxisSpacing: kDefaultPaddin,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemBuilder: (context, index) => ItemCard(
//                       product: products[index],
//                       press: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailsScreen(
//                               product: products[index],
//                             ),
//                           )),
//                     )),
//           ),
//         ),
//       ],
//     );
//   }
// }
