import 'package:flutter/widgets.dart';
import 'package:strarry_flutter/screens/home/home_screen.dart';
import 'package:strarry_flutter/screens/complete_profile/complete_profile_screen.dart';
import 'package:strarry_flutter/screens/otp/otp_screen.dart';
import 'package:strarry_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:strarry_flutter/screens/profile/profile_screen.dart';
import 'package:strarry_flutter/screens/home/home_screen_state.dart';
import 'package:strarry_flutter/screens/sign_up/sign_up_screen.dart';
import 'package:strarry_flutter/screens/cart/cart_screen.dart';
import 'package:strarry_flutter/screens/checkout/checkout_screen.dart';
import 'package:strarry_flutter/screens/order_confirmation/order_confirmation_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => const SignInScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  MyProfile.routeName: (context) => const MyProfile(),
  HomeStateScreen.routeName: (context) => const HomeStateScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  CheckoutScreen.routeName: (context) => const CheckoutScreen(),
  OrderConfirmation.routeName: (context) => const OrderConfirmation(),
  // DetailsScreen.routeName: (context) => DetailsScreen(context),
};
