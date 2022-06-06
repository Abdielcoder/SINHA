import 'dart:async';
import 'dart:core';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:uber_clone_flutter/src/models/addresss.dart';
import 'package:uber_clone_flutter/src/models/car.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';
import 'package:uber_clone_flutter/src/widgets/no_data_widget.dart';

import '../create/client_car_create_page.dart';
import 'list_car_pay_controller.dart';


class ListCarPayPage extends StatefulWidget {
  const ListCarPayPage({Key key}) : super(key: key);

  @override
  _ListCarPayPageState createState() => _ListCarPayPageState();
}

class _ListCarPayPageState extends State<ListCarPayPage> {
  bool muestraText;
  ListCarPayController _con = new ListCarPayController();

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
    return Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Stack(
              alignment: Alignment.center,
            children: [


              Positioned(
                  top: 0,
                  child: _textSelecciona(),
              ),
              Container(
                  margin: EdgeInsets.only(top: 100),
                  child: _listAddress()
              ),
              // Align(
              //   alignment: FractionalOffset.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Positioned(
              //         top: 0,
              //         child: _buttonNewCar()
              //     ),
              //   ),
              // ),


            ],
          ),

        ),
      ),

      )
    );

  }

  Widget _noCars() {
    return Column(
      children: [
        InkWell(
          child: Container(
              margin: EdgeInsets.only(top: 0),
              child: NoDataWidget(text: 'No tienes ningún Vehiculo, agrega uno')
          ),
          onTap: _con.goToNewCard,
        ),
        // _buttonNewCar()
      ],
    );
  }


  Widget _buttonNewCar() {
    return SizedBox(
      width: 140,
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
                  "./assets/images/addcar.png",
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
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new CLientCarCreatePage(),
                ),
              );
            },
          ),

        ),

      ]),
    );
  }



//LIST ADRESS
  Widget _listAddress() {
    return FutureBuilder(
        future: _con.getCars(),//GET LIST ADRRES FROM PROVIDER
        builder: (context, AsyncSnapshot<List<Car>> snapshot) {
          if (snapshot.hasData) {//VALIDATED
            if (snapshot.data.length > 0) {//VALIDATED
              muestraText = true;
              return Stack(
                  children: [
                    ListView.builder(
                      reverse: false,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_, index) {
                        return _radioSelectorAddress(snapshot.data[index], index);
                      }
                  ),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Positioned(
                            top: 0,
                            child: _buttonNewCar()
                        ),
                      ),
                    ),

                  ],

              );
;

            }
            else {
              // setState(() {
              //   muestraText = false;
              // });

              return _noCars();
            }

          }
          else {
            // setState(() {
            //   muestraText = false;
            // });
            return _noCars();
          }

        }

    );

  }

  Widget _radioSelectorAddress(Car cars, int index) {
    String colorCarBd =cars?.color ?? '';
    String colorWHex = "0xFF${colorCarBd}";
    int colorCar = int.parse(colorWHex);
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Row(

              children: [

                // Radio(
                //
                //   value: index,
                //   groupValue: _con.radioValue,
                //   onChanged:  _con.handleRadioValueChange,
                //
                // ),
                Column(children: <Widget>[
                SizedBox(height: 32.0),
                GestureDetector(
                onTap: (){},
                child:  CircleAvatar(
                      backgroundImage: cars.image != null
                          ? NetworkImage(cars.image)
                          : AssetImage('assets/img/placac.png'),
                      radius: 40,
                      backgroundColor: Colors.grey[200],
                    ),
                )],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28,bottom: 5),
                      child: Text(
                        cars?.marca ?? '',
                        style: TextStyle(
                            color: MyColors.colorWhite,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28,bottom: 5),
                      child: Text(
                        cars?.modelo ?? '',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8,bottom: 5),
                      child: Text(
                        'AÑO',
                        style: TextStyle(
                            color: MyColors.colorWhite,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,bottom: 5),
                      child: Text(
                        cars?.year ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:0, left: 8,bottom: 5),
                      child: Text(
                        'COLOR',
                        style: TextStyle(
                            color: MyColors.colorWhite,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18,bottom: 5),
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundImage: cars.color != null
                              ? AssetImage('')
                              : AssetImage('assets/img/car_color.png'),
                          radius: 7,
                          backgroundColor: Color(colorCar),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:0, left: 8,bottom: 5),
                      child: Text(
                        'PLACA',
                        style: TextStyle(
                            color: MyColors.colorWhite,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,bottom: 5),
                      child: Text(
                        cars?.placa ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ],
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //
                //   children: [
                //
                //     Padding(
                //       padding: const EdgeInsets.only(left: 20,bottom: 5),
                //       child: _iconGo(cars),
                //     )
                //
                //   ],
                // ),

              ],
            ),
            Divider(
              color: Colors.grey[400],
            )
          ],
        ),
      ),
      onTap: () => _con.goToAddress(cars),
    );
  }

  Widget _textSelecciona() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Text(
        'Selecciona un vehículo d Añade uno ',
        style: TextStyle(
          color: Colors.white,
            fontSize: 19,
            fontFamily: 'Lexendeca-Regular',
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }


  //
  // Widget _textSeleciion() {
  //   return Container(
  //     alignment: Alignment.centerLeft,
  //     margin: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
  //     child: Text(
  //       'Presiona el botón para para seleccionar auto',
  //       style: TextStyle(
  //         fontFamily: 'Lexendeca-Regular',
  //         fontSize: 15,
  //
  //       ),
  //     ),
  //   );
  // }

  Widget _iconAdd() {

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            children: [
              Row(
                  children: [
                    Text(
                      'Agrega un vehiculo',
                      style: TextStyle(
                        fontFamily: 'Lexendeca-Regular',
                        fontSize: 14,

                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: _con.goToNewCard,
                            icon: Icon(Icons.add, color: Colors.white)
                        ),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Regresar',
                          style: TextStyle(
                            fontFamily: 'Lexendeca-Regular',
                            fontSize: 14,

                          ),
                        ),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: _con.goBack,
                            icon: Icon(Icons.arrow_back, color: Colors.white)
                        ),

                      ],
                    ),
                  ]

              ),
            ]
        )
    );

  }

  void refresh() {
    setState(() {

    });

  }




}
