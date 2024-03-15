import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:lotel/profile/model/user.dart';
import 'package:lotel/profile/utils/user_preferences.dart';
import 'package:lotel/profile/widgets/appbar_widget.dart';
import 'package:lotel/profile/widgets/button_widget.dart';
import 'package:lotel/profile/widgets/profile_widget.dart';
import 'package:lotel/profile/widgets/textfield_widget.dart';
import 'package:group_button/group_button.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: "img/figir.jpg",
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) {
                    user.name = name;
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) {
                    user.email = email;
                  },
                ),
                const SizedBox(height: 50),
                GroupButton(
                  isRadio: false,
                  spacing: 10,
                  buttonHeight: 50,
                  buttonWidth: 120,
                  unselectedColor: Color(0xFF72DDF7),
                  borderRadius: BorderRadius.circular(10.0),
                  onSelected: (index, isSelected) =>
                      print('$index button is selected'),
                  buttons: ["Save"],
                )
              ],
            ),
          ),
        ),
      );
}
