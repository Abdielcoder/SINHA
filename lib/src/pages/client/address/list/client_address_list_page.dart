import 'dart:ui';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:uber_clone_flutter/src/models/addresss.dart';
import 'package:uber_clone_flutter/src/models/cards_client.dart';
import 'package:uber_clone_flutter/src/pages/client/address/create/client_address_create_page.dart';
import 'package:uber_clone_flutter/src/widgets/no_data_widget.dart';
import 'client_address_list_controller.dart';

class ClientAddressListPage extends StatefulWidget {
  CardClient cardClient;

  @override
  _ClientAddressListPageState createState() => _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {
  double totalPayment = 0;
  ProgressDialog _progressDialog = new ProgressDialog();
  ClientAddressListController _con = new ClientAddressListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    _listAddress();
    print(totalPayment);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading:InkWell(
          onTap: () {
            Navigator.of(context).pop();
            // Navigator.pushAndRemoveUntil<void>(
            //   context,
            //   MaterialPageRoute<void>(builder: (BuildContext context) => const ClientMenuListPage()),
            //   ModalRoute.withName('client/products/list'),
            // );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text('Atras'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/img/encamino.jpg"),
            fit: BoxFit.cover,
          ),
        ),
          child: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 140, sigmaY: 100),
    child: Stack(
          children: [
            Positioned.fill(
                top: 170,
                child: Align(
                    alignment: Alignment.topCenter,
                    child: _textSelectAddress()
                )


            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: _listAddress()
            ),


          ],
        )
    )
    )
      ),


    );

  }

  Widget _noAddress() {
    return InkWell(
      onTap: _con.goToNewAddress,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 30),
              child: NoDataWidget(text: 'No tienes ninguna direccion agrega una nueva')
          ),
          // _buttonNewAddress()
        ],
      ),
    );
  }


  Widget _buttonNewAddress() {
    return SizedBox(
      width: 100,
      height: 140,
      child: Stack(children: [
        Container(
          height: 500,
          width: 500,
          child: Lottie.asset(
            'assets/json/pulse.json',
            width: 500,
            height: 500,
          ),
        ),
        Center(
          child: GestureDetector(
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                child: Image.asset(
                  "./assets/images/pinmaps.png",
                  width: 600,
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
            onTap: () {
              _progressDialog.showProgressDialog(context,dismissAfter: Duration(seconds: 3),textToBeDisplayed:'Un momento...',onDismiss:(){

              });
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ClientAddressCreatePage(),
                ),
              );
            },
          ),

        ),

      ]),
    );
  }

  Widget _buttonAccept() {
    return SizedBox(
      width: 100,
      height: 140,
      child: Stack(children: [
        Container(
          height: 500,
          width: 500,
          child: Lottie.asset(
            'assets/json/pulse.json',
            width: 500,
            height: 500,
          ),
        ),

        Center(
          child: GestureDetector(

            child: Container(
              height: 60,
              width: 60,

              child: Center(

                child: Image.asset(
                  "./assets/images/debit.png",
                  width: 600,
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
            onTap: _con.goToCreateCard,

          ),

        ),

      ]),
    );
  }

  Widget _buttonAcceptCash() {
    return SizedBox(
      width: 100,
      height: 140,
      child: Stack(children: [
        Container(
          height: 500,
          width: 500,
          child: Lottie.asset(
            'assets/json/pulse.json',
            width: 500,
            height: 500,
          ),
        ),

        Center(
          child: GestureDetector(

            child: Container(
              height: 60,
              width: 60,

              child: Center(

                child: Image.asset(
                  "./assets/images/coin.png",
                  width: 600,
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
            onTap: _con.createOrderCash,
          ),

        ),

      ]),
    );

  }



  Widget _buttonAcceptCreateCard() {
    return SizedBox(
      width: 100,
      height: 140,
      child: Stack(children: [
        Container(
          height: 500,
          width: 500,
          child: Lottie.asset(
            'assets/json/pulse.json',
            width: 500,
            height: 500,
          ),
        ),

        Center(
          child: GestureDetector(

            child: Container(
              height: 60,
              width: 60,

              child: Center(

                child: Image.asset(
                  "./assets/images/creditcard.png",
                  width: 50,
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
            onTap: _con.createOrder,
          ),

        ),

      ]),
    );

  }

//LIST ADRESS
  Widget _listAddress() {
    return FutureBuilder(
        future: _con.getAddress(),//GET LIST ADRRES FROM PROVIDER
        builder: (context, AsyncSnapshot<List<Addresss>> snapshot) {
          if (snapshot.hasData) {//VALIDATED
            if (snapshot.data.length > 0) {//VALIDATED

              return Stack(
                  children: [Container(
                    margin: EdgeInsets.only(top:180),
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index) {
                          return _radioSelectorAddress(snapshot.data[index], index);
                        }
                    ),
                  ),

                     Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050),
                       child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                               child:  _buttonNewAddress(),
                              ),
                              Expanded(
                                child: Text(
                                  'Agrega Dirección',
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    ),

                                ),
                              ),

                            ],
                          ),
                     ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050,top:MediaQuery.of(context).size.height * 0.590),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child:  _buttonAccept(),
                              ),
                              Expanded(
                                child: Text(
                                    'Añade \n Tarjeta',
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
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
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.250,top:MediaQuery.of(context).size.height * 0.590),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child:  _buttonAcceptCreateCard(),
                              ),
                              Expanded(
                                child: Text(
                                    'Pago \nTarjeta',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
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
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.430,top:MediaQuery.of(context).size.height * 0.590),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child:  _buttonAcceptCash(),
                              ),
                              Expanded(
                                child: Text(
                                    'Pago\n Efectivo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
              );


            }
            else {
              return _noAddress();
            }

          }
          else {
            return _noAddress();
          }

        }

    );

  }

  Widget _radioSelectorAddress(Addresss address, int index) {

    return Container(
      margin: EdgeInsets.only(top:0,right: 40,left: 40),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                fillColor: MaterialStateColor.resolveWith((states) => Colors.white),

                value: index,
                groupValue: _con.radioValue,
                onChanged:_con.handleRadioValueChange,

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address?.address ?? '',
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  // Text(
                  //   address?.neighborhood ?? '',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 12,
                  //   ),
                  // )
                ],
              ),

            ],
          ),
          Divider(
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }

  Widget _textSelectAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Text(
        'Elige donde recibir tus compras',
        style: TextStyle(
            fontSize: 19,
            fontFamily: 'NimbusSans',
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  //
  // Widget _iconAdd() {
  //   return IconButton(
  //       onPressed: _con.goToNewAddress,
  //       icon: Icon(Icons.add, color: Colors.white)
  //   );
  // }

  void refresh() {
    setState(() {

    });

  }

}
