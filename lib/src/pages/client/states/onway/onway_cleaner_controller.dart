import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart' as location;
import '../../../../api/environment.dart';
import '../../../../models/directions_model.dart';
import '../../../../models/order.dart';
import '../../../../models/user.dart';
import '../../../../provider/orders_provider.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/shared_pref.dart';
import '../inprogress/inprogress_cleaner_page.dart';
import 'package:uber_clone_flutter/src/api/environment.dart';
import 'package:uber_clone_flutter/src/models/order.dart';
import 'package:uber_clone_flutter/src/models/user.dart';
import 'package:uber_clone_flutter/src/provider/orders_provider.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';
import 'package:uber_clone_flutter/src/utils/shared_pref.dart';



class OnWayCleanerController{

  BuildContext context;
  Function refresh;
  Order order;
  IO.Socket socket;
  // IO.Socket socket2;
  User user;
  SharedPref _sharedPref = new SharedPref();
  OrdersProvider _ordersProvider = new OrdersProvider();
  Position _position;
  double lat;
  double lng;
  double latSockectString;
  double lngSockectString;
  double latSockect;
  double lngSockect;
  String addressName;
  LatLng addressLatLng;
  double latFromShared;
  double lngFromShared;
  String idClientSharedP;
  String idAddressSharedP;
  String idClientSokect;
  String idAddressSokect;

  CameraPosition initialPosition = CameraPosition(
      target: LatLng(32.482150, -116.930685),
      zoom: 14
  );

  Completer<GoogleMapController> _mapController = Completer();

