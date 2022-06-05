import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:uber_clone_flutter/src/models/mercado_pago_document_type.dart';
import 'package:uber_clone_flutter/src/pages/client/payments/create/client_payments_create_controller.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';


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
    return Container(
      margin: EdgeInsets.all(50),
      child: ElevatedButton(
        onPressed: _con.createCardToken,
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'CONTINUAR',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 50, top: 9),
                height: 30,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: MyColors.colorNaranja,
                  size: 30,
                ),
              ),
            )

          ],
        ),
      ),
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
