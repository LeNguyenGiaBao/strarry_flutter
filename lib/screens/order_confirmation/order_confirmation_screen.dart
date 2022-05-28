import 'package:flutter/material.dart';
import 'components/back_to_home.dart';
import 'components/body.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  const OrderConfirmation({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: BackToHome(),
      extendBodyBehindAppBar: true,
      body: const Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Order Confirmation",
            style: TextStyle(color: Colors.black),
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
