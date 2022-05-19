import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../api/environment.dart';
import '../../../../models/order.dart';
import '../../../../models/user.dart';
import '../../../../provider/orders_provider.dart';
import '../../../../utils/shared_pref.dart';
import '../inprogress/inprogress_cleaner_page.dart';
import '../onway/onway_cleaner_page.dart';


class FinishCleanearController{
  BuildContext context;
  Function refresh;
  Order order;
  IO.Socket socket;
  User user;
  SharedPref _sharedPref = new SharedPref();
  OrdersProvider _ordersProvider = new OrdersProvider();


  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // order = Order.fromJson(ModalRoute.of(context).settings.arguments as Map<String, dynamic>);



    print("SI ESTOY ENTRANDO AQUI....");
    // user = User.fromJson(await _sharedPref.read('user'));
    // _ordersProvider.init(context, user);
    // print('ORDEN: ${order.toJson()}');
    // checkGPS();
  }

  void dispose() {
    socket?.disconnect();
  }




}