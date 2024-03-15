import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            title: Text("Reviews"),
            centerTitle: true,
          )
        ],
        body: ListView(
          padding: EdgeInsets.all(0),
          controller: _scrollController,
          children: [
            Container(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "4.0",
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "img/starsvg.svg",
                        width: 20,
                        height: 20,
                      ),
                      SvgPicture.asset(
                        "img/starsvg.svg",
                        width: 20,
                        height: 20,
                      ),
                      SvgPicture.asset(
                        "img/starsvg.svg",
                        width: 20,
                        height: 20,
                      ),
                      SvgPicture.asset(
                        "img/starsvg.svg",
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Based on 123 reviews",
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 13,
                      color: Colors.grey),
                )
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  //padding: EdgeInsets.symmetric(vertical: 20),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 30, 30, 30),
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage("img/figir.jpg"),
                              radius: 30,
                            ),
                            Container(
                              width: 285,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 350,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "LepepPaBon2",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 187, 137, 252),
                                            ),
                                          ),
                                          Text(
                                            "2 days ago",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "img/starsvg.svg",
                                            width: 10,
                                            height: 10,
                                          ),
                                          SvgPicture.asset(
                                            "img/starsvg.svg",
                                            width: 10,
                                            height: 10,
                                          ),
                                          SvgPicture.asset(
                                            "img/starsvg.svg",
                                            width: 10,
                                            height: 10,
                                          ),
                                          SvgPicture.asset(
                                            "img/starsvg.svg",
                                            width: 10,
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 300,
                                      child: const ReadMoreText(
                                        "All-Inclusive: Breakfast, Lunch, Dinner & Unlimited Local Drinks (within All-Inclusive menu card)\n\nAll-Inclusive starts at 15:00 on arrival date & ends at 12:00 on departure date\n\nTea time as from 15:30 to 17:30",
                                        trimLines: 5,
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontSize: 15),
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: ' Show more',
                                        trimExpandedText: ' Show less',
                                        moreStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 187, 137, 252),
                                        ),
                                        lessStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 187, 137, 252),
                                        ),
                                      ),
                                    )
                                  ]),
                            )
                          ]),
                    );
                  }),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedOpacity(
        opacity: _show ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: FractionallySizedBox(
          widthFactor: 0.93,
          child: Container(
            height: 50,
            child: ElevatedButton(
              child: Text(
                "Write review",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Quicksand", fontSize: 19),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),*/
    );
  }
}
