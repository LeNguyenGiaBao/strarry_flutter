import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strarry_flutter/counter_provider.dart';
import 'package:strarry_flutter/routes.dart';
import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/screens/home/home_screen.dart';
import 'package:strarry_flutter/screens/home/home_screen_state.dart';
import 'package:strarry_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:strarry_flutter/size_config.dart';
import 'package:strarry_flutter/screens/payment/payment_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeStateScreen(),
        // home: PaymentScreen(),
        routes: routes,
      ),
    );
  }
}
