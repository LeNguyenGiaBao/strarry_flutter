import 'package:flutter/material.dart';
import 'payment_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = "/payment";
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod? paymentMethod;
  @override
  void initState() {
    super.initState();
    PaymentService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stripe test"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '10\$',
            style: TextStyle(fontSize: 50),
          ),
          SizedBox(height: 25),
          Center(
            child: ElevatedButton(
              child: Text('Add a Payment method'),
              style: ElevatedButton.styleFrom(fixedSize: Size(200, 40)),
              onPressed: () async {
                paymentMethod = await PaymentService().createPaymentMethod();
                // print(paymentMethod!.id);
                // PaymentService().processPayment(paymentMethod!);
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text('complete  Payment now'),
              style: ElevatedButton.styleFrom(fixedSize: Size(200, 40)),
              onPressed: () async {
                // print(paymentMethod!.id);
                // PaymentService().processPayment(paymentMethod!);
              },
            ),
          )
        ],
      ),
    );
  }
}
