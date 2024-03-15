import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lotel/login/welcomepage2.dart';
import 'package:lotel/profile/FAQ.dart';
import 'package:lotel/profile/constants.dart';
import 'package:lotel/profile/editprofile.dart';
import 'package:lotel/profile/scanner.dart';
import 'package:share/share.dart';
import 'package:lotel/profile/editprofile2.dart';

import '../Settings.dart';
import '../aboutus.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpacingUnit.w * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 4,
      ).copyWith(
        bottom: kSpacingUnit.w * 2.5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        color: Theme.of(context).backgroundColor,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: ThemeProvider.of(context).accentColor,
          shape: const StadiumBorder(),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: kSpacingUnit.w * 2.5,
            ),
            SizedBox(width: kSpacingUnit.w * 1.5),
            Text(
              this.text,
              style: kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                LineAwesomeIcons.angle_right,
                size: kSpacingUnit.w * 2.5,
              ),
          ],
        ),
        onPressed: () {
          if ((this.text) == "Account") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfilePage()));
          }
          if ((this.text) == "Invite") {
            share();
          }
          if ((this.text) == "FAQ") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FAQ()));
          }
          if ((this.text) == "About") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Aboutus()));
          }
          if ((this.text) == "Settings") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          }
          if ((this.text) == "QR-Scanner") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => scanner()));
          }
          if ((this.text) == "Logout") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage2()),
                  (Route<dynamic> route) => false,
            );
          }

        },
      ),
    );
  }

  void share() {
    const String text = "link to our app's playstore";
    Share.share(text);
  }
}
