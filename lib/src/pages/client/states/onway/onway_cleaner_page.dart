import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:uber_clone_flutter/src/pages/client/states/onway/onway_cleaner_controller.dart';
import '../../../../utils/my_colors.dart';
import '../../products/list/client_menu_list.dart';


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
      backgroundColor: Colors.transparent,
      body: SafeArea(
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

                  child: PageView(
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Slide(
                            hero: Lottie.asset(
                                'assets/json/encamino.json',
                                fit: BoxFit.fill
                            ),
                            title: "Tú servicio esta en camino",
                            subtitle:
                            "En espera de llegada...",
                            onNext: nextPage),
                      ])),
            ),
          )
      ),
    );
  }


  void nextPage() {

  }

  void goToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);

  }
  void refresh() {
    setState(() {}); // CTRL + S
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
                ProgressButton(onNext: onNext),
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

class ProgressButton extends StatelessWidget {
  final VoidCallback onNext;
  const ProgressButton({Key key, this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

        // Center(
        //   child: GestureDetector(
        //
        //     child: Container(
        //       height: 60,
        //       width: 60,
        //
        //       child: Center(
        //
        //         child: Image.asset(
        //           "./assets/images/cancelarlavador.png",
        //           width: 600,
        //         ),
        //       ),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(99),
        //         color: Colors.deepPurpleAccent,
        //         boxShadow: [
        //           BoxShadow(color: Colors.white, spreadRadius: 3),
        //         ],
        //       ),
        //
        //     ),
        //     onTap: () {
        //       Navigator.push(
        //         context,
        //         new MaterialPageRoute(
        //           builder: (context) => new ClientMenuListPage(),
        //         ),
        //       );
        //     },
        //   ),
        //
        // ),

      ]),
    );
  }

}