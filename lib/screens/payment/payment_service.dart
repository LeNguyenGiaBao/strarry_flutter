import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  final int amount;
  final String url;

  PaymentService({
    this.amount = 10,
    this.url = '',
  });
  static init() {
    StripePayment.setOptions(
      StripeOptions(
          publishableKey:
              'pk_test_51L0rOFLDy7P2snZ4JZhsdma4T5njeJoMwND3qWXgNlo7EoMPRoJWeZsHQMN5pHOHCRYvRS9FhHvyDrgUIKDtIsjt0089RtDf6c',
          androidPayMode: 'test',
          merchantId: 'test'),
    );
  }

  Future<PaymentMethod?> createPaymentMethod() async {
    print("mound , $amount");
    PaymentMethod paymentMethod =
        await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    );
    return paymentMethod;
  }

  Future<void> processPayment(PaymentMethod paymentMethod) async {
    //   final http.Response response1 = await http.post(
    //     Uri.parse('$url?amount=$amount&currency=USDpay=${paymentMethod.id}'),
    //   );
    // }
    // if (response1.body != 'error')
    // {final pay}
  }
}
