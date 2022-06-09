import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:uber_clone_flutter/src/models/car.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';
import 'package:uber_clone_flutter/src/widgets/no_data_widget.dart';
import '../create/client_car_create_page.dart';
import '../products/list/client_menu_list.dart';
import 'list_car_pay_controller.dart';


class ListCarPayPage extends StatefulWidget {
  const ListCarPayPage({Key key}) : super(key: key);

  @override
  _ListCarPayPageState createState() => _ListCarPayPageState();
}

class _ListCarPayPageState extends State<ListCarPayPage> {
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
          leading:InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => const ClientMenuListPage()),
                ModalRoute.withName('client/products/list'),
              );
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
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Stack(
              alignment: Alignment.center,
            children: [
            _textTitle(),
          Container(
                  margin: EdgeInsets.only(top: 100),
                  child: _listCars()
              ),
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
  Widget _listCars() {
    return FutureBuilder(
        future: _con.getCars(),//GET LIST ADRRES FROM PROVIDER
        builder: (context, AsyncSnapshot<List<Car>> snapshot) {
          if (snapshot.hasData) {//VALIDATED
            if (snapshot.data.length > 0) {//VALIDATED
              return Stack(
                  children: [
                    ListView.builder(
                      reverse: false,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_, index) {
                        return _radioSelectorCars(snapshot.data[index], index);
                      }
                  ),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                         child: _buttonNewCar()
                        ),
                    ),

                  ],

              );
;

            }
            else {

              return _noCars();
            }

          }
          else {

            return _noCars();
          }

        }

    );

  }

  Widget _radioSelectorCars(Car cars, int index) {
    String colorCarBd =cars?.color ?? '';
    String colorWHex = "0xFF${colorCarBd}";
    int colorCar = int.parse(colorWHex);
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 38),
        child: Column(
          children: [
            Row(
              children: [
                Column(children: <Widget>[
                SizedBox(height: 32.0),
                GestureDetector(
                onTap: (){},
                child:  InkWell(
                  onTap: () => _con.goToAddress(cars),
                  child: CircleAvatar(
                        backgroundImage: cars.image != null
                            ? NetworkImage(cars.image)
                            : AssetImage('assets/img/logo.png'),
                        radius: 40,
                        backgroundColor: Colors.grey[200],
                      ),
                ),
                )],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28,bottom: 10),
                      child: Text(
                        'MARCA',
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
                        cars?.marca ?? '',
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Lexendeca-Black',

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
                      padding: const EdgeInsets.only(left: 28,bottom: 10),
                      child: Text(
                        'MODELO',
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
                          color: Colors.black54,
                          fontFamily: 'Lexendeca-Black',

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
                      padding: const EdgeInsets.only(left: 8,bottom: 10),
                      child: Text(
                        'AÑO',
                        style: TextStyle(
                            color: Colors.white,
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
                          fontFamily: 'Lexendeca-Black',
                          color: Colors.black54,
                        ),
                      ),
                    ),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:0, left: 8,bottom: 10),
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
                        backgroundColor: Colors.white),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:0, left: 8,bottom: 10),
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
                          fontFamily: 'Lexendeca-Black',
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 20,bottom: 5),
                      child: _iconDelete(cars),
                    )

                  ],
                ),

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

  Widget _textTitle() {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Text(
        'Selecciona un vehículo o añade uno ',
        style: TextStyle(
          color: Colors.white,
            fontSize: 19,
            fontFamily: 'Lexendeca-Regular',
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }



  Widget _iconDelete(Car cars) {
    return IconButton(
        onPressed: () {
          _con.deleteCar(cars);
        },
        icon: Icon(Icons.delete, color: Colors.white,)
    );
  }

  void refresh() {
    setState(() {

    });

  }




}
