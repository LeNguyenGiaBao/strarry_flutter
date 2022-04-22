import 'package:flutter/widgets.dart';
import 'package:strarry_flutter/screens/details/details_screen.dart';
import 'package:strarry_flutter/screens/home/home_screen.dart';
import 'package:strarry_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:strarry_flutter/screens/profile/profile_screen.dart';
import 'package:strarry_flutter/screens/home/home_screen_state.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  MyProfile.routeName: (context) => MyProfile(),
  HomeStateScreen.routeName: (context) => HomeStateScreen(),
  // DetailsScreen.routeName: (context) => DetailsScreen(),
};
