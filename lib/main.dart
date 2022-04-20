import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:strarry_flutter/constants.dart';
import 'package:strarry_flutter/screens/home/home_screen.dart';

void main() {
  // loadList();
  runApp(MyApp());
}

Future<void> loadList() async {
  var request =
      http.Request('GET', Uri.parse('http://10.0.2.2:8000/products/'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
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
      home: HomeScreen(),
    );
  }
}
