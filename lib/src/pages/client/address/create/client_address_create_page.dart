import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';

import 'client_address_create_controller.dart';

const blue = Color(0xFF4781ff);
const kTitleStyle = TextStyle(
    fontSize: 30, color: MyColors.colorWhite, fontWeight: FontWeight.bold);
const kSubtitleStyle = TextStyle(fontSize: 18, color: MyColors.colorWhite);


class ClientAddressCreatePage extends StatefulWidget {
  const ClientAddressCreatePage({Key key}) : super(key: key);

  @override
  _ClientAddressCreatePageState createState() => _ClientAddressCreatePageState();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {
  PageController pageController = new PageController(initialPage: 0);
  ClientAddressCreateController _con = new ClientAddressCreateController();

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

                  child: Column(
                      // controller: pageController,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        _textFieldRefPoint(),
                        _buttonAccept(),
                      ])),
            ),
          )
      ),
    );
  }
  void nextPage() {

  }

  Widget _textFieldAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.addressController,
        decoration: InputDecoration(
          labelText: 'Direccion',
          suffixIcon: Icon(
            Icons.location_on,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }

  Widget _textFieldRefPoint() {
     return SizedBox(
       width: 700,
       height: 400,
       child: Stack(children: [
         Container(
           height: 700,
           width: 800,
           child: Lottie.asset(
             'assets/json/pulse.json',
             width: 50,
             height: 50,
           ),
         ),

         Center(
           child: GestureDetector(

             child: Container(
               height: 80,
               width: 80,

               child: Center(

                 child: Image.asset(
                   "./assets/images/pinmaps.png",
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
             onTap: _con.openMap,

           ),

         ),
         Container(
           margin: new EdgeInsets.only(top: 300.0,right: 80,left: 80),
           child: Center(

               child: TextField(
                 style: TextStyle(
                   color: Colors.white,
                 ),
                 controller: _con.refPointController,
                 autofocus: false,
                 focusNode: AlwaysDisabledFocusNode(),
                 decoration: InputDecoration(
                     enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                     ),
                     focusedBorder: UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.pink),
                     ),
                     fillColor: Colors.white,
                   hintStyle: TextStyle(
                     color: Colors.white
                   ),
                   labelText: 'Preciona el icono Mapa',
                     labelStyle: TextStyle(
                         color: Colors.white
                     )
                 ),
               ),
           ),
         ),

       ]),
     );
       //Container(
    //   margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    //   child: TextField(
    //     controller: _con.refPointController,
    //     onTap: _con.openMap,
    //     autofocus: false,
    //     focusNode: AlwaysDisabledFocusNode(),
    //     decoration: InputDecoration(
    //       labelText: 'Punto de referencia',
    //       suffixIcon: Icon(
    //         Icons.map,
    //         size: 100,
    //         color: Colors.white,
    //       )
    //     ),
    //   ),
    // );
  }

  Widget _textFieldNeighborhood() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.neighborhoodController,
        decoration: InputDecoration(
          labelText: 'Barrio',
          suffixIcon: Icon(
            Icons.location_city,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }

  Widget _textCompleteData() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Completa estos datos',
        style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 80, horizontal: 80),
      child: ElevatedButton(
        onPressed: _con.createAddress,
        child: Text(
            'CREAR DIRECCIÓN'
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            primary: Colors.black
        ),
      ),
    );
  }

  void refresh() {
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


class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
