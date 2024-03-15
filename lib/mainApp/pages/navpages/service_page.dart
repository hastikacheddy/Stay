import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lotel/mainApp/pages/navpages/review_page.dart';
import 'package:lotel/pay/MyHomePage.dart';
import 'package:readmore/readmore.dart';
import '../../hotelsList.dart';

class ServicePage extends StatefulWidget {
  final String hotelName;
  final String hotelPrice;
  final String hotelPicture;
  final String hotelLocation;
  final String hotelId;
  final String rating;

  const ServicePage(
      {Key? key,
      required this.hotelName,
      required this.hotelPrice,
      required this.hotelPicture,
      required this.hotelLocation,
      required this.hotelId,
      required this.rating})
      : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  int _current = 0;
  List<String>? otherPictures;
  final CarouselController _controller = CarouselController();
  final hotelList = HotelList();

  ScrollController _scrollController = new ScrollController();

  bool _show = false;

  void showFloationButton() {
    setState(() {
      _show = true;
    });
  }

  void hideFloationButton() {
    setState(() {
      _show = false;
    });
  }

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideFloationButton();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showFloationButton();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    otherPictures = hotelList.getHotelPictures(widget.hotelId);
    handleScroll();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        children: [
          Stack(
            children: [
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                  height: 400.0,
                  viewportFraction: 1.0,
                ),
                items: otherPictures?.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Hero(
                        tag: 'dash',
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(i),
                                    fit: BoxFit.cover))),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 5),
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [1, 2, 3].asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: 40,
                      icon: SvgPicture.asset(
                        "img/backbutton.svg",
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        iconSize: 40,
                        icon: SvgPicture.asset(
                          "img/likebutton.svg",
                        )),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          FractionallySizedBox(
            widthFactor: 0.93,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: Text(
                        widget.hotelName,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
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
                          widget.hotelLocation,
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            color: Color.fromARGB(255, 160, 160, 160),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    AutoSizeText(
                      "Rs ${widget.hotelPrice}",
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 187, 137, 252),
                      ),
                    ),
                    Text(
                      "per night",
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FractionallySizedBox(
            widthFactor: 0.93,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: ThemeProvider.of(context).backgroundColor,
              ),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Reviews",
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ThemeProvider.of(context).accentColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 0),
                              child: SvgPicture.asset(
                                "img/starsvg.svg",
                                width: 10,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 3),
                              child: Text(
                                widget.rating,
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    color:
                                        ThemeProvider.of(context).accentColor),
                              ),
                            ),
                            Container(
                              child: Text(
                                " | 132 reviews",
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    color:
                                        ThemeProvider.of(context).accentColor),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 80,
                            child: Container(
                              child: CircleAvatar(
                                minRadius: 25,
                                backgroundImage: AssetImage("img/figir.jpg"),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 40,
                            child: Container(
                              child: CircleAvatar(
                                backgroundImage: AssetImage("img/figir 2.jpg"),
                                minRadius: 25,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: InkWell(
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReviewPage()));
                              }),
                              child: CircleAvatar(
                                backgroundImage: AssetImage("img/seeall.png"),
                                radius: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          const FractionallySizedBox(
            widthFactor: 0.93,
            child: Text(
              "What this place offers",
              style: TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w500,
                  fontSize: 19),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FractionallySizedBox(
            widthFactor: 0.90,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ThemeProvider.of(context).backgroundColor,
                  ),
                  width: 100,
                  child: Column(children: [
                    SvgPicture.asset(
                      "img/wifi.svg",
                      width: 35,
                      height: 35,
                      color: ThemeProvider.of(context).accentColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Wifi",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ThemeProvider.of(context).accentColor),
                    )
                  ]),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ThemeProvider.of(context).backgroundColor,
                  ),
                  width: 100,
                  child: Column(children: [
                    SvgPicture.asset(
                      "img/pool.svg",
                      width: 35,
                      height: 35,
                      color: ThemeProvider.of(context).accentColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pool",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ThemeProvider.of(context).accentColor),
                    )
                  ]),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ThemeProvider.of(context).backgroundColor,
                  ),
                  width: 100,
                  child: Column(children: [
                    SvgPicture.asset(
                      "img/food2.svg",
                      width: 35,
                      height: 35,
                      color: ThemeProvider.of(context).accentColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lunch",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ThemeProvider.of(context).accentColor),
                    )
                  ]),
                )
              ],
            )),
          ),
          SizedBox(
            height: 30,
          ),
          FractionallySizedBox(
            widthFactor: 0.93,
            child: Text(
              "Description",
              style: TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w500,
                  fontSize: 19),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FractionallySizedBox(
            widthFactor: 0.90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  padding: EdgeInsets.only(bottom: 30),
                  child: const ReadMoreText(
                    "All-Inclusive: Breakfast, Lunch, Dinner & Unlimited Local Drinks (within All-Inclusive menu card)\n\nAll-Inclusive starts at 15:00 on arrival date & ends at 12:00 on departure date\n\nTea time as from 15:30 to 17:30",
                    trimLines: 5,
                    style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show less',
                    moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 187, 137, 252),
                    ),
                    lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 187, 137, 252),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedOpacity(
        opacity: _show ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: FractionallySizedBox(
          widthFactor: 0.93,
          child: Container(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 187, 134, 252),
              ),
              child: Text(
                "Book now",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Quicksand", fontSize: 19),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                              hotelPrice: widget.hotelPrice,
                            )));
              },
            ),
          ),
        ),
      ),
    );
  }
}
