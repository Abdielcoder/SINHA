import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:uber_clone_flutter/src/pages/client/payments/stripe/stripe_existing_cards_controller.dart';
import 'package:uber_clone_flutter/src/utils/my_snackbar.dart';


import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../../models/cards_client.dart';
import '../../../../../provider/stripe_store_card_provider.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../widgets/no_data_widget.dart';
import '../../../address/list/client_address_list_page.dart';
import '../../../products/list/client_menu_list.dart';
import '../../create/client_payments_create_page.dart';
import '../../create/createmenu/client_payments_create_menu_page.dart';

class ExistingCardsMenuPage extends StatefulWidget {
  CardClient cardClient;


  @override
  ExistingCardsMenuPageState createState() => ExistingCardsMenuPageState();
}

class ExistingCardsMenuPageState extends State<ExistingCardsMenuPage> {
  ProgressDialog progressDialog;
  StripeExistingCardsController _con = new StripeExistingCardsController();
  double totalPs = 120;
  String totalPaymentString = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressDialog = new ProgressDialog(context: context);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.cardClient);
    });
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/img/encamino.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect( // make sure we apply clip it properly
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 10),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text('Crear Tarjeta'),

                  ),
                  bottomNavigationBar: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.280,
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.grey[400],
                          endIndent: 30, // DERECHA
                          indent: 30, //IZQUIERDA
                        ),
                        //  _textTotalPrice(),
                        (totalPs * 100).floor() >= 0 ? _listAddress() :Container(),
                      ],
                    ),
                  ),
                  body: _con.cardsStore.length > 0
                      ? ListView(
                    children: _con.cardsStore.map((CardClient cardClient) {
                      return _cardProduct(cardClient);
                    }).toList(),
                  )
                      : NoDataWidget(text: 'Ningun producto agregado',),
                )
            )
        )
    );
  }

  Widget _cardProduct(CardClient cardClient) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 70, vertical: 0),
      child: Row(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  payViaExistingCard(context, cardClient);
                },
                child: CreditCardWidget(
                  cardNumber: cardClient.cardNumber,
                  expiryDate: cardClient.expiryDate,
                  cardHolderName: cardClient.cardHolderName,
                  cardBgColor: Colors.black87,
                  cvvCode: cardClient.ccv,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.200,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.450,
                  showBackView: false,
                ),
              ),
              SizedBox(height: 0),

            ],
          ),

          Column(

            children: [
              _textPrice('ELIMINAR'),
              _iconDelete(cardClient)
            ],
          )
        ],
      ),
    );
  }


  Widget _iconDelete(CardClient cardClient) {
    return IconButton(
        onPressed: () {
          _con.deleteItem(cardClient);
        },
        icon: Icon(Icons.delete, color: Colors.white,)
    );
  }
  Widget _textPrice(String nombre) {
    return Container(
      margin: EdgeInsets.only(top: 1),
      child: Text(
        nombre,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  // Widget _textPago() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 20, left: 150),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           'PRECIONE UNA TARJETA PARA PAGAR',
  //           style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 14
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  payViaExistingCard(BuildContext context, CardClient cardClient) async {
    // ProgressDialog dialog = new ProgressDialog(context);
    // dialog.style(
    //     message: 'Please wait...'
    // );
    _con.createOrder();

    //
    //  progressDialog.show(max: 100, msg: 'Procesando tú pago.');
    // print('El valor es: ${totalPs}');
    // // await dialog.show();
    // var expiryArr = cardClient.expiryDate.split('/');
    // CreditCard stripeCard = CreditCard(
    //   number: cardClient.cardNumber,
    //   expMonth: int.parse(expiryArr[0]),
    //   expYear: int.parse(expiryArr[1]),
    // );
    // try {
    //   print('valor psss #### : **** ${(totalPs * 100).floor()}');
    //   var response = await StripeService.payViaExistingCard(
    //       amount: '${(totalPs * 100).floor()}',
    //       currency: 'MXN',
    //       card: stripeCard
    //   );
    //   print('El error: **** ${response.toString()}');
    //   MySnackbar.show(context, response.message);
    //   if (response.message == 'Transaction successful') {
    //     progressDialog.close();
    //     MySnackbar.show(context, 'Tu orden ha sido procesada.');
    //     _con.createOrder();
    //
    //   } else {
    //     if ((totalPs * 100).floor() == 0) {
    //       progressDialog.close();
    //       MySnackbar.show(context, response.message);
    //       MySnackbar.show(context, 'Aviso.');
    //       AwesomeDialog(
    //         context: context,
    //         dialogType: DialogType.ERROR,
    //         animType: AnimType.BOTTOMSLIDE,
    //         title: 'En esta Sección solo puede Eliminar o crear tarjetas. .',
    //         desc: '',
    //         btnOkOnPress: () {
    //           _con.cancelOrder();
    //         },
    //       )
    //         ..show();
    //     } else {
    //       progressDialog.close();
    //       MySnackbar.show(context, response.message);
    //       MySnackbar.show(
    //           context, 'Revisa tu forma de pago, orden no procesada.');
    //       AwesomeDialog(
    //         context: context,
    //         dialogType: DialogType.ERROR,
    //         animType: AnimType.BOTTOMSLIDE,
    //         title: 'Revisa tu forma de pago, orden no procesada .',
    //         desc: '',
    //         btnOkOnPress: () {
    //           _con.cancelOrder();
    //         },
    //       )
    //         ..show();
    //     }
    //   }
    // } catch (e) {
    //   progressDialog.close();
    //   MySnackbar.show(context, 'El error: **** ${e.message}');
    //   print('El error: **** ${e.message}');
    // }
  }

  void refresh() {
    setState(() {});
  }

  // //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Escoje una tarjeta'),
  //     ),
  //     body: Container(
  //       padding: EdgeInsets.all(20),
  //       child: ListView.builder(
  //         itemCount: cards.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           var card = cards[index];
  //           return InkWell(
  //             onTap: () {
  //               payViaExistingCard(context, card);
  //             },
  //             child: CreditCardWidget(
  //               cardNumber: card['cardNumber'],
  //               expiryDate: card['expiryDate'],
  //               cardHolderName: card['cardHolderName'],
  //               cvvCode: card['cvvCode'],
  //               showBackView: false,
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
  // void refresh() {
  //   setState(() {});
  // }

  Widget _buttonReresar() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, 'client/products/list', (route) => false);
        },
        child: Text(
            'Regresar'

        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            primary: MyColors.primaryColor
        ),
      ),
    );
  }

  Widget _buttonNuevaTarjeta() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      child: ElevatedButton(
        onPressed: () {
          _con.cardsStore.length > 2 ?
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Solo puedes tener 3 Tarjetas elimina una .',
            desc: '',
            btnOkOnPress: () {

            },
          ).show() :
          Navigator.pushNamedAndRemoveUntil(
              context,
              'client/payments/create',
                  (route) => false,
              arguments: {
                'totalPs':totalPs,

              }
          );
        },
        child: Text(
            'Crear'

        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            primary: MyColors.primaryColor
        ),
      ),
    );
  }



  Widget _listAddress() {
    return Stack(
      children: [Container(
        child: Row(
        ),
      ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.070,top:MediaQuery.of(context).size.height * 0.040),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child:  _buttonBack(),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0),
                      child: Text(

                        'Regrear a\n direcciones',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.140,top:MediaQuery.of(context).size.height * 0.010),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.02),
                      child: Text(
                        'Presiona una tarjeta para pagar',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
        Column(

          children: [
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.350,top:MediaQuery.of(context).size.height * 0.040),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child:  _buttonAccept(),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0),
                      child: Text(
                        'Añade una \nTarjeta',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ],);


  }


  Widget _buttonAccept() {
    return SizedBox(
      child: Stack(children: [
        Container(
          child: Lottie.asset(
            'assets/json/pulse.json',
            width: 110,
            height: 150,
          ),
        ),
        Center(
          child: GestureDetector(

              child: Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.030,top:MediaQuery.of(context).size.height * 0.050),

                height: 60,
                width: 60,

                child: Center(

                  child: Image.asset(
                    "./assets/images/creditcard.png",

                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: Colors.deepPurpleAccent,
                  boxShadow: [
                    BoxShadow(color: Colors.white, spreadRadius: 3),
                  ],
                ),

              ),
              onTap:(){
                if(_con.cardsStore.length == 3){
                  _dialogFail();
                }else{
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) => ClientPaymentsCreateMenuPage()),
                    ModalRoute.withName('client/payments/menu/create'),
                  );
                }

              }

          ),

        ),

      ]),
    );
  }

  Widget _buttonBack() {
    return SizedBox(
      child: Stack(children: [
        Container(
          child: Lottie.asset(
            'assets/json/pulse.json',
            width: 120,
            height: 150,
          ),
        ),
        Center(
          child: GestureDetector(

            child: Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050,top:MediaQuery.of(context).size.height * 0.050),

              height: 60,
              width: 60,

              child: Center(

                child: Image.asset(
                  "./assets/images/backarrow.png",

                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Colors.deepPurpleAccent,
                boxShadow: [
                  BoxShadow(color: Colors.white, spreadRadius: 3),
                ],
              ),

            ),
            onTap: (){
              Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) =>  ClientMenuListPage()),
                ModalRoute.withName('client/products/list',),
              );
            },
          ),

        ),

      ]),
    );
  }

  void _dialogFail() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'No puedes agregar más de 3 tarjetas',
      desc: 'Elimina una para añadir otra',
      btnOkOnPress: () {},
    )..show();
  }

}