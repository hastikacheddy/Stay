import 'package:alan_voice/alan_voice.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class ServicePage extends StatefulWidget {
  final String hotelName;
  final String hotelPrice;
  final String hotelPicture;

  const ServicePage(
      {Key? key,
      required this.hotelName,
      required this.hotelPrice,
      required this.hotelPicture})
      : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  _ServicePageState() {
    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      _handleCommand(command.data);
    });
  }

  Future<void> _handleCommand(Map<String, dynamic> command) async {
    switch (command["command"]) {
      case "nextPhoto":
        _controller.nextPage(
            duration: const Duration(seconds: 1), curve: Curves.ease);
    }
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                items: [
                  widget.hotelPicture,
                  widget.hotelPicture,
                  widget.hotelPicture
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(i), fit: BoxFit.cover)));
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
                                        : Colors.white)
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
            widthFactor: 0.90,
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
                              color: Colors.black,
                            )),
                        const Text(
                          "Port Louis",
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
                  children: const [
                    AutoSizeText(
                      "Rs 1300",
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
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
            widthFactor: 0.9,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 244, 244, 244),
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
                              fontSize: 16,color: ThemeProvider.of(context).accentColor),
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
                                color: Color.fromARGB(255, 250, 255, 0),
                                width: 10,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 3),
                              child: const Text(
                                "4.7",
                                style: TextStyle(fontFamily: 'Quicksand'),
                              ),
                            ),
                            Container(
                              child: Text(
                                " | 132 reviews",
                                style: TextStyle(fontFamily: 'Quicksand',color: ThemeProvider.of(context).accentColor),
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
                                backgroundImage: AssetImage("img/stockface.jpg"),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 40,
                            child: Container(
                              child: CircleAvatar(
                                backgroundImage: AssetImage("img/stockface2.jpg"),
                                minRadius: 25,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: InkWell(
                              onTap: () {},
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
          FractionallySizedBox(
            widthFactor: 0.90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 500,
                  child: Text(
                    "All-Inclusive: Breakfast, Lunch, Dinner & Unlimited Local Drinks (within All-Inclusive menu card) \n\nAll-Inclusive starts at 15:00 on arrival date & ends at 12:00 on departure date",
                    style: TextStyle(fontFamily: "Quicksand"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
