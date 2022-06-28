import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_timeline/progress_timeline.dart';
import '../../../../utils/my_colors.dart';
import 'onway_cleaner_controller.dart';



const blue = Color(0xFF4781ff);
const kTitleStyle = TextStyle(
    fontSize: 30, color: MyColors.colorWhite, fontWeight: FontWeight.bold);
const kSubtitleStyle = TextStyle(fontSize: 18, color: MyColors.colorWhite);


class OnwayCleanerPage extends StatefulWidget {
  const OnwayCleanerPage({Key key}) : super(key: key);

  @override
  _OnwayCleanerPageState createState() => _OnwayCleanerPageState();
}

class _OnwayCleanerPageState extends State<OnwayCleanerPage> {
  PageController pageController = new PageController(initialPage: 0);
  OnWayCleanerController _con = new OnWayCleanerController();
  ProgressTimeline screenProgress;
  ProgressTimeline screenProgress2;
  List<SingleState> allStages = [
    SingleState(stateTitle: "En camino"),
    SingleState(stateTitle: ""),

  ];

  List<SingleState> allStages2 = [
    SingleState(stateTitle: "Lavando"),
    SingleState(stateTitle: "Finalizado"),

  ];
  int minutesWait = 15;
  String mensajeTimer = 'Min.';
  String addressService;

  @override
  void initState() {
    screenProgress = new ProgressTimeline(
      states: allStages,
      checkedIcon: Icon(Icons.check, color: Colors.green),
      connectorColor: Colors.green,
      currentIcon: Icon(Icons.album_rounded, color: Colors.green),
      connectorLength: 40,
      connectorWidth: 5.0,
      textStyle: TextStyle(color: Colors.green),
      // uncheckedIcon: Icon(Icons.album_rounded),
      iconSize: 25,
    );
    screenProgress2 = new ProgressTimeline(
      states: allStages2,
      checkedIcon: Icon(Icons.check),
      connectorColor: Colors.black,
      currentIcon: Icon(Icons.adjust),
      connectorWidth: 5.0,
      uncheckedIcon: Icon(Icons.adjust),
      iconSize: 25,
    );

    //
    // setState(() {
    //   adressState = _con.addressName;
    // });
    // TODO: implement initState
    super.initState();
    _startTime();
    _startInitAdress();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.81,
              child: _googleMaps()

          ),
          SafeArea(
            child: Column(
              children: [
                //  _buttonBack(),
                //_buttonCenterPosition(),

                Spacer(),
                _cardOrderInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _startInitAdress() {

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
         addressService = _con.addressName;
        print("SERVICEX $addressService");
      });
    });
  }

  void _startTime() {
    print('TIMEX 1');
    print('TIMEX 2 $minutesWait');
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        if (minutesWait == 3) {
          mensajeTimer = 'Arrivando';
        }
        minutesWait--;
        print('TIMEX 3 $minutesWait');
      });
    });
  }

  Widget _cardOrderInfo() {
    return Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.20,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3)
                  )
                ]
            ),
            child: Stack(
              children: [
                _clientInfo(),
                _step(),
                _timerW(),
                _listTileAddress(addressService),
                Divider(color: Colors.grey[400], endIndent: 0, indent: 30,),

              ],
            ),

          )
        ]);
  }

  Widget _step() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(right: MediaQuery
          .of(context)
          .size
          .height * 0.04, left: MediaQuery
          .of(context)
          .size
          .height * 0.0, top: MediaQuery
          .of(context)
          .size
          .height * 0.03),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: Container(
              width: 75,
              height: 45,
              color: Colors.black,
              child: Center(child: Text(
                "$minutesWait",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white
                ),
              )
              ),

            ),
          ),
          Container(
            color: Colors.black,
            child: Container(
              width: 75,
              color: Colors.black,
              padding: EdgeInsets.only(bottom: 7),
              child: Center(child: Text(
                "$mensajeTimer",
                style: TextStyle(
                    color: Colors.white
                ),
              )
              ),

            ),
          ),
        ],
      ),

    );
  }

  Widget _timerW() {
    return Stack(
      children: [
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(right: MediaQuery
                .of(context)
                .size
                .height * 0.0, left: MediaQuery
                .of(context)
                .size
                .height * 0.19, top: MediaQuery
                .of(context)
                .size
                .height * 0.03),
            width: 100,
            height: 70,
            child: screenProgress
        ),
        Container(
            width: 200,
            height: 70,
            margin: EdgeInsets.only(right: MediaQuery
                .of(context)
                .size
                .height * 0.0, left: MediaQuery
                .of(context)
                .size
                .height * 0.2709, top: MediaQuery
                .of(context)
                .size
                .height * 0.03),
            child: screenProgress2
        ),

      ],
    );
  }

  Widget _clientInfo() {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery
          .of(context)
          .size
          .height * 0.03, top: MediaQuery
          .of(context)
          .size
          .height * 0.03),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: FadeInImage(
              image: _con.order?.delivery?.image != null
                  ? NetworkImage(_con.order?.delivery?.image)
                  : AssetImage('assets/img/add_image.png',),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/add_image.png'),
            ),
          ),

        ],
      ),
    );
  }


  Widget _listTileAddress(String title) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(right: MediaQuery
              .of(context)
              .size
              .height * 0.0, left: MediaQuery
              .of(context)
              .size
              .height * 0.0, top: MediaQuery
              .of(context)
              .size
              .height * 0.12),
          child: Text(
            'Lugar servicio ',
            style: TextStyle(
                fontFamily: 'Lexendeca-Black',
                color: Colors.blue[900],
                fontSize: 14
            ),
          ),

        ),
        Container(
          margin: EdgeInsets.only(right: MediaQuery
              .of(context)
              .size
              .height * 0, left: MediaQuery
              .of(context)
              .size
              .height * 0.0, top: MediaQuery
              .of(context)
              .size
              .height * 0.01),
          child: Text(
            title ?? '',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Lexendeca-Regular',
                fontSize: 14
            ),
          ),


        ),
      ],
    );
  }

  void nextPage() {

  }

  void goToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

  Widget _googleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),
      polylines: _con.polylines,
    );
  }

  void refresh() {
    setState(() {});
  }



}
