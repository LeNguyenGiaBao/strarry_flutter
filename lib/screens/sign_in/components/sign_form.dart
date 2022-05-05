import 'package:flutter/material.dart';
import 'package:strarry_flutter/components/custom_surfix_icon.dart';
// import 'package:strarry_flutter/components/form_error.dart';
import 'package:strarry_flutter/helper/keyboard.dart';
// import 'package:strarry_flutter/screens/forgot_password/forgot_password_screen.dart';
// import 'package:strarry_flutter/screens/login_success/login_success_screen.dart';

import 'package:http/http.dart' as http;
import 'package:strarry_flutter/screens/home/home_screen.dart';
import 'package:strarry_flutter/screens/home/home_screen_state.dart';
import 'package:strarry_flutter/screens/sign_up/sign_up_screen.dart';

import 'dart:convert';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:strarry_flutter/globals.dart' as globals;

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () {}, //Navigator.pushNamed(
                //context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          // FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Sign In",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                bool isSuccessLogin = await isLogin(email, password);
                if (isSuccessLogin == true) {
                  globals.isSignIn = true;
                  // Navigator.pushNamed(context, HomeStateScreen.routeName);
                  Navigator.pop(context);
                }
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          GestureDetector(
            onTap: () async {
              Navigator.pushNamed(context, SignUpScreen.routeName);
            }, //Navigator.pushNamed(
            //context, ForgotPasswordScreen.routeName),
            child: const Text(
              "Don't have an account yet? Sign Up",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
          // DefaultButton(
          //   text: "Sign Up",
          //   press: () async {
          //     Navigator.pushNamed(context, SignUpScreen.routeName);
          //   },
          // ),
        ],
      ),
    );
  }

  Future<bool> isLogin(email, password) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(backend + 'signin/'));
    request.fields.addAll({
      'email': email,
      'password': password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var loginSuccess = responseJson["success"];
      if (loginSuccess == 'true') {
        int idAccount = responseJson["id"];
        globals.idAccount = idAccount.toString();
        return true;
      }
    } else {
      // print(response.reasonPhrase);
      return false;
    }

    return false;
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
