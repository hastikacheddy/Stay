import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lotel/profile/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:lotel/profile/Profile.dart';
import 'package:flutter_button/social/facebook_auth_button.dart';
import 'package:flutter_button/social/google_auth_button.dart';
import 'package:flutter_button/social/twitter_auth_button.dart';

import 'Settings.dart';

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height));

    var header = Row(
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 1),
        IconButton(
          splashRadius: 20,
          icon: Icon(LineAwesomeIcons.arrow_left),
          iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
        SizedBox(width: kSpacingUnit.w * 2),
        Text(
          '',
          style: kBigTitleTextStyle,
        ),
      ],
    );

    return Scaffold(
      body: Column(children: <Widget>[
        SizedBox(height: kSpacingUnit.w * 5),
        header,
        SizedBox(height: kSpacingUnit.w * 5),
        Expanded(
          child: Container(
            height: kSpacingUnit.w * 3,
            margin: EdgeInsets.symmetric(
              horizontal: kSpacingUnit.w * 2,
            ).copyWith(
              bottom: kSpacingUnit.w * 1,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: kSpacingUnit.w * 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Theme.of(context).backgroundColor,
            ),
            child: Column(children: <Widget>[
              Align(
                  alignment: Alignment(0.0, -0.95),
                  child: Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "About Us",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ))),
              SizedBox(height: kSpacingUnit.w * 5),
              Align(
                  alignment: Alignment(-1.0, -1.0),
                  child: Text(
                    "Welcome to Stay, your number one source for all hotels and reservations. We're dedicated to providing you the very best, with an emphasis on low prices, genuine hotels and a calm and relaxing stay.Founded in 2020 by Hastika Cheddy, Stay has come a long way. We hope you enjoy our product as much as we enjoy offering it to you. If you have any questions or comments, please don't hesitate to contact us.",
                    style: TextStyle(fontSize: 20.0),
                  )),
            ]),
          ),
        ),
        Container(
            height: kSpacingUnit.w * 8,
            margin: EdgeInsets.symmetric(vertical: kSpacingUnit.w * 7.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CircularFBAuthButton(
                  size: 70.0,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  shadows: [
                    BoxShadow(
                      spreadRadius: 1.5,
                      blurRadius: 10,
                      offset: Offset(2, 6),
                      color: Colors.black,
                    ),
                  ],
                ),
                CircularTWAuthButton(
                  size: 70.0,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  wOpacity: true,
                  shadows: [
                    BoxShadow(
                      spreadRadius: 1.5,
                      blurRadius: 10,
                      offset: Offset(2, 6),
                      color: Colors.black,
                    ),
                  ],
                ),
                CircularGGAuthButton(
                  size: 70.0,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  shadows: [
                    BoxShadow(
                      spreadRadius: 1.5,
                      blurRadius: 10,
                      offset: Offset(2, 6),
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ))
      ]),
    );
  }
}
