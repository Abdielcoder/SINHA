import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';
import 'package:uber_clone_flutter/src/models/category.dart';
import 'package:uber_clone_flutter/src/models/product.dart';
import 'package:uber_clone_flutter/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';
import 'package:uber_clone_flutter/src/widgets/no_data_widget.dart';

import '../../../../utils/animacion_particulas.dart';
import '../../../drawer/DrawerScreen.dart';
import '../../listcarspay/list_car_pay_page.dart';
import '../../states/request/request_cleaner_page.dart';

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
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //  _con.init(context, refresh);
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
                    'Solicita servicio',
                    style: TextStyle(
                        fontFamily: "Lexendeca-Regular",
                        fontSize: 39,
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
                  // Text(
                  //   "Login & Sign Up Screen",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.w700,
                  //       fontFamily: "Sofia"),
                  // )
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
                        padding: const EdgeInsets
                            .only(top: 400,left: 50),
                        child: Container(
                          width: 300,
                          height: 70,

                            child: ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   new MaterialPageRoute(
                                  //     builder: (context) => new RequestCleanerPage(),
                                  //   ),
                                  // );
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => new ListCarPayPage(),
                                    ),
                                  );


                                },
                                child: Text('SERVICIO'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black87,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 15)
                                )
                            )
                        ),
                      ),




                    ],
                  )

              ),
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
                              Colors.purple[800],
                              Colors.purple[800],
                              Colors.purple[900]


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
                          child: const AnimacionParticulas(23)),
                    ),


                  ],
                )

              ],
            )
          ],
        ),
      ),
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

  Widget _buttonRequest() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: (){},
        child: Text('REGISTRARSE'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
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