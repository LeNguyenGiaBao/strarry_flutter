import 'package:flutter/material.dart';
import 'package:strarry_flutter/size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        backgroundColor: const Color.fromARGB(255, 243, 92, 92),
      ),
      body: const Body(),
    );
  }
}