  BitmapDescriptor deliveryMarker;
  BitmapDescriptor homeMarker;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};



  Set<Polyline> polylines = {};
  List<LatLng> points = [];
  List<String> dataSokect = [];




  double _distanceBetween;




  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // order = Order.fromJson(ModalRoute.of(context).settings.arguments as Map<String, dynamic>);

    // socket = IO.io('http://${Environment.API_DELIVERY}/orders/lat', <String, dynamic> {
    //   'transports': ['websocket'],
    //   'autoConnect': false
    // });

    Map<String, dynamic> map = await _sharedPref.read('service');
    latFromShared = map['lat'];
    lngFromShared = map['lng'];
    idClientSharedP = map['idClient'];
    idAddressSharedP = map['idAddress'];

    socket = IO.io('http://${Environment.API_DELIVERY}/orders/status', <String, dynamic> {
      'transports': ['websocket'],
      'autoConnect': false
    });

    // socket2 = IO.io('http://${Environment.API_DELIVERY}/orders/lat', <String, dynamic> {
    //   'transports': ['websocket'],
    //   'autoConnect': false
    // });

    socket.connect();
   // socket2.connect();
    int idStatusOrder =1;

    //leer data
    socket.on('status/${idStatusOrder}', (data) {
      print('DATX EMITIDA: ${data}');
      print('DATX status: ${data['statusOrder']}');


      latSockectString = data['lat'];
      lngSockectString = data['lng'];
      print('DATX lat: $latSockectString');
      print('DATX lng: $lngSockectString');
      updateLocation(data['lat'],data['lng']);
      addStatus(data['statusOrder'],);
      _getTimeTravel(data['lat'],data['lng'],latFromShared,lngFromShared);
      print( _getTimeTravel(data['lat'],data['lng'],latFromShared,lngFromShared));
    });

    // socket2.on('lat/${idStatusOrder}', (data) {
    //   print('DATX EMITIDA: ${data}');
    //   print('DATX lat: ${data['lat']}');
    //   print('DATX lng: ${data['lng']}');
    //   // addStatus(data['lat'],);
    // });



   // order = Order.fromJson(ModalRoute.of(context).settings.arguments as Map<String, dynamic>);
    deliveryMarker = await createMarkerFromAsset('assets/img/pinwash.png');
    homeMarker = await createMarkerFromAsset('assets/img/carrowash.png');
  //  print('ORDEN ###: ${order.toJson()}');





    // socket.on('lat/${idStatusOrder}', (data) {
    //   print('DATx COORDENADAS aaa : ~ ${data}');
    //   dataSokect = data;
    //   //Capture the data
    //   //addStatus(data['statusOrder']);
    // });


    print("SI ESTOY ENTRANDO AQUI....");
    // user = User.fromJson(await _sharedPref.read('user'));
    // _ordersProvider.init(context, user);
    // print('ORDEN: ${order.toJson()}');
    // checkGPS();

    user = User.fromJson(await _sharedPref.read('user'));
    _ordersProvider.init(context, user);
 //   print('ORDEN: ${order.toJson()}');
    //checkGPS();
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
    if(status=="ARRIVE"){
      print("Navego a siguiente pantalla");
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new InprogressCleanerPage(),
        ),
      );

      refresh();
    }else{
      print("Algo paso mal sigo en la pantalla");
    }


  }
  void isCloseToDeliveryPosition() {
    _distanceBetween = Geolocator.distanceBetween(
        _position.latitude,
        _position.longitude,
        order.address.lat,
        order.address.lng
    );

    print('-------- DISTANCIA ${_distanceBetween} ----------');
  }


  Future<void> setPolylines(LatLng from, LatLng to) async {
    PointLatLng pointFrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointTo = PointLatLng(to.latitude, to.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        Environment.API_KEY_MAPS,
        pointFrom,
        pointTo
    );
   // int count = 0;
   //  for(PointLatLng point in result.points) {
   //    count += 1;
   //
   //    points.add(LatLng(point.latitude, point.longitude));
   //
   //
   //    print('CUENTA $count');
   //  }
    if (result.points.isNotEmpty) {
      points = []; // EMPTY THE VARIABLE <---------
      result.points.forEach((PointLatLng point) {
        points.add(LatLng(point.latitude, point.longitude));
      });
    }
    Polyline polyline = Polyline(
        geodesic: false,
        polylineId: PolylineId('poly'),
        color: MyColors.primaryColor,
        points: points,
        width: 6
    );
    refresh();
    polylines.add(polyline);



  }

  Future _getTimeTravel(double latW, double lngW,double latS, double lngS)async{

    //Response response=await dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$latW,$lngW&destinations=$latS,$lngS&key=AIzaSyAxip-78Cucl0wl2x7gF4F4MP_UhtC7iDw");

    const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

      Dio _dio;

    Response response =await _dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$latW,$lngW&destinations=$latS,$lngS&key=AIzaSyAxip-78Cucl0wl2x7gF4F4MP_UhtC7iDw");

    //DirectionsRepository({Dio dio}) : _dio = dio ?? Dio();

    // final response = await _dio.get(
    // _baseUrl,
    // queryParameters: {
    // 'origin': '$latW,$lngW',
    // 'destination': '$latS,$lngS',
    // 'key': 'AIzaSyAxip-78Cucl0wl2x7gF4F4MP_UhtC7iDw',
    // },
    // );

    // Check if response is successful
    if (response.statusCode == 200) {
      print('LOCALEX');
      // var ss = Directions.fromMap(response.data);
      // print('LOCALEX $ss');
    return Directions.fromMap(response.data);

    }
    return null;
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
    print("SERVICEX-1 : ${addressName} ");
  }


  /*Future<void> setPolylines(LatLng from, LatLng to) async {
    PointLatLng pointFrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointTo = PointLatLng(to.latitude, to.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        Environment.API_KEY_MAPS,
        pointFrom,
        pointTo
    );

    for(PointLatLng point in result.points) {
      points.add(LatLng(point.latitude, point.longitude));
    }

    Polyline polyline = Polyline(
        polylineId: PolylineId('poly'),
        color: Colors.cyan,
        points: points,
        width: 6
    );

    polylines.add(polyline);

    refresh();
  }*/

  void addMarker(
      String markerId,
      double lat,
      double lng,
      String title,
      String content,
      BitmapDescriptor iconMarker) {

    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title, snippet: content)
    );

    markers[id] = marker;

    refresh();
  }

  // /*void selectRefPoint() {
  //   Map<String, dynamic> data = {
  //     'address': addressName,
  //     'lat': latFromShared,
  //
  //     'lng': lngFromShared,
  //   };
  //
  //   Navigator.pop(context, data);
  // }*/

  Future<BitmapDescriptor> createMarkerFromAsset(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(configuration, path);
    return descriptor;
  }

  // Future<Null> setLocationDraggableInfo() async {
  //
  //   if (initialPosition != null) {
  //     double lat = initialPosition.target.latitude;
  //     double lng = initialPosition.target.longitude;
  //
  //     List<Placemark> address = await placemarkFromCoordinates(lat, lng);
  //
  //     if (address != null) {
  //       if (address.length > 0) {
  //         String direction = address[0].thoroughfare;
  //         String street = address[0].subThoroughfare;
  //         String city = address[0].locality;
  //         String department = address[0].administrativeArea;
  //         String country = address[0].country;
  //         addressName = '$direction #$street, $city, $department';
  //         addressLatLng = new LatLng(lat, lng);
  //         // print('LAT: ${addressLatLng.latitude}');
  //         // print('LNG: ${addressLatLng.longitude}');
  //
  //         refresh();
  //       }
  //     }
  //
  //   }
  // }

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }



  void updateLocation(double lat, double lng) async {


    try {

      //await _determinePosition(); // OBTENER LA POSICION ACTUAL Y TAMBIEN SOLICITAR LOS PERMISOS


      print('DATX1 lng: $lat');
      print('DATX2 lng: $lng');
      animateCameraToPosition(lat, lng);
      addMarker(
          'delivery',
          lat,
          lng,
          'Tu Lavador',
          '',
          deliveryMarker
      );


      addMarker(
          'home',
          latFromShared,
          lngFromShared,
          'Lugar de entrega',
          '',
          homeMarker
      );

      LatLng from = new LatLng(lat, lng);
      LatLng to = new LatLng( latFromShared,  lngFromShared);
      setPolylines(from,to);
      _getLocation();

      refresh();
    } catch(e) {
      print('Error: $e');
    }
  }

  // void call() {
  //   launch("tel://${order.client.phone}");
  // }

/*  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationEnabled) {
      updateLocation();
    }
    else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS) {
        updateLocation();
      }
    }
  }*/

  Future animateCameraToPosition(double lat, double lng) async {
    GoogleMapController controller = await _mapController.future;
    if (controller != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(lat, lng),
              zoom: 13,
              bearing: 0
          )
      ));
    }
  }

  // void close() {
  //   Navigator.pop(context);
  // }
  //
  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   return await Geolocator.getCurrentPosition();
  // }


}
class Element {
  final String text;
  final int value;

  Element.fromJson(dynamic json)
      : text = json['text'] as String,
        value = json['value'] as int;

  @override
  String toString() => 'text: $text\nvalue: $value';
}