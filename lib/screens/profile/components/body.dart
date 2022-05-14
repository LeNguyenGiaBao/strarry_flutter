import 'package:flutter/material.dart';
import 'package:strarry_flutter/screens/home/home_screen_state.dart';
import 'package:strarry_flutter/screens/complete_profile/complete_profile_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:strarry_flutter/globals.dart' as globals;

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () =>
                {Navigator.pushNamed(context, CompleteProfileScreen.routeName)},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              globals.isSignIn = false;
              globals.idAccount = "0";
              _showToast(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeStateScreen.routeName, (r) => false);
            },
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Loged Out'),
      ),
    );
  }
}
