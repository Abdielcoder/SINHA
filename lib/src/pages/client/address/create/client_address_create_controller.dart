import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uber_clone_flutter/src/models/addresss.dart';
import 'package:uber_clone_flutter/src/models/response_api.dart';
import 'package:uber_clone_flutter/src/models/user.dart';
import 'package:uber_clone_flutter/src/pages/client/address/map/client_address_map_page.dart';
import 'package:uber_clone_flutter/src/provider/address_provider.dart';
import 'package:uber_clone_flutter/src/utils/my_snackbar.dart';
import 'package:uber_clone_flutter/src/utils/shared_pref.dart';

import '../list/client_address_list_page.dart';

class ClientAddressCreateController {

  BuildContext context;
  Function refresh;

  TextEditingController refPointController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController neighborhoodController = new TextEditingController();

  Map<String, dynamic> refPoint;

  AddressProvider _addressProvider = new AddressProvider();
  User user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, user);
  }

  void createAddress() async {

    try{
      String addressName = refPointController.text;
      String neighborhood = '';
      double lat = refPoint['lat'] ?? 0;
      double lng = refPoint['lng'] ?? 0;

      print('Valores map: $addressName');

      if (addressName.isEmpty ||  lat == 0 || lng == 0) {
        MySnackbar.show(context, 'Completa todos los campos');
        return;
      }

      Addresss address = new Addresss(
          address: addressName,
          neighborhood: neighborhood,
          lat: lat,
          lng: lng,
          idUser: user.id
      );

      ResponseApi responseApi = await _addressProvider.create(address);

      if (responseApi.success) {

        address.id = responseApi.data;
        _sharedPref.save('address', address);

        MySnackbar.show(context, responseApi.message);
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(builder: (BuildContext context) => ClientAddressListPage()),
          ModalRoute.withName('client/address/create'),
        );
      }
    }catch(e){
      print('Error adress: ${e}');
    }

  }

  void openMap() async {
    refPoint = await showMaterialModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => ClientAddressMapPage()
    );

    if (refPoint != null) {
      refPointController.text = refPoint['address'];
      refresh();
    }
  }

}