import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strarry_flutter/models/Bill.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/screens/bill_detail/bill_detail_screen.dart';
import '../../../size_config.dart';
import 'bill_card.dart';
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
  List<Bill> bills = [];
  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 400));

    bills = [];
    var url = Uri.parse(backend + 'bill/');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({'id_account': globals.idAccount.toString()});

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var billListJson = responseJson['bill'];

      for (var i in billListJson) {
        int idBill = i[0];
        int idAccount = i[1];
        int totalMoney = i[2];
        int discount = i[3];
        String phone = i[4];
        String address = i[5];
        Bill bill = Bill(
            id: idBill,
            idAccount: idAccount,
            price: totalMoney,
            discount: discount,
            phone: phone,
            address: address);
        bills.add(bill);
      }

      setState(() {
        bills;
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
        keyRefresh: keyRefresh2,
        onRefresh: loadList,
        child: ListView.builder(
          itemCount: bills.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(bills[index].id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  bills.removeAt(index);
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
              child: BillCard(
                bill: bills[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillDetailScreen(
                        bill: bills[index],
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
