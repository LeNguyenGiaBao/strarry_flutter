import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strarry_flutter/routes.dart';
import 'package:strarry_flutter/constants.dart';
// import 'package:strarry_flutter/screens/home/home_screen.dart';
import 'package:strarry_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:strarry_flutter/screens/home/home_screen_state.dart';

void main() {
  // loadList();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeStateScreen(),
      routes: routes,
    );
  }
}
