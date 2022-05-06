import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strarry_flutter/counter_provider.dart';
import '../../../constants.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({Key? key}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  void initValue(BuildContext context) {}
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CounterProvider>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(create: (context) => CounterProvider(),
    // child: Row(
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            int currentValue =
                Provider.of<CounterProvider>(context, listen: false).counter;
            if (currentValue > 1) {
              context.read<CounterProvider>().sub();
              // widget.onChanged(numOfItems);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            context.watch<CounterProvider>().counter.toString(),
            // "0",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              context.read<CounterProvider>().add();
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData? icon, required Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: () {
          press();
        },
        child: Icon(icon),
      ),
    );
  }
}
