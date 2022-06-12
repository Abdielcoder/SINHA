import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_flutter/src/utils/shared_pref.dart';
import '../../../models/car.dart';
import '../../../models/user.dart';
import '../../../provider/car_provider.dart';
import '../../../utils/dialog.dart';
import '../address/list/client_address_list_page.dart';
import '../create/client_car_create_page.dart';


class ListCarPayController {

  BuildContext context;
  Function refresh;
  SharedPref _sharedPref = new SharedPref();
  List<Car> cars = [];
  CarProvider _carProvider = new CarProvider();
  User user;
  int radioValue = 0;
  String selectedValue;
  ProgressDialog _progressDialog;
  void onSelected(String value) {
    selectedValue = value;
    print(selectedValue);
  }

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
     _progressDialog = ProgressDialog();
    user = User.fromJson(await _sharedPref.read('user'));
    _carProvider.init(context, user);
    refresh();
  }

  //Get cars
  Future<List<Car>> getCars() async {
    cars = await _carProvider.getByUser(user.id);
    print('LO QUE TREA CARS  ${cars.toString()}');
    return cars;
  }

  //Delete car
  void deleteCar(Car cars) {
    _progressDialog.showProgressDialog(context,dismissAfter: Duration(seconds: 2),textToBeDisplayed:'Un momento...',onDismiss:(){

    });
    MyDialog.info(context, 'ELIMINAR','¿Quieres eliminar el Vehiculo?...','client/car/list',cars.id);
  }

  //Go to select address
  void goToAddress(Car cars) async{
    _progressDialog.showProgressDialog(context,dismissAfter: Duration(seconds: 3),textToBeDisplayed:'Un momento...',onDismiss:(){

    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  ClientAddressListPage()),
    );
  }

  //Go to create new car
  void goToNewCard() async {
    _progressDialog.showProgressDialog(context,dismissAfter: Duration(seconds: 3),textToBeDisplayed:'Sending...',onDismiss:(){

    });
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => const CLientCarCreatePage()),
      ModalRoute.withName('client/create/car'),
    );

  }

  //Back
  void goBack() async {
    var result = await Navigator.pushNamed(context, 'client/products/list');

    if (result != null) {
      if (result) {
        refresh();
      }
    }
  }

}