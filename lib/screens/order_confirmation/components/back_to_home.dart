import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strarry_flutter/components/default_button.dart';
import 'package:strarry_flutter/screens/home/home_screen_state.dart';
import '../../../constants.dart';
import '../../../controller.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:strarry_flutter/globals.dart' as globals;

class BackToHome extends StatelessWidget {
  BackToHome({
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
                    text: "Back to Home",
                    press: () async {
                      bool isDeleteCart1 =
                          await isDeleteCart(globals.idAccount.toString());
                      if (isDeleteCart1 == true) {
                        Navigator.pushNamed(context, HomeStateScreen.routeName);
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

  Future<bool> isDeleteCart(idAccount) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(backend + 'cart/delete/'));
    request.fields.addAll({
      'id_account': idAccount,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var signupSuccess = responseJson["success"];
      if (signupSuccess == 'true') {
        return true;
      }
    } else {
      return false;
    }
    return false;
  }
}
