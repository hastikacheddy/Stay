import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lotel/mainApp/blocs/application_bloc.dart';
import 'package:lotel/mainApp/pages/navpages/home_page.dart';
import 'package:lotel/mainApp/pages/navpages/map_page.dart';
import 'package:provider/provider.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({Key? key}) : super(key: key);

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  final screens = [HomePage(), MapPage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Applicationbloc(),
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 0,
          selectedFontSize: 0,
          currentIndex: currentIndex,
          unselectedItemColor: Colors.green,
          selectedItemColor: Colors.yellow,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                'img/ahouse.png',
                width: 30,
                color: Color.fromARGB(255, 187, 134, 252),
              ),
              icon: Image.asset(
                'img/house.png',
                width: 30,
                color: Color.fromARGB(255, 171, 171, 171),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'img/map.png',
                  width: 30,
                  color: Color.fromARGB(255, 187, 134, 252),
                ),
                icon: Image.asset(
                  'img/map.png',
                  width: 30,
                  color: Color.fromARGB(255, 171, 171, 171),
                ),
                label: "Map"),
          ],
        ),
      ),
    );
  }
}
