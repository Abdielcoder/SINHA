import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber_clone_flutter/src/models/order.dart';
import 'package:uber_clone_flutter/src/models/user.dart';
import 'package:uber_clone_flutter/src/pages/delivery/orders/detail/delivery_orders_detail_page.dart';
import 'package:uber_clone_flutter/src/pages/login/login_page.dart';
import 'package:uber_clone_flutter/src/provider/orders_provider.dart';
import 'package:uber_clone_flutter/src/utils/shared_pref.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../provider/users_provider.dart';

class DrawerScreenController {

  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  Function refresh;
  User user;
  UsersProvider usersProvider = new UsersProvider();

  Future init(BuildContext context) async {
    this.context = context;
    this.refresh = refresh;
    await usersProvider.init(context);
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }




  void logout() {
    logoutw(user.id);
  }
  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
  void logoutw(String idUser) async {
    UsersProvider usersProvider = new UsersProvider();
    usersProvider.init(context);
    print('logout id value 2: ${idUser}');
    await usersProvider.logout(idUser);
    await remove('user');
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LoginPage(),
      ),
    );
  }

  void goToCategoryCreate() {
    Navigator.pushNamed(context, 'restaurant/categories/create');
    refresh();
  }

  void goToProductCreate() {
    Navigator.pushNamed(context, 'restaurant/products/create');
    refresh();
  }

  // void openDrawer() {
  //   key.currentState.openDrawer();
  //   refresh();
  // }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
    refresh();
  }

}