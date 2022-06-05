import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:uber_clone_flutter/src/pages/client/states/request/request_cleaner_controller.dart';

import '../../../../models/order.dart';
import '../../../../models/product.dart';
import '../../../../models/response_api.dart';
import '../../../../models/user.dart';
import '../../../../provider/orders_provider.dart';
import '../../../../utils/animated_indicator.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_snackbar.dart';
import '../../../../utils/shared_pref.dart';
import '../../products/list/client_menu_list.dart';


const blue = Color(0xFF4781ff);
const kTitleStyle = TextStyle(
    fontSize: 30, color: MyColors.colorWhite, fontWeight: FontWeight.bold);
const kSubtitleStyle = TextStyle(fontSize: 18, color: MyColors.colorWhite);


class RequestCleanerPage extends StatefulWidget {
  const RequestCleanerPage({Key key}) : super(key: key);
  @override
  _RequestCleanerPagePageState createState() => _RequestCleanerPagePageState();
}

class _RequestCleanerPagePageState extends State<RequestCleanerPage> {
  List<Product> selectedProducts = [];
  SharedPref _sharedPref = new SharedPref();
  PageController pageController = new PageController(initialPage: 0);
  RequestCleanerCOntroller _con = new RequestCleanerCOntroller();
  OrdersProvider _ordersProvider = new OrdersProvider();
  User user;

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
                          'assets/json/buscando.json',
                          fit: BoxFit.fill
                      ),
                      title: "Buscando personal disponible",
                      subtitle:
                      "En unos momentos te sera asignado...",
                      onNext: nextPage,
                      cancel: cancelServices),

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

  void cancelServices() async{

    user = User.fromJson(await _sharedPref.read('user'));

    Order order = new Order(
      idClient: user.id,
      status: 'CANCEL',
      lat: 0,
    );
      ResponseApi responseApi = await _ordersProvider.updateCancelWash(order);
      print('RequestCleanerPage *Response API* : $responseApi');
      if (responseApi.success) {
        MySnackbar.show(context, 'Se cancelo tu servicio');

        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(builder: (BuildContext context) => const ClientMenuListPage()),
          ModalRoute.withName('client/products/list',),
        );
    }
    else {
      MySnackbar.show(context, 'No podemos cancelar tu orden en estos momentos');
    }

  }


}



class Slide extends StatelessWidget {
  final Widget hero;
  final String title;
  final String subtitle;
  final VoidCallback onNext;
  final VoidCallback cancel;

  const Slide({Key key, this.hero, this.title, this.subtitle, this.onNext, this.cancel})
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
                ProgressButton(cancel: cancel),
              ],
            ),
          ),
          GestureDetector(
            onTap: ()=>cancel(),
            child: Text(
              "Cancelar",
              style: kSubtitleStyle,
            ),
          ),
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
  final VoidCallback cancel;
  const ProgressButton({Key key, this.onNext,this.cancel}) : super(key: key);

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

        Center(
          child: GestureDetector(

            child: Container(
              height: 60,
              width: 60,

              child: Center(

                child: Image.asset(
                  "./assets/images/cancelarlavador.png",
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
            onTap: ()=>cancel(),
          ),

        ),

      ]),
    );
  }




}