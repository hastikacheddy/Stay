import 'package:flutter/material.dart';

class Cardd {
  final String logo;
  final String number;
  final String title;
  final String plan;
  final List<Color> color;

  const Cardd(
      {required this.logo,
      required this.number,
      required this.title,
      required this.plan,
      required this.color});
}

List<Cardd> cards = [
  const Cardd(
      logo:
          "images/visa.png" ,
      number: " 1234     4567     6789     5678",
      title: "VISA",
      plan: "PLATINUM",
      color: [Color(0xFFFDC5F5), Color(0xFF8093F1)]),
  const Cardd(
      logo: "images/icons8-mastercard-512.png",
      number: " 1111     4444     5555     6660",
      title: "MASTERCARD",
      plan: "PREMIUM",
      color: [Color(0xffb388eb), Color(0xfff7aef8)]),
  const Cardd(
      logo:
      "images/visa.png" ,
      number: " 1234     4666     6666     5678",
      title: "VISA",
      plan: "PLATINUM",
      color: [Color(0xFF8093F1), Color(0xFF72DDF7)]),

];
