import 'package:flutter/material.dart';
import 'package:strarry_flutter/components/custom_surfix_icon.dart';
import 'package:strarry_flutter/components/default_button.dart';
import 'package:strarry_flutter/components/form_error.dart';
import 'package:strarry_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:strarry_flutter/helper/keyboard.dart';

import '../../../constants.dart';
// import '../../../size_config.dart';
import 'package:strarry_flutter/size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? abc;
  // String? confirm_password;
  bool remember = false;
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
    SizeConfig().init(context);
    return Form(
      key: _formKey,
      child: Column(children: [
        buildEmailFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildPasswordFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildConformPassFormField(),
        FormError(errors: errors),
        SizedBox(height: getProportionateScreenHeight(40)),
        DefaultButton(
          text: "Sign Up",
          press: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              KeyboardUtil.hideKeyboard(context);
              bool isSuccessSignUp = await isSignup(email, password);
              if (isSuccessSignUp == true) {
                Navigator.pushNamed(context, SignInScreen.routeName);
              }
              // Navigator.pushNamed(context, SignInScreen.routeName);
              // if all are valid then go to success screen

            }
          },
        ),
      ]),
    );
  }

  Future<bool> isSignup(email, password) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    // var request = http.Request('POST', Uri.parse(backend + 'signup/'));
    var request = http.MultipartRequest('POST', Uri.parse(backend + 'signup/'));
    request.fields.addAll({'email': email, 'password': password});
    // request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var signupSuccess = responseJson["success"];
      if (signupSuccess == 'true') {
        // int idAccount = responseJson["id"];
        return true;
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }

    return false;
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => abc = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == abc) {
          removeError(error: kMatchPassError);
        }
        abc = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
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
        password = value;
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
      decoration: const InputDecoration(
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
        return;
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
      decoration: const InputDecoration(
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
