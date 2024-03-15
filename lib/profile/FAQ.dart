import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lotel/profile/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lotel/profile/faq_tile.dart';
import 'package:lotel/profile/widgets/profile_list_item.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:lotel/profile/Profile.dart';

import 'Settings.dart';

class FAQ extends StatelessWidget {
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
        SizedBox(width: kSpacingUnit.w * 2),
        Text(
          'FAQ',
          style: kBigTitleTextStyle,
        ),
      ],
    );

    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(height: kSpacingUnit.w * 5),
        header,
        Expanded(
          child: ListView(
            children:
                basicTiles.map((tile) => BasicTileWidget(tile: tile)).toList(),
          ),
        ),
      ],
    ));
  }
}

class BasicTileWidget extends StatelessWidget {
  final BasicTile tile;

  const BasicTileWidget({
    required this.tile,
  });

  @override
  Widget build(BuildContext context) {
    final title = tile.title;
    final desc = tile.desc;

    return Container(
      margin: EdgeInsets.only(left: 16, top: 30, right: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
        iconColor: Theme.of(context).accentColor,
        title:
            Text(title, style: TextStyle(color: Theme.of(context).accentColor)),
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Text(desc,
                  style: TextStyle(color: Theme.of(context).accentColor)))
        ],
      ),
    );
  }
}
