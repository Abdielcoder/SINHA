import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_timeline/progress_timeline.dart';
import 'package:uber_clone_flutter/src/pages/client/states/inprogress/inprogress_cleaner_controller.dart';
import '../../../../utils/my_colors.dart';
import '../../products/list/client_menu_list.dart';
import 'finish_cleaner_controller.dart';


const blue = Color(0xFF4781ff);
const kTitleStyle = TextStyle(
    fontSize: 30, color: MyColors.colorWhite, fontWeight: FontWeight.bold);
const kSubtitleStyle = TextStyle(fontSize: 18, color: MyColors.colorWhite);


class FinishCleanerPage extends StatefulWidget {
  const FinishCleanerPage({Key key}) : super(key: key);

  @override
  _FinishCleanerPage createState() => _FinishCleanerPage();
}

class _FinishCleanerPage extends State<FinishCleanerPage> {
  PageController pageController = new PageController(initialPage: 0);
  InprogressCleanerController _con = new InprogressCleanerController();
  double _ratingValue;
  ProgressTimeline screenProgress;
  ProgressTimeline screenProgress2;
  ProgressTimeline screenProgress3;

  List<SingleState> allStages = [
    SingleState(stateTitle: "En camino"),
    SingleState(stateTitle: ""),

  ];

  List<SingleState> allStages2 = [
    SingleState(stateTitle: "Lavando"),
    SingleState(stateTitle: ""),
  ];
  List<SingleState> allStages3 = [
    SingleState(stateTitle: "Finalizado"),

  ];

  int minutesWait = 0;
  String mensajeTimer= 'Min.';
  @override
  void initState() {

    screenProgress = new ProgressTimeline(
      states: allStages,
      checkedIcon: Icon(Icons.check,color: Colors.green),
      connectorColor: Colors.green,
      currentIcon: Icon(Icons.check,color: Colors.green),
      connectorLength: 60,
      connectorWidth: 5.0,
      textStyle: TextStyle(color: Colors.green),
      // uncheckedIcon: Icon(Icons.album_rounded),
      iconSize: 25,
    );

    screenProgress2 = new ProgressTimeline(
      states: allStages2,
      //    checkedIcon: Icon(Icons.access_time_filled_round,color: Colors.green),
      connectorColor: Colors.green,
      currentIcon: Icon(Icons.check,color: Colors.green),
      connectorLength: 90,
      connectorWidth: 5.0,
      textStyle: TextStyle(color: Colors.green),
      iconSize: 25,
    );

    screenProgress3 = new ProgressTimeline(
      states: allStages3,
      connectorColor: Colors.green,
      currentIcon: Icon(Icons.check,color: Colors.green),
      connectorLength: 90,
      connectorWidth: 5.0,
      textStyle: TextStyle(color: Colors.green),
      iconSize: 25,
    );

    // TODO: implement initState
    super.initState();
    _startTime();
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
              height: MediaQuery.of(context).size.height * 0.70,
              child: _ngk()

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

  Widget _ngk() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/img/buscando.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect( // make sure we apply clip it properly
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 10),

                  child: PageView(
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Slide(
                            hero: Lottie.asset(
                                'assets/json/done.json',
                                fit: BoxFit.fill
                            ),
                            title: "Tu servicio a finalizado",
                            subtitle:
                            "Tu auto esta lsisto...",
                            onNext: nextPage),
                      ])),
            ),
          )
      ),
    );
  }
  void _startTime(){
    print('TIMEX 1');
    print('TIMEX 2 $minutesWait');
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {

      });
    });


  }

  Widget _cardOrderInfo() {
    return Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
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
                _listTileAddress(_con.addressName),
                _ratingBar('Califica el servicio'),
                _Finish(),
                Divider(color: Colors.grey[400], endIndent: 0, indent: 30,),

              ],
            ),

          )]);
  }

  Widget _step(){
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.04, left: MediaQuery.of(context).size.height * 0.0, top:  MediaQuery.of(context).size.height * 0.03),
      child:  Column(
        children: [
          Container(
            color: Colors.black ,
            child: Container(
              width: 75,
              height: 45,
              color: Colors.black,
              child: Center(child: Text(
                "$minutesWait",
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.white
                ),
              )
              ),

            ),
          ),
          Container(
            color: Colors.black ,
            child: Container(
              width: 75,
              color: Colors.black,
              padding: EdgeInsets.all(7),
              child: Center(child: Text(
                "$mensajeTimer",
                style: TextStyle(
                    fontSize: 11,
                    fontWeight:FontWeight.bold ,
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

  Widget _timerW(){
    return  Stack(
      children: [
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.0, left: MediaQuery.of(context).size.height * 0.16, top:  MediaQuery.of(context).size.height * 0.03),
            width: 115,
            height: 70,
            child: screenProgress
        ),
        Container(
            width: 140,
            height: 70,
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.0, left: MediaQuery.of(context).size.height * 0.27, top:  MediaQuery.of(context).size.height * 0.03),
            child: screenProgress2
        ),
        Container(
            width: 200,
            height: 70,
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.0, left: MediaQuery.of(context).size.height * 0.397, top:  MediaQuery.of(context).size.height * 0.03),
            child: screenProgress3
        ),

      ],
    );

  }

  Widget _clientInfo() {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.03, top:  MediaQuery.of(context).size.height * 0.03),
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
  Widget _ratingBar(String title) {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.22, top:  MediaQuery.of(context).size.height * 0.17),
      child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 0.0,
            ),
      RatingBar(
      initialRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
      full: const Icon(Icons.star, color: Colors.orange),
      half: const Icon(
      Icons.star_half,
      color: Colors.orange,
      ),
      empty: const Icon(
      Icons.star_outline,
      color: Colors.orange,
      )),
      onRatingUpdate: (value) {
      setState(() {
      _ratingValue = value;
      });
      }),
      const SizedBox(height: 1),
      // Display the rate in number
      Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
      color: Colors.black, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
      _ratingValue != null ? _ratingValue.toString() : 'Califica!',
      style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      )
      ]),
    );
  }

  Widget _Finish() {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.5, top:  MediaQuery.of(context).size.height * 0.22),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 0.0,
            ),
            ElevatedButton(
                child: Text(
                    "Finalizar".toUpperCase(),
                    style: TextStyle(fontSize: 14)
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.purple)
                        )
                    )
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) => ClientMenuListPage()),
                    ModalRoute.withName('client/states/cleaner',),
                  );

                }
            )
          ]),
    );
  }

  Widget _listTileAddress(String title) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.0, left: MediaQuery.of(context).size.height * 0.0, top:  MediaQuery.of(context).size.height * 0.10),
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
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0, left: MediaQuery.of(context).size.height * 0.0, top:  MediaQuery.of(context).size.height * 0.01),
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
