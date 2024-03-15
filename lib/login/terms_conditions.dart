import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotel/login/welcomepage2.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({Key? key}) : super(key: key);

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      decoration: BoxDecoration(
        color: ThemeProvider.of(context).backgroundColor,
        /*image: DecorationImage(
            image: AssetImage("assets/images/wallpaper3.jpg"),
            fit: BoxFit.cover,
          ),*/
      ),
      child: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              'Terms and Conditions',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: ThemeProvider.of(context).focusColor,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    color: Color.fromARGB(255, 128, 147, 241).withOpacity(1)),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    'It includes a copyright clause that reminds website visitors of their copyright and trademark ownership over certain elements as well as brings to their attention that the website itself as well as its materials (such as images, illustrations, posts, audio clips, taw, and video clips) '
                    'are property of the company and thus protected by intellectual property laws.”).',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    color: Colors.white.withOpacity(0.4)),
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Back',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: Color.fromARGB(255, 128, 147, 241),
                          decoration: TextDecoration.none),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomePage2()));
                  },
                )),
          ],
        ),
      ),
    ));
  }
}
