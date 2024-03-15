import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:lotel/pay/payment/Animation/fade.dart';
import 'package:lotel/pay/payment/model/card.dart';
import 'package:lotel/pay/payment/pages/card_info.dart';
import 'package:lotel/pay/payment/pages/widget_cards.dart';
import 'package:flutter/material.dart';
import 'package:lotel/pay/payment/pages/text_recognition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:lotel/pay/payment/controllers/payment_controller.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  final PageController _controllerPage = PageController();
  AnimationController? _controller;
  late Animation<double> _rotection;
  AnimationController? _controllerprogress;
  Animation<double>? _prograsser;

  bool isOpen = true; // For show card info.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _rotection = Tween(begin: 0.0, end: 90.0).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn));
    _controllerprogress = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..addListener(() {
        setState(() {});
      });

    _prograsser = Tween(begin: 0.0, end: 0.6).animate(_controllerprogress!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerPage.dispose();
    _controller!.dispose();
    _controllerprogress!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeProvider.of(context).backgroundColor,
        iconTheme: IconThemeData(color: ThemeProvider.of(context).accentColor),
        elevation: 0,
        actions: [
          isOpen
              ? FadeAnimation(
                  delay: 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [


                       Text(
                        "Pay",
                        style: TextStyle(
                            fontFamily: 'QuickSand',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 18,
                            color: ThemeProvider.of(context).accentColor),
                      ),
                      SizedBox(
                        width: we * 0.45,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 27,
                        ),
                      ),
                      SizedBox(
                        width: we * 0.08,
                      ),
                    ],
                  ),
                )
              : FadeInDown(
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _controller!.reverse();
                            _controllerprogress!.reset();
                            isOpen = true;
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: we * 0.07,
                      ),
                      const Text(
                        "CARD DETAILS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                      SizedBox(
                        width: we * 0.3,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.swap_vert_outlined,
                          color: Colors.black,
                          size: 27,
                        ),
                      ),
                      SizedBox(
                        width: we * 0.08,
                      ),
                    ],
                  ),
                )
        ],
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SizedBox(
        width: we,
        height: he,
        child: Stack(children: [
          SizedBox(
            height: he * 0.01,
          ),
          FadeAnimation(
            delay: 0.5,
            child: SizedBox(
              width: we * 2,
              height: he * 0.3,
              child: AnimatedBuilder(
                animation: _controller!,
                builder: (context, child) {
                  return PageView.builder(
                      controller: _controllerPage,
                      itemCount: cards.length,
                      clipBehavior: Clip.none,
                      physics: isOpen
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Transform.rotate(
                            angle: _rotection.value * pi / 180,
                            alignment: Alignment.lerp(Alignment.center,
                                const Alignment(-.7, -.5), _controller!.value),
                            child: InkWell(
                              onTap: () {
                                _controller!.forward();
                                _controllerprogress!.forward();
                                setState(() {
                                  isOpen = false;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                width: 300,
                                height: 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    gradient:
                                        LinearGradient(colors: cards[i].color)),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: he * 0.1,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cards[i].title,
                                            style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1),
                                          ),
                                          SizedBox(
                                            height: he * 0.01,
                                          ),
                                          Text(
                                            cards[i].plan,
                                            style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: we * 0.35,
                                      ),
                                      Image.asset(
                                        cards[i].logo,
                                        color: Colors.black,
                                        width: 70,
                                        height: 70,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: he * 0.08,
                                  ),
                                  Text(
                                    cards[i].number,
                                    style: GoogleFonts.abel(
                                        color: Colors.black,
                                        fontSize: 22,
                                        letterSpacing: 1),
                                  )
                                ]),
                              ),
                            ));
                      });
                },
              ),
            ),
          ),
          isOpen
              ? Positioned(
                  left: we * 0.45,
                  top: he * 0.32,
                  child: FadeAnimation(
                    delay: 0.6,
                    child: SmoothPageIndicator(
                      controller: _controllerPage,
                      count: cards.length,
                      effect: const WormEffect(
                        activeDotColor: Colors.black,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ),
                )
              : Positioned(
                  left: 150,
                  top: 40,
                  child: FadeInRight(
                    duration: const Duration(milliseconds: 400),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [],
                      ),
                    ),
                  ),
                ),
          isOpen
              ? Positioned(
                  left: we * 0.01,
                  height: he * 0.75,
                  child: FadeAnimation(
                    delay: 0.7,
                    child: SizedBox(
                      width: we * 1,
                      height: he * 0.09,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: he * 0.1,
                          ),
                          SizedBox(
                            width: we * 0.6,
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                controller.makePayment(
                                    amount: '25625', currency: 'MUR');
                                // Respond to button press
                              },
                              icon: const Icon(Icons.add,
                                  size: 20, color: Colors.pink),
                              label: const Text(
                                "Pay",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: he * 0.01,
                          ),
                          SizedBox(
                            width: we * 0.6,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SecondRoute()),
                                );

                                // Respond to button press
                              },
                              icon: const Icon(Icons.add,
                                  size: 20, color: Colors.pink),
                              label: const Text(
                                "Scan Card",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Positioned(
                  left: we * 0.4,
                  top: he * 0.17,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: he * 0.05,
                      ),
                      FadeInRight(
                        duration: const Duration(milliseconds: 600),
                        child: Row(
                          children: [
                            SizedBox(
                              width: we * 0.04,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: he * 0.02),
                      FadeInRight(
                        duration: const Duration(milliseconds: 700),
                        child: Row(
                          children: [
                            SizedBox(
                              width: we * 0.04,
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.payments_outlined,
                                  color: Colors.black.withOpacity(0.4),
                                  size: 28),
                              label: const Text(
                                "Remove card",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: he * 0.02),
                      FadeInRight(
                        duration: const Duration(milliseconds: 800),
                        child: Row(
                          children: [
                            SizedBox(
                              width: we * 0.04,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                controller.makePayment(
                                    amount: '25625',
                                    currency: 'MUR'); // Respond to button press
                              },
                              icon: Icon(Icons.paid_outlined,
                                  color: Colors.black.withOpacity(0.4),
                                  size: 28),
                              label: const Text(
                                "Pay with this card",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
          SizedBox(height: we * 0.01),
          isOpen
              ? Positioned(
                  top: he * 0.43,
                  child: FadeAnimation(
                    delay: 0.8,
                    child: SizedBox(
                      width: we * 1,
                      height: he * 0.4,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: we * 0.26),
                              width: we * 0.67,
                            ),
                          ]),
                    ),
                  ),
                )
              : Positioned(
                  left: we * 0.07,
                  top: he * 0.51,
                  child: Column(
                    children: [
                      const Items(),
                    ],
                  ),
                )
        ]),
      ),
    );
  }
}
