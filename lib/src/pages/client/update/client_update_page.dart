import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';

import 'client_update_controller.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({Key key}) : super(key: key);

  @override
  _ClientUpdatePageState createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {

  ClientUpdateController _con = new ClientUpdateController();

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
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Atras'),
        ),
        body: Container(
        width: double.infinity,
          decoration: BoxDecoration(
          image: DecorationImage(
          image: ExactAssetImage("assets/img/encamino.jpg"),
          fit: BoxFit.cover,
          ),

          ),

          child: ClipRRect(
          child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  _imageUser(),
                  SizedBox(height: 30),
                  _textFieldName(),
                  _textFieldLastName(),
                  _textFieldPhone(),
                  SizedBox(height: 90),
                  _buttonLogin(),
                  SizedBox(height: 100),

                ],
              ),
            )
        ))),
       // bottomNavigationBar: _buttonLogin(),
      ),
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile)
            : _con.user?.image != null
            ? NetworkImage(_con.user?.image)
            : AssetImage('assets/img/user_profile_2.png'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Lexendeca-Black',
        ),
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
              fontSize: 20,
                color: MyColors.primaryColorDark,
            ),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.colorWhite,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Lexendeca-Black',
        ),
        controller: _con.lastnameController,
        decoration: InputDecoration(
            hintText: 'Apellido',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark,
              fontFamily: 'Robot',
            ),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.colorWhite,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Lexendeca-Black',
        ),
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark,
              fontFamily: 'Robot',
            ),
            prefixIcon: Icon(
              Icons.phone,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }


  Widget _buttonLogin() {
    return Container(
      color: Colors.transparent,
         margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.000),
        child: InkWell(
          onTap: _con.isEnable ? _con.update : null,
          child: SizedBox(
            width: 500,
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
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.269,top:MediaQuery.of(context).size.height * 0.045
                    ,bottom:MediaQuery.of(context).size.height * 0.030),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                                  child: Center(

                                    child: Image.asset(
                                      "./assets/images/update.png",
                                      //width: 600,
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

                              ]
                    ),


                          ),

                        Expanded(
                          child: Text(
                            'Actualizar',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),

                      ],
                    ),
                  ]
            ),
          ),
        )
    );

  }


  void refresh() {
    setState(() {

    });
  }
}
