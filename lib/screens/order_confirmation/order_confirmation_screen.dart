import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '/models/models.dart';
// import '/widgets/widgets.dart';
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
      body: Body(),
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
          Text("",
            // "${5} items",
            // "5 items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
