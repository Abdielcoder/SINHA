import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:uber_clone_flutter/src/models/mercado_pago_document_type.dart';
import 'package:uber_clone_flutter/src/pages/client/payments/create/client_payments_create_controller.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';

import '../stripe/stripe_existing_cards_page.dart';


class ClientPaymentsCreatePage extends StatefulWidget {
  const ClientPaymentsCreatePage({Key key}) : super(key: key);

  @override
  _ClientPaymentsCreatePageState createState() => _ClientPaymentsCreatePageState();
}

class _ClientPaymentsCreatePageState extends State<ClientPaymentsCreatePage> {

  ClientPaymentsCreateController _con = new ClientPaymentsCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
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
        body: Container(
          margin: EdgeInsets.only(left: 70,right: 70),
          child: ListView(
            children: [
              CreditCardWidget(
                cardNumber: _con.cardNumber,
                expiryDate: _con.expireDate,
                cardHolderName: _con.cardHolderName,
                cvvCode: _con.cvvCode,
                showBackView: _con.isCvvFocused,
                cardBgColor: Colors.black87,
                obscureCardNumber: true,
                obscureCardCvv: true,
                animationDuration: Duration(milliseconds: 1000),
                labelCardHolder: 'NOMBRE Y APELLIDO',
              ),
              CreditCardForm(
                cvvCode: '',
                expiryDate: '',
                cardHolderName: '',
                cardNumber: '',
                formKey: _con.keyForm, // Required
                onCreditCardModelChange: _con.onCreditCardModelChanged, // Required
                themeColor: Colors.white,
                textColor: Colors.white,

                obscureCvv: true,
                obscureNumber: true,

                cardNumberDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  labelText: 'Numero de la tarjeta',
                  hintText: 'XXXX XXXX XXXX XXXX',
                    //hoverColor: Colors.white,
                    focusColor: Colors.white,

                    hintStyle: const TextStyle(color: Colors.white70),
                    labelStyle: const TextStyle(color: Colors.white70),

                  floatingLabelStyle: TextStyle(
                    color: Colors.white,

                  )
                ),
                expiryDateDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),

                  labelText: 'Expiracion',
                  hintText: 'XX/XX',
                    hintStyle: const TextStyle(color: Colors.white70),
                    labelStyle: const TextStyle(color: Colors.white70),

                    floatingLabelStyle: TextStyle(
                      color: Colors.white,

                    )
                ),
                cvvCodeDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  labelText: 'CVV',
                  hintText: 'XXX',
                    hintStyle: const TextStyle(color: Colors.white70),
                    labelStyle: const TextStyle(color: Colors.white70),

                    floatingLabelStyle: TextStyle(
                      color: Colors.white,

                    )
                ),
                cardHolderDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  labelText: 'Nombre del titular',
                    hintStyle: const TextStyle(color: Colors.white70),
                    labelStyle: const TextStyle(color: Colors.white70),

                    floatingLabelStyle: TextStyle(
                      color: Colors.white,

                    )
                ),
                  ),
              // _documentInfo(),
              _buttonNext()
            ],
          ),
        )
            ),
      ),
    )
      )
    );
  }

  Widget _buttonNext() {
   return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.0),
            child: SizedBox(
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
                      onTap: _con.createCardToken,
                  ),

                ),

              ]),
            )
        )
    );
  }


  List<DropdownMenuItem<String>> _dropDownItems(List<MercadoPagoDocumentType> documentType) {
    List<DropdownMenuItem<String>> list = [];
    documentType.forEach((document) {
      list.add(DropdownMenuItem(
        child: Container(
          margin: EdgeInsets.only(top: 7),
          child: Text(document.name),
        ),
        value: document.id,
      ));
    });

    return list;
  }

  void refresh() {
    setState(() {});
  }
}
