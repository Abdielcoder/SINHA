import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  List<SingleState> allStages = [
    SingleState(stateTitle: "En camino"),
    SingleState(stateTitle: "Lavando"),
    SingleState(stateTitle: "Finalizado"),

  ];

  @override
  void initState() {

    screenProgress = new ProgressTimeline(
      states: allStages,
      checkedIcon: Icon(Icons.check),
      connectorColor: Colors.blue,
      connectorWidth: 8.0,
      currentIcon: Icon(Icons.ac_unit),
      iconSize: 35,
    );
    // TODO: implement initState
    super.initState();

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
              height: MediaQuery.of(context).size.height * 0.67,
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

  Widget _cardOrderInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.36,
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
      child: Column(
        children: [
         _step(),
          _listTileAddress(_con.addressName, 'Direccion', Icons.location_on),
          Divider(color: Colors.grey[400], endIndent: 30, indent: 30,),
          _clientInfo(),
        ],
      ),
    );
  }

Widget _step(){
  return Container(
    margin: EdgeInsets.only(top: 20),
      child: screenProgress
  );
}
  Widget _clientInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: FadeInImage(
              image: _con.order?.delivery?.image != null
                  ? NetworkImage(_con.order?.delivery?.image)
                  : AssetImage('assets/img/no-image.png',),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              '${_con.order?.delivery?.name ?? ''} ${_con.order?.delivery?.lastname ?? ''}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              maxLines: 1,
            ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.grey[200]
            ),
            // child: IconButton(
            //   onPressed: _con.call,
            //   icon: Icon(Icons.phone, color: Colors.black,),
            // ),
          )
        ],
      ),
    );
  }


  Widget _listTileAddress(String title, String subtitle, IconData iconData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        title: Text(
          title ?? '',
          style: TextStyle(
              fontSize: 13
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(iconData),
      ),
    );
  }

  Widget _buttonCenterPosition() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.location_searching,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buttonBack() {
  //   return GestureDetector(
  //     onTap: _con.close,
  //     child: Container(
  //       alignment: Alignment.centerLeft,
  //       margin: EdgeInsets.symmetric(horizontal: 5),
  //       child: Card(
  //         shape: CircleBorder(),
  //         color: Colors.white,
  //         elevation: 4.0,
  //         child: Container(
  //           padding: EdgeInsets.all(10),
  //           child: Icon(
  //             Icons.arrow_back_ios,
  //             color: Colors.grey[600],
  //             size: 20,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }




  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.transparent,
  //     body: SafeArea(
  //         child: Container(
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //               image: ExactAssetImage("assets/img/encamino.jpg"),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           child: ClipRRect( // make sure we apply clip it properly
  //             child: BackdropFilter(
  //                 filter: ImageFilter.blur(sigmaX: 30, sigmaY: 10),
  //
  //                 child: PageView(
  //                     controller: pageController,
  //                     physics: NeverScrollableScrollPhysics(),
  //                     children: [
  //                       Slide(
  //                           hero: Lottie.asset(
  //                               'assets/json/encamino.json',
  //                               fit: BoxFit.fill
  //                           ),
  //                           title: "Tú servicio esta en camino",
  //                           subtitle:
  //                           "En espera de llegada...",
  //                           onNext: nextPage),
  //                     ])),
  //           ),
  //         )
  //     ),
  //   );
  // }


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
    if (!mounted) return;
    setState(() {});
  }

}

class Slide extends StatelessWidget {
  final Widget hero;
  final String title;
  final String subtitle;
  final VoidCallback onNext;

  const Slide({Key key, this.hero, this.title, this.subtitle, this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: hero),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              children: [
                Text(
                  title,
                  style: kTitleStyle,

                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  subtitle,
                  style: kSubtitleStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
               // ProgressButton(onNext: onNext),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       new MaterialPageRoute(
          //         builder: (context) => new ClientMenuListPage(),
          //       ),
          //     );
          //   },
          //   child: Text(
          //     "Cancelar",
          //     style: kSubtitleStyle,
          //   ),
          // ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

// class ProgressButton extends StatelessWidget {
//   final VoidCallback onNext;
//   const ProgressButton({Key key, this.onNext}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     width: 140,
  //     height: 140,
  //     child: Stack(children: [
  //       Container(
  //         height: 500,
  //         width: 500,
  //         child: Lottie.asset(
  //           'assets/json/pulse.json',
  //           width: 500,
  //           height: 500,
  //         ),
  //       ),
  //
  //       // Center(
  //       //   child: GestureDetector(
  //       //
  //       //     child: Container(
  //       //       height: 60,
  //       //       width: 60,
  //       //
  //       //       child: Center(
  //       //
  //       //         child: Image.asset(
  //       //           "./assets/images/cancelarlavador.png",
  //       //           width: 600,
  //       //         ),
  //       //       ),
  //       //       decoration: BoxDecoration(
  //       //         borderRadius: BorderRadius.circular(99),
  //       //         color: Colors.deepPurpleAccent,
  //       //         boxShadow: [
  //       //           BoxShadow(color: Colors.white, spreadRadius: 3),
  //       //         ],
  //       //       ),
  //       //
  //       //     ),
  //       //     onTap: () {
  //       //       Navigator.push(
  //       //         context,
  //       //         new MaterialPageRoute(
  //       //           builder: (context) => new ClientMenuListPage(),
  //       //         ),
  //       //       );
  //       //     },
  //       //   ),
  //       //
  //       // ),
  //
  //     ]),
  //   );
  // }

