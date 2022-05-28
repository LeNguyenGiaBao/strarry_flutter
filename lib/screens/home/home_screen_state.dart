import 'package:flutter/material.dart';
import 'package:strarry_flutter/screens/bill_history/bill_history_screen.dart';
import 'package:strarry_flutter/screens/cart/cart_screen.dart';
import 'package:strarry_flutter/screens/home/home_screen.dart';
import 'package:strarry_flutter/screens/profile/profile_screen.dart';
import 'package:strarry_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:strarry_flutter/size_config.dart';
import 'package:strarry_flutter/globals.dart' as globals;

class HomeStateScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeStateScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<HomeStateScreen> {
  int selectedIndex = 0;
  final Widget _home = const HomeScreen();
  final Widget _cart = CartScreen();
  final Widget _signin = const SignInScreen();
  final Widget _myProfile = const MyProfile();
  final Widget _billHistory = BillHistoryScreen();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: [
          bottomNavItem(),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Bill History",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  BottomNavigationBarItem bottomNavItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _home;
    } else if (selectedIndex == 1) {
      if (!globals.isSignIn) {
        return _signin;
      }
      return _cart;
    } else if (selectedIndex == 2) {
      if (!globals.isSignIn) {
        return _signin;
      }
      return _billHistory;
    } else {
      return _myProfile;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class MyEmails extends StatelessWidget {
  const MyEmails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Emails"));
  }
}
