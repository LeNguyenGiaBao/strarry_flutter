import 'package:flutter/material.dart';
import 'package:strarry_flutter/components/custom_surfix_icon.dart';
import 'package:strarry_flutter/components/default_button.dart';
import 'package:strarry_flutter/components/form_error.dart';
import '../../../constants.dart';
import 'package:strarry_flutter/size_config.dart';
import 'package:strarry_flutter/globals.dart' as globals;
import '../../../helper/keyboard.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../widget/refresh_widget.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final GlobalKey<RefreshIndicatorState> keyRefresh3 =
      GlobalKey<RefreshIndicatorState>();
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String email = "";
  String fullname = "";
  String phoneNumber = "";
  String address = "";
  var emailController = TextEditingController(text: "");
  var fullnameController = TextEditingController(text: "");
  var phoneNumberController = TextEditingController(text: "");
  var addressController = TextEditingController(text: "");

  Future loadList() async {
    await Future.delayed(const Duration(milliseconds: 0));

    var url = Uri.parse(backend + 'account/id/');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({'id_account': globals.idAccount});

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var AccountListJson = responseJson['account'];
      email = AccountListJson[1];
      fullname = AccountListJson[3];
      phoneNumber = AccountListJson[4];
      address = AccountListJson[5];

      emailController.text = email.toString();
      fullnameController.text = fullname.toString();
      phoneNumberController.text = phoneNumber.toString();
      addressController.text = address.toString();
      setState(() {
        email;
        fullname;
        phoneNumber;
        address;
      });
    } else {}
  }

  @override
  void initState() {
    loadList();
    super.initState();
  }

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

  Future<bool> isUpdated(name, phone, address, idaccount) async {
    var url = Uri.parse(backend + 'account/update/');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'name': name,
      'phone': phone,
      'address': address,
      'id_account': idaccount
    });

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseAwait = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseAwait);
      var accountListJson = responseJson['status'];
      if (accountListJson == true) {
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: RefreshWidget(
          keyRefresh: keyRefresh3,
          onRefresh: loadList,
          child: Column(
            children: [
              buildFirstNameFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildLastNameFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPhoneNumberFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildAddressFormField(),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: "Update",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    KeyboardUtil.hideKeyboard(context);
                    bool isSuccessUpdate = await isUpdated(
                        fullname, phoneNumber, address, globals.idAccount);
                    if (isSuccessUpdate == true) {
                      _showToast(context, isSuccessUpdate);
                    } else {
                      _showToast(context, isSuccessUpdate);
                    }
                  }
                },
              ),
            ],
          ),
        ));
  }

  void _showToast(BuildContext context, bool isSuccess) {
    final scaffold = ScaffoldMessenger.of(context);
    if (isSuccess == true) {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text('Update success'),
        ),
      );
    } else {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text('Update failed'),
        ),
      );
    }
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: addressController,
      onSaved: (newValue) => address = newValue.toString(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneNumberController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue.toString(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: fullnameController,
      onSaved: (newValue) => fullname = newValue.toString(),
      decoration: const InputDecoration(
        labelText: "Full Name",
        hintText: "Enter Your Fullname",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: emailController,
      onSaved: (newValue) => email = newValue.toString(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        enabled: false,
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
