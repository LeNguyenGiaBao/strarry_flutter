import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/svg.dart';

import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/screens/details/details_screen.dart';
import 'package:strarry_flutter/widget/refresh_widget.dart';

import 'categorries.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<RefreshIndicatorState> keyRefresh2  = new GlobalKey<RefreshIndicatorState>();

  List<Product> products = [];
  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 400));

    products = [];
    var url = Uri.parse('http://10.0.2.2:8000/products/');
    var response = await http.get(url);
    var json = jsonDecode(response.body);

    var productsListJson = json['products'];
    for (var p in productsListJson) {
      int id = p[0];
      String name = p[1];
      Product product = newProduct(id, name);

      products.add(product);
    }
    setState(() {
      products;
    });
  }

  Product newProduct(int id, String name) {
    return new Product(
        id: id,
        title: name,
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/images/bag_1.png",
        color: Color(0xFF3D82AE));
  }

  @override
  void initState() {
    _getThingsOnStartup().then((value) async {
      //   var request =
      //     http.Request('GET', Uri.parse('http://10.0.2.2:8000/products/'));

      // http.StreamedResponse response = await request.send();

      // if (response.statusCode == 200) {
      //   var products = response["products"];
      //   print(products);
      //   print(await response.stream.bytesToString()["product"]);
      // } else {
      //   print(response.reasonPhrase);
      // }

    });
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
        //   child: Text(
        //     "Women",
        //     style: Theme.of(context)
        //         .textTheme
        //         .headline5
        //         .copyWith(fontWeight: FontWeight.bold)
        //   ),
        // ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: loadList,
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: RefreshWidget(
              keyRefresh: keyRefresh2,
              onRefresh: loadList,
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            )
          ),
        ),
      ],
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }
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
