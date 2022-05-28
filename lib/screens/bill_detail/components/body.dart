import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Bill.dart';
import 'package:strarry_flutter/models/BillProduct.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/models/Product.dart';
import 'package:strarry_flutter/screens/bill_detail/components/bill_detail_card.dart';
import '../../../size_config.dart';
import 'package:strarry_flutter/constants.dart';
import '../../../controller.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.bill,
  }) : super(key: key);
  final Bill bill;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<RefreshIndicatorState> keyRefresh2 =
      GlobalKey<RefreshIndicatorState>();
  final Controller c = Get.find();
  String? email = "ttkien2035@gmail.com";
  List<BillProduct> billProductList = [];
  var children = <Widget>[];
  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 400));

    billProductList = [];
    children = <Widget>[];
    var url = Uri.parse(backend + 'bill_product/');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({'id': widget.bill.id.toString()});

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var billProductListJson = responseJson['bill_product'];

      for (var i in billProductListJson) {
        int idProduct = i[0];
        String name = i[1];
        String description = i[2];
        int price = i[3];
        int quantity = i[4];
        Uint8List image = const Base64Codec().decode(i[5]);
        int numItem = i[9];
        Product product = Product(
            id: idProduct,
            title: name,
            price: price,
            size: quantity,
            description: description,
            image: image,
            color: Colors.green);
        BillProduct billProduct =
            BillProduct(product: product, numOfItem: numItem);
        billProductList.add(billProduct);
      }
      for (var i = 0; i < billProductList.length; i++) {
        children.add(BillDetailCard(
          billProduct: billProductList[i],
          press: () {},
        ));
      }

      setState(() {
        billProductList;
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Email ${email.toString()},',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 10),
              Text(
                'Bill ID: STRA${widget.bill.id}',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                'Total Price: \$${widget.bill.price.toString()}',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                'Phone: \$${widget.bill.phone.toString()}',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                'Address: \$${widget.bill.address.toString()}',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Text(
                'Order Detail',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 5),
            ]),
          ),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          )
        ],
      ),
    );
  }
}
