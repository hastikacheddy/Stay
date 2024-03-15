import 'package:flutter/material.dart';
import 'package:lotel/mainApp/pages/navpages/home_page.dart';
import 'package:lotel/mainApp/pages/navpages/map_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [HomePage(), MapPage()];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        currentIndex: currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromARGB(255, 187, 134, 252),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'img/ahouse.png',
              width: 30,
            ),
            icon: Image.asset(
              'img/house.png',
              width: 30,
              color: Colors.white,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'img/map.png',
                width: 30,
                color: Colors.white,
              ),
              label: "Map"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'img/wchat.png',
                width: 30,
                color: Colors.white,
              ),
              label: "Chat"),
        ],
      ),
    );
  }
}
