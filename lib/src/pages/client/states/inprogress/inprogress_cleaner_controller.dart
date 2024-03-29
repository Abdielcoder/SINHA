import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uber_clone_flutter/src/pages/client/states/finish/finish_cleaner_page.dart';

import '../../../../api/environment.dart';
import '../../../../models/order.dart';
import '../../../../models/user.dart';
import '../../../../provider/orders_provider.dart';
import '../../../../utils/shared_pref.dart';
import '../inprogress/inprogress_cleaner_page.dart';
import '../onway/onway_cleaner_page.dart';


class InprogressCleanerController{
  BuildContext context;
  Function refresh;
  Order order;
  IO.Socket socket;
  User user;
  SharedPref _sharedPref = new SharedPref();
  OrdersProvider _ordersProvider = new OrdersProvider();
  double latFromShared;
  double lngFromShared;
  String addressName;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // order = Order.fromJson(ModalRoute.of(context).settings.arguments as Map<String, dynamic>);

    socket = IO.io('http://${Environment.API_DELIVERY}/orders/status', <String, dynamic> {
      'transports': ['websocket'],
      'autoConnect': false
    });
    socket.connect();
    int idStatusOrder =1;

    socket.on('status/${idStatusOrder}', (data) {
      print('DATA EMITIDA: ${data}');

      addStatus(data['statusOrder'],);

    });
    print("SI ESTOY ENTRANDO AQUI....");
    // user = User.fromJson(await _sharedPref.read('user'));
    // _ordersProvider.init(context, user);
    // print('ORDEN: ${order.toJson()}');
    // checkGPS();

    Map<String, dynamic> map = await _sharedPref.read('service');
    latFromShared = map['lat'];
    lngFromShared = map['lng'];

    _getLocation();
  }
  _getLocation() async
  {

    List<Placemark> addresses = await
    placemarkFromCoordinates(latFromShared,lngFromShared);
    String direction = addresses[0].thoroughfare;
    String street = addresses[0].subThoroughfare;
    String city = addresses[0].locality;
    String department = addresses[0].administrativeArea;
    String country = addresses[0].country;
    addressName = '$direction #$street, $city, $department';
    // var first = addresses.first;
    print("SERVICEX-2 : ${addressName} ");
  }
  void dispose() {
    socket?.disconnect();
  }

  //SEND OBJECT DATA TO SOKECT LISTENER
  // void emitPosition() {
  //   socket.emit('position', {
  //     'id_order': order.id,
  //     // 'lat': _position.latitude,
  //     // 'lng': _position.longitude,
  //   });
  // }
  void addStatus(String status) {
    print("ENTRE METODO ADD STATUS");
    if(status=="FINISH"){
      print("Navego a siguiente pantalla");
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new FinishCleanerPage(),
        ),
      );

      refresh();
    }else{
      print("Algo paso mal sigo en la pantalla");
    }


  }


}