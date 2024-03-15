import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lotel/mainApp/pages/navpages/service_page.dart';

import '../hotelsList.dart';


class Search extends StatelessWidget {
  final String searchKey;
  final hotelList = HotelList();
  var results;

  Search({
    Key? key,
    required this.searchKey,
  }) : super(key: key) {
    results = hotelList.searchHotels(searchKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: ThemeProvider.of(context).focusColor,
            floating: true,
            title: Text("Search Results"),
            centerTitle: true,
          )
        ],
        body: results.length == 0
            ? Center(
                child: Text(
                "No results :(",
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ))
            : ListView(
                padding: EdgeInsets.only(top: 10),
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      itemCount: results.length,
                      itemBuilder: (BuildContext context, int index) {
                        var key = results.keys.elementAt(index);
                        var hotelMap = results[key];
                        var name = hotelMap!["name"].toString();
                        var price = hotelMap["price"].toString();
                        var picture = hotelMap["picture"].toString();
                        var location = hotelMap["location"].toString();
                        var ratings = hotelMap["rating"].toString();
                        return Center(
                          child: FractionallySizedBox(
                            child: Container(
                              margin: index == 0
                                  ? EdgeInsets.only(top: 10)
                                  : EdgeInsets.only(top: 35),
                              child: InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ServicePage(
                                                hotelName: name,
                                                hotelPicture: picture,
                                                hotelPrice: price,
                                                hotelLocation: location,
                                                hotelId: "1",
                                                rating: ratings,
                                              )));
                                }),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        FractionallySizedBox(
                                          widthFactor: .93,
                                          child: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(7),
                                                    topRight:
                                                        Radius.circular(7)),
                                                image: DecorationImage(
                                                    image: AssetImage(picture),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.favorite_border))
                                      ],
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 0.93,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(7),
                                              bottomRight: Radius.circular(7)),
                                          color: ThemeProvider.of(context)
                                              .backgroundColor,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 50,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    name,
                                                    style: TextStyle(
                                                        fontFamily: 'Quicksand',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: ThemeProvider.of(
                                                                context)
                                                            .accentColor),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    height: 20,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "img/locsvg.svg",
                                                          width: 13,
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2),
                                                          child: Text(
                                                            location,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Quicksand',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        160,
                                                                        160,
                                                                        160),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8),
                                                          child:
                                                              SvgPicture.asset(
                                                            "img/starsvg.svg",
                                                            width: 10,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 3),
                                                          child: Text(
                                                            ratings,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Quicksand'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Rs " + price,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 187, 134, 252),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  Text(
                                                    "per night",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 130, 125, 125),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
