import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:uber_clone_flutter/src/pages/drawer/DrawerScreenController.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';

import '../../provider/users_provider.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  DrawerScreenController _con = DrawerScreenController();
  UsersProvider usersProvider = new UsersProvider();

  void initState() {
    usersProvider.init(context);
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 350),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/img/circulolavador.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Voitu',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                InkWell(
                  onTap: _con.goToEditProfile,
                  child: NewRow(
                    //client/update
                    text: 'Editar perfil',
                    icon: Icons.account_circle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: _con.goToCreateCar,
                  child: NewRow(
                    text: 'Vehículos',
                    icon: Icons.directions_car,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: _con.goToMyServices,
                  child: NewRow(
                    text: 'Mis servicios',
                    icon: Icons.domain_verification_sharp,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  //onTap: _con.goTO,
                  child: NewRow(
                    text: 'Métodos de pago',
                    icon: Icons.add_card,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.cancel,
                  color: Colors.black.withOpacity(0.5),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: _con.logout,
                  child: Text(
                    'Cerrar sesion',
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const NewRow({
    Key key,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}