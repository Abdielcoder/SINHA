import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:uber_clone_flutter/src/models/addresss.dart';
import 'package:uber_clone_flutter/src/models/cards_client.dart';
import 'package:uber_clone_flutter/src/models/order.dart';
import 'package:uber_clone_flutter/src/models/product.dart';
import 'package:uber_clone_flutter/src/models/response_api.dart';
import 'package:uber_clone_flutter/src/models/user.dart';
import 'package:uber_clone_flutter/src/provider/StripeProvider.dart';
import 'package:uber_clone_flutter/src/provider/address_provider.dart';
import 'package:uber_clone_flutter/src/provider/orders_provider.dart';
import 'package:uber_clone_flutter/src/utils/my_snackbar.dart';
// import 'package:uber_clone_flutter/src/provider/orders_provider.dart';
import 'package:uber_clone_flutter/src/utils/shared_pref.dart';
import 'package:easy_dialog/easy_dialog.dart';
import '../../products/list/client_menu_list.dart';
import '../../states/request/request_cleaner_page.dart';
import '../create/client_address_create_page.dart';

class ClientAddressListController {

  BuildContext context;
  Function refresh;


  AddressProvider _addressProvider = new AddressProvider();



  int radioValue = 0;
  bool elestado = false;
  bool isCreated;
  double totalPayment = 0;
  double totalPaymentD = 0;
  String pago = '';
  Map<String, dynamic> dataIsCreated;
  List<CardClient> cardsStore = [];
  List<Product> selectedProducts = [];
  SharedPref _sharedPref = new SharedPref();
  User user;
  List<Addresss> address = [];
  OrdersProvider _ordersProvider = new OrdersProvider();
  StripeProvider _stripeProvider = new StripeProvider();
  String cardname;
  ProgressDialog progressDialog;
  String nameCard;
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    progressDialog = new ProgressDialog(context: context);
    cardsStore = CardClient.fromJsonList(await _sharedPref.read('card')).toList;
    user = User.fromJson(await _sharedPref.read('user'));
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    _addressProvider.init(context, user);
    _ordersProvider.init(context, user);
    _stripeProvider.init(context);
    getTotalPayment();
    selectedProducts.clear();
    Addresss a = Addresss.fromJson(await _sharedPref.read('address') ?? {});
    if (a.id !=null) {

    }
    refresh();
  }





  //
  // //Create Item product
  // void addItem(Product product) {
  //   int index = selectedProducts.indexWhere((p) => p.id == product.id);
  //   selectedProducts[index].quantity = selectedProducts[index].quantity + 1;
  //   _sharedPref.save('order', selectedProducts);
  //   getTotal();
  // }



  void getCards() async {
    cardsStore.forEach((c) {
      print('Tarjetas listadas ${c.toJson()}');


    });
  }
  //Create service lavado.
  void creteService(){
    //Create procduct

    Product product = new Product(
      id: '1',
      name: 'Lavado',
      description: 'Lavado Exterior de Vehiculo',
      price: 120,
      idCategory: 1,
      quantity: 1,
    );
    //Adding elements to selected products
    selectedProducts.add(product);
    //Save order to shared preferences.
    int index =    selectedProducts.indexWhere((p) => p.id == product.id);
    selectedProducts[index].quantity = selectedProducts[index].quantity;
    _sharedPref.save('order', selectedProducts);

  }

  void createOrder() async {
      //
      // Addresss a = Addresss.fromJson(await _sharedPref.read('address') ?? {});
      // List<Product> selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
      // Order order = new Order(
      //     idClient: user.id,
      //     idAddress: a.id,
      //     products: selectedProducts
      // );
      // ResponseApi responseApi = await _ordersProvider.create(order);
      //
      //
      // if(responseApi.success){
      //   print('@222222 $totalPayment');
      //   SharedPreferences preferences = await SharedPreferences.getInstance();
      //   await preferences.remove('order');
        Future.delayed(Duration.zero, () {
          //Navigator.pushNamed(context, '  3
          // \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ aQ433client/payments/stripe/existingcards');
          Navigator.pushNamedAndRemoveUntil(
               context,
              'client/payments/stripe/existingcards',
                  (route) => false,
              arguments: {
              'totalPs': totalPayment,

            }
          );
        });

     //  }
     // // Navigator.pushNamedAndRemoveUntil(context, 'client/payments/status', (route) => false);
     //  print('Producto seleccionado: ${responseApi.message}');
     //  progressDialog.close();

    // }else{
    //   progressDialog.close();
    // }

  }

  //Orden que se paga en efectivo
  void createOrderCash() async {
    creteService();
    //Reading addresses in Shared preferences
    Addresss addresses = Addresss.fromJson(await _sharedPref.read('address') ?? {});

    //Reading de Order
    List<Product> selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    print('ClientAdreess *SELECTED PRODUCTS CONTAINS*: $selectedProducts');
    //Creating de Order
    Order order = new Order(
        idClient: user.id,
        idAddress: addresses.id,
        lat: addresses.lat,
        lng: addresses.lng,
        products: selectedProducts
    );

    //Sending data to API
    ResponseApi responseApi = await _ordersProvider.createOrderCash(order);
    if(responseApi.success){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('order');
      print('ClientAdreess *PAGO TOTAL* : $totalPayment');

      //Remove order when order s successful
      await preferences.remove('order');
      Future.delayed(Duration.zero, () {

        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(builder: (BuildContext context) => const RequestCleanerPage()),
          ModalRoute.withName('client/states/cleaner',),
        );

      });

    }
    // Navigator.pushNamedAndRemoveUntil(context, 'client/payments/status', (route) => false);
    print('ClientAdreess *Response API* : ${responseApi.message}');
    progressDialog.close();

  }



  void getTotalPayment() {
    // progressDialog.show(max: 100, msg: 'Realizando transaccion');
    totalPayment = 120;
      print('Total a pagar: ${(totalPayment*100).floor()}');
    refresh();
    progressDialog.close();
  }

  void handleRadioValueChange(int value) async {
    radioValue = value;
    _sharedPref.save('address', address[value]);

    refresh();
    print('Valor seleccioonado: $radioValue');
  }



  Future<List<Addresss>> getAddress() async {
    address = await _addressProvider.getByUser(user.id);

    Addresss a = Addresss.fromJson(await _sharedPref.read('address') ?? {});
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      radioValue = index;
      elestado = true;
    }

    print('SE GUARDO LA DIRECCION: ${a.toJson()}');
    print('LO QUE TREA ADRESSESS  ${address.toString()}');
    return address;
  }

  void goToNewAddress() async {
    // var result = await Navigator.pushNamed(context, 'client/address/create');

    // var result = await  Navigator.push(
    //   context,
    //   new MaterialPageRoute(
    //     builder: (context) => new ClientAddressCreatePage(),
    //   ),
    // );

    var result = await Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => const ClientAddressCreatePage()),
      ModalRoute.withName('client/address/create'),
    );

    // if (result != null) {
    //   if (result) {
    //     refresh();
    //   }
    // }
  }



}