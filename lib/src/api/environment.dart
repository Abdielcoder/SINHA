
import 'package:uber_clone_flutter/src/models/mercado_pago_credentials.dart';

class Environment {

  static const String API_DELIVERY = "3.217.149.82:3333";
  static const String API_KEY_MAPS = "AIzaSyAxip-78Cucl0wl2x7gF4F4MP_UhtC7iDw";
  //AIzaSyB2HQl3rxCmgvLVHT31gdAKkRR3d9CuSY0
  static MercadoPagoCredentials mercadoPagoCredentials = MercadoPagoCredentials(
      publicKey: 'TEST-72425051-a087-4e67-9fc0-95e0097cad62',
      accessToken: 'TEST-6465507329858608-031923-46b71ba7d0e8e1699308e4744fe7e46d-802791075'
  );

}