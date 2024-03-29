import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/animated_indicator.dart';
import '../../../utils/my_colors.dart';

const blue = Color(0xFF4781ff);
const kTitleStyle = TextStyle(
    fontSize: 30, color: MyColors.colorWhite, fontWeight: FontWeight.bold);
const kSubtitleStyle = TextStyle(fontSize: 18, color: MyColors.colorWhite);


class IntroductionScreenPage extends StatefulWidget {
  const IntroductionScreenPage({Key key}) : super(key: key);

  @override
  _IntroductionScreenPageState createState() => _IntroductionScreenPageState();
}

class _IntroductionScreenPageState extends State<IntroductionScreenPage> {
  PageController pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  MyColors.colorAqua,
                  MyColors.primaryColor,
                ],
              ),
            ),
            child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Slide(
                      hero: Image.asset("./assets/images/intro1.png"),
                      title: "Rápido y Fácil",
                      subtitle:
                      "Pide un servicio y despreocupate",
                      onNext: nextPage),
                  Slide(
                      hero: Image.asset("./assets/images/intro2.png"),
                      title: "Seguro",
                      subtitle:
                      "Todos nuestro personal esta verificado, despreocupate",
                      onNext: nextPage),
                  Slide(
                      hero: Image.asset("./assets/images/introcard.png"),
                      title: "Pagos seguros",
                      subtitle:
                      "Nuestra plata forma cuenta con pasarelas de pago seguras, para que tengas la mejor experiencia.",

                      onNext: goToLogin),

                ])),
      ),
    );
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  void goToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);

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
            padding: const EdgeInsets.all(20),
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
                  height: 35,
                ),
                ProgressButton(onNext: onNext),
              ],
            ),
          ),
          GestureDetector(
            onTap: onNext,
            child: Text(
              "Skip",
              style: kSubtitleStyle,
            ),
          ),
          SizedBox(
            height: 4,
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
      width: 75,
      height: 75,
      child: Stack(children: [
        AnimatedIndicator(
          duration: const Duration(seconds: 10),
          size: 75,
          callback: onNext,
        ),
        Center(
          child: GestureDetector(
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                child: SvgPicture.asset(
                  "./assets/img/arrow.svg",
                  width: 10,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99), color: blue),
            ),
            onTap: onNext,
          ),
        )
      ]),
    );
  }

}