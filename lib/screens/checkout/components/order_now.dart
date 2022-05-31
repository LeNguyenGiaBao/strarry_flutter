import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strarry_flutter/components/default_button.dart';
import 'package:strarry_flutter/screens/order_confirmation/order_confirmation_screen.dart';
import '../../../controller.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'dart:convert';
import 'package:strarry_flutter/globals.dart' as globals;

class OrderNow extends StatelessWidget {
  OrderNow({
    Key? key,
  }) : super(key: key);
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => (Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "\$${c.money.toString()}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Order Now",
                    press: () async {
                      bool isSuccessInsertBill = await isInsertBill(
                          globals.idAccount.toString(),
                          c.money.toString(),
                          '0',
                          c.phone.toString(),
                          c.address.toString());
                      if (isSuccessInsertBill == true) {
                        Navigator.pushNamed(
                            context, OrderConfirmation.routeName);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> isInsertBill(idAccount, price, discount, phone, address) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(backend + 'bill/insert/'));
    request.fields.addAll({
      'id_account': idAccount,
      'price': price,
      'discount': discount,
      'phone': phone,
      'address': address
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var billSuccess = responseJson["success"];
      if (billSuccess == 'true') {
        int idBill = responseJson["id"];
        c.setIdBill(idBill);
        return true;
      }
    } else {
      return false;
    }
    return false;
  }
}
