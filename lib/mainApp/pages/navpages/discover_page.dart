import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lotel/mainApp/hotelsList.dart';
import 'package:lotel/mainApp/pages/navpages/service_page.dart';

class DiscoverPage extends StatefulWidget {
  final hotelList = HotelList();
  var hotels;
  var savedHotels;

  DiscoverPage({Key? key}) : super(key: key) {
    hotels = hotelList.getHotelList();
    savedHotels = hotelList.getSavedHotels();
  }

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            iconTheme: IconThemeData(color:ThemeProvider.of(context).accentColor),
            backgroundColor: ThemeProvider.of(context).backgroundColor,
            floating: true,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor:Colors.transparent ),
            title: Text("Discover", style: TextStyle(color: ThemeProvider.of(context).accentColor, )),
            centerTitle: true,
          )
        ],
        body: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            FractionallySizedBox(
              widthFactor: 0.93,
              child: Row(
                children: [
                  RaisedButton(
                    onPressed: () {},
                    color: ThemeProvider.of(context).focusColor,
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    child: const Text(
                      "Hotel",
                      style: TextStyle(fontFamily: 'Quicksand',color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: ThemeProvider.of(context).backgroundColor,
                    textColor: ThemeProvider.of(context).accentColor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      "Restaurant",
                      style: TextStyle(fontFamily: 'Quicksand',color: ThemeProvider.of(context).accentColor,),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: widget.hotels.length,
                itemBuilder: (BuildContext context, int index) {
                  var key = widget.hotels.keys.elementAt(index);
                  var alreadySaved = false;
                  if (widget.savedHotels.contains(key)) {
                    alreadySaved = true;
                  } else {
                    alreadySaved = false;
                  }
                  var hotelMap = widget.hotels[key];
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
                                          hotelId: (index + 1).toString(),
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
                                    child: Hero(
                                      tag: 'dash',
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(7),
                                                topRight: Radius.circular(7)),
                                            image: DecorationImage(
                                                image: AssetImage(picture),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.savedHotels.add(key);
                                          print(widget.savedHotels);
                                        });
                                      },
                                      icon: Icon(
                                        alreadySaved
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: alreadySaved ? Colors.red : null,
                                      ))
                                ],
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.93,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 1),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color:
                                                      ThemeProvider.of(context)
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
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    "img/locsvg.svg",
                                                    width: 13,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 2),
                                                    child: Text(
                                                      location,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Quicksand',
                                                          color: Color.fromARGB(
                                                              255,
                                                              160,
                                                              160,
                                                              160),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: SvgPicture.asset(
                                                      "img/starsvg.svg",
                                                      width: 10,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
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
                                                  fontWeight: FontWeight.bold,
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
