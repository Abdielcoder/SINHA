import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../api/environment.dart';
import '../../../../models/order.dart';
import '../../../../models/user.dart';
import '../../../../provider/orders_provider.dart';
import '../../../../utils/shared_pref.dart';


class RequestCleanerCOntroller{
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
    if(status=="ONWAY"){
      print("Navego a siguiente pantalla");
    }else{
      print("Algo paso mal sigo en la pantalla");
    }

    refresh();
  }


}