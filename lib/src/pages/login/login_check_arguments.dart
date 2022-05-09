import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import 'package:uber_clone_flutter/src/models/response_api.dart';
import 'package:uber_clone_flutter/src/models/user.dart';
import 'package:uber_clone_flutter/src/provider/users_provider.dart';
import 'package:uber_clone_flutter/src/utils/my_snackbar.dart';
import 'package:uber_clone_flutter/src/utils/progress_dialog.dart';
import 'package:uber_clone_flutter/src/utils/shared_pref.dart';

import '../../provider/push_notifications_provider.dart';

class LoginCheckArgumentsController {

  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  UsersProvider usersProvider = new UsersProvider();
  PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();
  SharedPref _sharedPref = new SharedPref();
  ProgressDialog _progressDialog;

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});
    print('Usuario: ${user.toJson()}');
    MyProgressDialog.show(context, 'Validando Información', false);

    if (user?.sessionToken != null) {
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, 'introduction', (introduction) => false);
    }
  }


}