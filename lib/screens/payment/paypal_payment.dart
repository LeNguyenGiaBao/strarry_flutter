import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../controller.dart';
import 'package:get/get.dart';

final Controller c = Get.find();

class PaypalPayment extends StatelessWidget {
  // final Controller c = Get.find();
  final double amount;
  final String currency;
  PaypalPayment({Key? key, required this.amount, required this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: WebView(
        initialUrl:
            'http://10.0.2.2:3000/createpaypalpayment?amount=$amount&currency=$currency',
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: Set()
          ..add(Factory<DragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
        onPageFinished: (value) {
          print(value);
        },
        navigationDelegate: (NavigationRequest request) async {
          if (request.url.contains('http://return_url/?status=success')) {
            print('return url on success');
            _showToast(context, true);
            Navigator.pop(context);
          }
          if (request.url.contains('http://cancel_url')) {
            Navigator.pop(context);
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  void _showToast(BuildContext context, bool isSuccess) {
    final scaffold = ScaffoldMessenger.of(context);
    if (isSuccess == true) {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text('Payment success'),
        ),
      );
    } else {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text('Sign in failed'),
        ),
      );
    }
  }
}
