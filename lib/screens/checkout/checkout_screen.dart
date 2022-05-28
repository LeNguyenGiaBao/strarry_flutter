import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/order_now.dart';
import 'components/body.dart';

// import '/blocs/blocs.dart';
// import '/widgets/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: OrderNow(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Check out",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${5} items",
            // "5 items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 243, 92, 92),
    );
  }
}
