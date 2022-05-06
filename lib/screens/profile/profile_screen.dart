import 'package:flutter/material.dart';
import 'components/body.dart';

class MyProfile extends StatelessWidget {
  static String routeName = "/profile";

  const MyProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: const Body(),
    );
  }
}
