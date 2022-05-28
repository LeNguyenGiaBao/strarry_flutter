import 'package:flutter/material.dart';
import 'components/body.dart';

class MyProfile extends StatelessWidget {
  static String routeName = "/profile";

  const MyProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color.fromARGB(255, 30, 31, 31),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 92, 92),
      ),
      body: const Body(),
    );
  }
}
