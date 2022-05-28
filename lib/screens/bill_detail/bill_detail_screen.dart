import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Bill.dart';
import 'components/body.dart';

class BillDetailScreen extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  const BillDetailScreen({Key? key, required this.bill}) : super(key: key);

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      extendBodyBehindAppBar: true,
      body: Body(
        bill: bill,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Bill Detail",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 243, 92, 92),
    );
  }
}
