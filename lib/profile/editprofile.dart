import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lotel/profile/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lotel/profile/widgets/profile_list_item.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'Settings.dart';

class editprofilescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(414, 896));

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 14,
            width: kSpacingUnit.w * 14,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 8),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 7,
                  backgroundImage: AssetImage('asset/xqcl.jpg'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 3.5,
                    width: kSpacingUnit.w * 3.5,
                    decoration: BoxDecoration(
                        color: ThemeProvider.of(context).accentColor,
                        shape: BoxShape.circle,
                        border: Border.all()),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: ThemeProvider.of(context).primaryColor,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 1.5),
        IconButton(
          splashRadius: 20,
          icon: Icon(LineAwesomeIcons.arrow_left),
          iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
        profileInfo,
        SizedBox(width: kSpacingUnit.w * 6),
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[SizedBox(height: kSpacingUnit.w * 5), header],
            ),
          );
        },
      ),
    );
  }
}
