import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_timeline/progress_timeline.dart';
import 'package:uber_clone_flutter/src/pages/client/states/inprogress/inprogress_cleaner_controller.dart';
import '../../../../utils/my_colors.dart';
import '../../products/list/client_menu_list.dart';


const blue = Color(0xFF4781ff);
const kTitleStyle = TextStyle(
    fontSize: 30, color: MyColors.colorWhite, fontWeight: FontWeight.bold);
const kSubtitleStyle = TextStyle(fontSize: 18, color: MyColors.colorWhite);


class InprogressCleanerPage extends StatefulWidget {
  const InprogressCleanerPage({Key key}) : super(key: key);

  @override
  _InprogressCleanerPageState createState() => _InprogressCleanerPageState();
}

class _InprogressCleanerPageState extends State<InprogressCleanerPage> {
  PageController pageController = new PageController(initialPage: 0);
  InprogressCleanerController _con = new InprogressCleanerController();

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

  int minutesWait = 30;
  String mensajeTimer= 'Lavando';
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
      currentIcon: Icon(Icons.album_rounded,color: Colors.green),
      connectorLength: 90,
      connectorWidth: 5.0,
      textStyle: TextStyle(color: Colors.green),
      iconSize: 25,
    );

    screenProgress3 = new ProgressTimeline(
      states: allStages3,
      checkedIcon: Icon(Icons.check),
      connectorColor: Colors.black,
      currentIcon: Icon(Icons.adjust),


      uncheckedIcon: Icon(Icons.adjust),
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
              height: MediaQuery.of(context).size.height * 0.81,
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
                                'assets/json/limpio.json',
                                fit: BoxFit.fill
                            ),
                            title: "Tu servicio esta en proceso",
                            subtitle:
                            "Te avisaremos una vez concluya...",
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
        if(minutesWait > 12){
          mensajeTimer= 'Lavando';
        }
        if(minutesWait < 11){
          mensajeTimer= 'Finalizando';
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
            height: MediaQuery.of(context).size.height * 0.20,
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
                "$minutesWait min. ",
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
            width: 120,
            height: 70,
            child: screenProgress
        ),
        Container(
            width: 200,
            height: 70,
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.0, left: MediaQuery.of(context).size.height * 0.26, top:  MediaQuery.of(context).size.height * 0.03),
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


  Widget _listTileAddress(String title) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.0, left: MediaQuery.of(context).size.height * 0.0, top:  MediaQuery.of(context).size.height * 0.12),
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

//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//           child: Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: ExactAssetImage("assets/img/encamino.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: ClipRRect( // make sure we apply clip it properly
//               child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 30, sigmaY: 10),
//
//                   child: PageView(
//                       controller: pageController,
//                       physics: NeverScrollableScrollPhysics(),
//                       children: [
//                         Container(
//                           child: Slide(
//                               hero: Lottie.asset(
//                                   'assets/json/limpiando.json',
//                                   fit: BoxFit.fill
//                               ),
//                               title: "Tú servicio esta en curso",
//                               subtitle:
//                               "En espera de terminar el servicio...",
//                               onNext: nextPage),
//                         ),
//                       ])),
//             ),
//           )
//       ),
//     );
//   }
//
//
//   void nextPage() {
//
//   }
//
//   void goToLogin() {
//     Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
//
//   }
//   void refresh() {
//     setState(() {}); // CTRL + S
//   }
// }
//
// class Slide extends StatelessWidget {
//   final Widget hero;
//   final String title;
//   final String subtitle;
//   final VoidCallback onNext;
//
//   const Slide({Key key, this.hero, this.title, this.subtitle, this.onNext})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//               Expanded(child: hero),
//           Padding(
//             padding: const EdgeInsets.all(1),
//             child: Column(
//               children: [
//                 Text(
//                   title,
//                   style: kTitleStyle,
//
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   subtitle,
//                   style: kSubtitleStyle,
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 ProgressButton(onNext: onNext),
//               ],
//             ),
//           ),
//           // GestureDetector(
//           //   onTap: () {
//           //     Navigator.push(
//           //       context,
//           //       new MaterialPageRoute(
//           //         builder: (context) => new ClientMenuListPage(),
//           //       ),
//           //     );
//           //   },
//           //   child: Text(
//           //     "Cancelar",
//           //     style: kSubtitleStyle,
//           //   ),
//           // ),
//           SizedBox(
//             height: 50,
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class ProgressButton extends StatelessWidget {
//   final VoidCallback onNext;
//   const ProgressButton({Key key, this.onNext}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 140,
//       height: 140,
//       child: Stack(children: [
//         Container(
//           height: 500,
//           width: 500,
//           child: Lottie.asset(
//             'assets/json/pulse.json',
//             width: 500,
//             height: 500,
//           ),
//         ),
//
//         // Center(
//         //   child: GestureDetector(
//         //
//         //     child: Container(
//         //       height: 60,
//         //       width: 60,
//         //
//         //       child: Center(
//         //
//         //         child: Image.asset(
//         //           "./assets/images/cancelarlavador.png",
//         //           width: 600,
//         //         ),
//         //       ),
//         //       decoration: BoxDecoration(
//         //         borderRadius: BorderRadius.circular(99),
//         //         color: Colors.deepPurpleAccent,
//         //         boxShadow: [
//         //           BoxShadow(color: Colors.white, spreadRadius: 3),
//         //         ],
//         //       ),
//         //
//         //     ),
//         //     onTap: () {
//         //       Navigator.push(
//         //         context,
//         //         new MaterialPageRoute(
//         //           builder: (context) => new ClientMenuListPage(),
//         //         ),
//         //       );
//         //     },
//         //   ),
//         //
//         // ),
//
//       ]),
//     );
//   }

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