import 'package:flutter/material.dart';
import 'package:strarry_flutter/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth * 0.4,
                      child: Text(
                        "Strarry",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(28),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo-removebg-preview.png',
                      width: SizeConfig.screenWidth * 0.4,
                    )
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                const SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
