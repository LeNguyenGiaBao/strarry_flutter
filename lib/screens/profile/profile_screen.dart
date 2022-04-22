import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strarry_flutter/constants.dart';
import 'components/body.dart';

class MyProfile extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(),
    );
  }
}
