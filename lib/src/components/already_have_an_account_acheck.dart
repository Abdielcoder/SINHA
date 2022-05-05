import 'package:flutter/material.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';

import '../constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "¿ Aún no tienes una Cuenta ? ",
          style: TextStyle(color: MyColors.primaryColorDark),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
           "Registrate",
            style: TextStyle(
              color: MyColors.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
