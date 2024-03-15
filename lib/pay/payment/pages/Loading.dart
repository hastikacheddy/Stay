import 'dart:async';
import 'package:lotel/pay/payment/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Loadpage extends StatefulWidget {
  @override
  State<Loadpage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Loadpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: const Homepage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7AEF8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Color.fromARGB(255, 114, 221, 247),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              "Loading...",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
