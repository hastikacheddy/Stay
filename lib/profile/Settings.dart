import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lotel/profile/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lotel/profile/widgets/profile_list_item.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:lotel/profile/Profile.dart';
import 'package:alan_voice/alan_voice.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(414, 896));

    var header = Row(
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 1),
        IconButton(
          splashRadius: 20,
          icon: Icon(LineAwesomeIcons.arrow_left),
          iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
        ),
        SizedBox(width: kSpacingUnit.w * 2),
        Text(
          'Settings',
          style: kBigTitleTextStyle,
        ),
      ],
    );

    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(height: kSpacingUnit.w * 5),
        header,
        SizedBox(height: kSpacingUnit.w * 2),
        Expanded(
          child: ListView(
            children: <Widget>[
              ProfileListItem(
                icon: LineAwesomeIcons.user_plus,
                text: 'Invite',
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.comments,
                text: 'FAQ',
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.exclamation_circle,
                text: 'About',
              ),
            ],
          ),
        )
      ],
    ));
  }
}
