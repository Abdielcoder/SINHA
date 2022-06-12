import 'dart:ui';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';
import 'package:uber_clone_flutter/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';
import '../../../../utils/animacion_particulas.dart';
import '../../listcarspay/list_car_pay_page.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key key}) : super(key: key);
  @override
  _ClientProductsListPageState createState() => _ClientProductsListPageState();
}
class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ProgressDialog _progressDialog;
  ClientProductsListController _con = new ClientProductsListController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressDialog = ProgressDialog();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.purple[900],
        borderRadius:
        isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isDrawerOpen
                      ? GestureDetector(
                    child: Icon(Icons.arrow_back_ios,
                      color: MyColors.colorWhite,),
                    onTap: () {
                      setState(() {
                        xOffset = 0;
                        yOffset = 0;
                        isDrawerOpen = false;
                      });
                    },
                  )
                      : GestureDetector(
                    child: Icon(Icons.menu,
                      color: MyColors.colorWhite,),
                    onTap: () {
                      setState(() {
                        xOffset = 290;
                        yOffset = 80;
                        isDrawerOpen = true;
                      });
                    },
                  ),
                  Text(
                    'Solicita un servicio',
                    style: TextStyle(
                        fontFamily: "Lexendeca-Black",
                        fontSize: 27,
                        color: MyColors.colorWhite,
                        decoration: TextDecoration.none),
                  ),
                  Container(),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: FadeAnimation(
                  1,
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets
                            .only(top: 60,left: 90),
                        child: CircleAvatar(
                          backgroundColor: Colors
                              .white.withOpacity(0.3),
                          radius: 130,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets
                            .only(top: 80,left: 70),
                        child: CircleAvatar(
                          backgroundColor: Colors
                              .white.withOpacity(0.3),
                          radius: 130,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets
                            .only(top: 70),
                        child: Container(
                          width: 400,
                          height: 200,
                          child: Lottie.asset(
                              'assets/json/wash.json',
                              fit: BoxFit.fill
                          ),
                        ),
                      ),

                      Padding(
                      padding: const EdgeInsets.only(top: 400),
                      child: Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.180),
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
                    "./assets/images/addwash.png",
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
                    onTap: ()
                    {
                      _progressDialog.showProgressDialog(context,dismissAfter: Duration(seconds: 3),textToBeDisplayed:'Un momento...',onDismiss:(){

                      });
                    Navigator.push(
                    context,
                    new MaterialPageRoute(
                    builder: (context) => new ListCarPayPage(),
                    ),
                    );
                    }
                    )

                    ),

               ]),
            )
          )
       )
                    ]
                  )
              )
            ),
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    AnimatedContainer(
                      width: double.infinity,
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: Duration(milliseconds: 1000),
                      decoration: BoxDecoration(
                          gradient: RadialGradient(colors: [
                            Colors.purple[500],
                            Colors.purple[600],
                            Colors.purple[700],
                            Colors.purple[800],
                            Colors.purple[900],

                          ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: <Widget>[
                                SizedBox(
                                  height: 440.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Opacity(
                          opacity: 0.5,
                          child: const AnimacionParticulas(66)),
                    ),


                  ],
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
class NewPadding extends StatelessWidget {
  final String image1;
  final String text1;
  final String image2;
  final String text2;
  const NewPadding({
    Key key,
    this.image1,
    this.text1,
    this.image2,
    this.text2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
    );
  }
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<String>()
      ..add("opacity", Tween(begin: 0.0, end: 1.0),
          Duration(milliseconds: 500))..add(
          "translateY", Tween(begin: -30.0, end: 0.0),
          Duration(milliseconds: 500), Curves.easeOut);
    return PlayAnimation<MultiTweenValues<String>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) =>
          Opacity(
            opacity: animation.get("opacity"),
            child: Transform.translate(
                offset: Offset(0, animation.get("translateY")), child: child),
          ),
    );
  }
}