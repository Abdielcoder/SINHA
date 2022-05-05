import 'package:flutter/material.dart';


import 'package:flutter_svg/svg.dart';
import 'package:uber_clone_flutter/src/components/already_have_an_account_acheck.dart';
import 'package:uber_clone_flutter/src/components/rounded_button.dart';
import 'package:uber_clone_flutter/src/components/rounded_input_field.dart';
import 'package:uber_clone_flutter/src/components/rounded_password_field.dart';

import '../../Login/login_screen.dart';
import 'background.dart';
import 'or_divider.dart';
import 'social_icon.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "INICIA",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/img/login_art.png",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Tú Correo",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "Iniciar",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
