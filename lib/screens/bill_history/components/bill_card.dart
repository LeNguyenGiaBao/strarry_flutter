import 'package:flutter/material.dart';
import 'package:strarry_flutter/models/Bill.dart';

class BillCard extends StatelessWidget {
  final Function press;

  const BillCard({
    Key? key,
    required this.bill,
    required this.press,
  }) : super(key: key);

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Row(
        children: [
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Date: May 28 2022",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "Bill ID: STRA${bill.id}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                  children: [
                    TextSpan(
                        text: "", style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(width: 30),
          Text(
            "\$${bill.price.toString()}",
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.red, fontSize: 20),
          ),
          const SizedBox(width: 20),
          const Align(
            child: Icon(Icons.arrow_forward_ios),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}
