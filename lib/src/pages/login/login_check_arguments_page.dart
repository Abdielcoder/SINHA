import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';
import '../../models/response_api.dart';
import '../../models/user.dart';
import '../../provider/push_notifications_provider.dart';
import '../../provider/users_provider.dart';
import '../../utils/my_snackbar.dart';
import '../../utils/shared_pref.dart';

import 'loggin_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_check_arguments.dart';

class LoginCheckArgumentsPage extends StatefulWidget {
  const LoginCheckArgumentsPage({Key key}) : super(key: key);

  @override
  _LoginCheckArgumentsPageState createState() => _LoginCheckArgumentsPageState();
}



class _LoginCheckArgumentsPageState extends State<LoginCheckArgumentsPage> {
  LoginCheckArgumentsController _con = new LoginCheckArgumentsController();

  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 15,
            ),

          ],
        ),
      ),
    );
  }

}
