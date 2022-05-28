import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:strarry_flutter/models/Bill.dart';
// import '/models/models.dart';
// import '/widgets/widgets.dart';
import 'components/body.dart';

class BillDetailScreen extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  const BillDetailScreen({Key? key, required this.bill}) : super(key: key);

  final Bill bill;
  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (context) => const BillDetailScreen(bill: null,),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      extendBodyBehindAppBar: true,
      body: Body(bill: this.bill,),
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
            // "${5} items",
            // "5 items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 243, 92, 92),
    );
  }
}
