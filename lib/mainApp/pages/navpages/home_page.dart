import 'dart:io';
import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lotel/mainApp/pages/navpages/service_page.dart';
import 'package:lotel/profile/Profile.dart';
import 'package:lotel/mainApp/hotelsList.dart';

import 'package:lotel/mainApp/pages/navpages/discover_page.dart';

import '../search_result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final hotelList = HotelList();
  var hotels;
  var bestOffers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    hotels = hotelList.getHotelList();
    bestOffers = hotelList.getBestOffers();
  }

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    int currentIndex = 0;

    return SafeArea(
        child: ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        const SizedBox(
          height: 30,
        ),
        FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: .93,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              child: const Text(
                "Where do\nyou want to go?",
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  image: const DecorationImage(
                      image: AssetImage("img/figir.jpg"), fit: BoxFit.cover),
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(
          height: 30,
        ),
        FractionallySizedBox(
          widthFactor: 0.93,
          child: TextField(
            textInputAction: TextInputAction.search,
            controller: editingController,
            onSubmitted: (value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Search(
                            searchKey: value,
                          )));
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: "Search Destination",
              prefixIcon: Icon(
                Icons.search,
                color: ThemeProvider.of(context).iconTheme.color,
              ),
              hintStyle: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  color: Color.fromARGB(255, 170, 170, 170)),
              fillColor: ThemeProvider.of(context).backgroundColor,
              filled: true,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),

        FractionallySizedBox(
          widthFactor: .93,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Discover places",
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DiscoverPage()));
                },
                icon: Image.asset('img/discover.png'),
              )
            ],
          ),
        ),

        //tabbar

        FractionallySizedBox(
          widthFactor: .95,
          child: Container(
            child: TabBar(
              padding: EdgeInsets.all(0),
              labelStyle: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color.fromARGB(255, 187, 134, 252),
              indicatorPadding: EdgeInsets.all(6),
              unselectedLabelColor: Color.fromARGB(255, 170, 170, 170),
              controller: _tabController,
              isScrollable: true,
              tabs: const [
                Tab(
                  text: "Popular",
                ),
                Tab(
                  text: "Nearby",
                ),
              ],
            ),
          ),
        ),

        const SizedBox(
          height: 15,
        ),

        Container(
          height: 210,
          width: 500,
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: hotels.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  var key = hotels.keys.elementAt(index);
                  var hotelMap = hotels[key];
                  var name = hotelMap!["name"].toString();
                  var price = hotelMap["price"].toString();
                  var picture = hotelMap["picture"].toString();
                  var location = hotelMap["location"].toString();
                  var ratings = hotelMap["rating"].toString();

                  return InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServicePage(
                                hotelName: name,
                                hotelPicture: picture,
                                hotelPrice: price,
                                hotelLocation: location,
                                hotelId: (index + 1).toString(),
                                rating: ratings,
                              )));
                    }),
                    child: Container(
                      width: 160,
                      margin: index == 0
                          ? EdgeInsets.only(left: 17)
                          : EdgeInsets.only(left: 18),
                      child: Stack(
                        children: [
                          Container(
                            width: 180,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(picture),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            width: 180,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(0, 0, 0, 0),
                                    Color.fromARGB(82, 0, 0, 0),
                                    Color.fromARGB(144, 0, 0, 0),
                                    Color.fromARGB(162, 0, 0, 0),
                                  ]),
                            ),
                          ),
                          Container(
                            width: 180,
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 120,
                                  margin: EdgeInsets.only(bottom: 10, left: 10),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: ThemeProvider.of(context)
                                            .dividerColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 10, top: 10),
                              width: 35,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color.fromARGB(255, 57, 57, 57),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 20,
                                      child: SvgPicture.asset(
                                        "img/starsvg.svg",
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                      ratings,
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          color: ThemeProvider.of(context)
                                              .dividerColor),
                                    ))
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount: hotels.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  var key = hotels.keys.elementAt(index);
                  var hotelMap = hotels[key];
                  var name = hotelMap!["name"].toString();
                  var price = hotelMap["price"].toString();
                  var picture = hotelMap["picture"].toString();
                  var location = hotelMap["location"].toString();
                  var ratings = hotelMap["rating"].toString();

                  return InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServicePage(
                                hotelName: name,
                                hotelPicture: picture,
                                hotelPrice: price,
                                hotelLocation: location,
                                hotelId: (index + 1).toString(),
                                rating: ratings,
                              )));
                    }),
                    child: Container(
                      width: 160,
                      margin: index == 0
                          ? EdgeInsets.only(left: 17)
                          : EdgeInsets.only(left: 18),
                      child: Stack(
                        children: [
                          Container(
                            width: 180,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(picture),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            width: 180,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(0, 0, 0, 0),
                                    Color.fromARGB(82, 0, 0, 0),
                                    Color.fromARGB(144, 0, 0, 0),
                                    Color.fromARGB(162, 0, 0, 0),
                                  ]),
                            ),
                          ),
                          Container(
                            width: 180,
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 120,
                                  margin: EdgeInsets.only(bottom: 10, left: 10),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 10, top: 10),
                              width: 35,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color.fromARGB(255, 57, 57, 57),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 20,
                                      child: SvgPicture.asset(
                                        "img/starsvg.svg",
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                      ratings,
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          color: ThemeProvider.of(context)
                                              .dividerColor),
                                    ))
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        SizedBox(
          height: 40,
        ),

        const FractionallySizedBox(
          widthFactor: .93,
          child: Text(
            "Best Offers",
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
        ),

        const SizedBox(
          height: 30,
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: bestOffers.length,
          itemBuilder: (BuildContext context, int index) {
            var key = bestOffers.keys.elementAt(index);
            var hotelMap = bestOffers[key];
            var name = hotelMap!["name"].toString();
            var price = hotelMap["price"].toString();
            var picture = hotelMap["picture"].toString();
            var location = hotelMap["location"].toString();
            var ratings = hotelMap["rating"].toString();
            return InkWell(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServicePage(
                          hotelName: name,
                          hotelPicture: picture,
                          hotelPrice: price,
                          hotelLocation: location,
                          hotelId: (index + 1).toString(),
                          rating: ratings,
                        )));
              }),
              child: FractionallySizedBox(
                widthFactor: 0.93,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage(picture), fit: BoxFit.cover)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            right: 15,
                            left: 10,
                          ),
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: ThemeProvider.of(context).backgroundColor,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: ThemeProvider.of(context)
                                            .accentColor),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 3),
                                        child: SvgPicture.asset(
                                          "img/locsvg.svg",
                                          width: 15,
                                        )),
                                    Text(
                                      location,
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 160, 160, 160),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 170,
                                        child: AutoSizeText(
                                          "Access to 24/7 bar and free lunch",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 14,
                                            color: ThemeProvider.of(context)
                                                .accentColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            AutoSizeText(
                                              "Rs $price",
                                              style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 187, 137, 252),
                                              ),
                                            ),
                                            Text(
                                              "per night",
                                              style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 160, 160, 160),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ));
  }
}
