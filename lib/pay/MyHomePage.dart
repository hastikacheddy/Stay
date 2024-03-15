import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lotel/pay/calendar_popup_view.dart';
import 'package:lotel/pay/payment/pages/homepage.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lotel/pay/calendar_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:counter_button/counter_button.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:lotel/pay/payment/pages/home_page.dart';
import 'package:lotel/pay/payment/pages/homepage.dart';

class MyHomePage extends StatefulWidget {
  final String hotelPrice;
  const MyHomePage({Key? key, required this.hotelPrice}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  int _counterValue = 0;
  int _counterValue1 = 0;
  int _counterValue2 = 0;
  int _counterValue3 = 0;
  int total = 0;
  double fee = 0.0;

  @override
  Widget build(BuildContext context) {
    int duration = endDate.day - (startDate.day);
    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeProvider.of(context).focusColor,
        title:  Text(
          "Plan",
          style: TextStyle(color: ThemeProvider.of(context).backgroundColor,fontFamily: 'QuickSand',),
        ),
      ),
      body: Container(
        child: Material(
          color: Colors.transparent,
          child: Container(
            child: Align(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 25, height: 105),
                      Text(
                        'Choose date : ',
                        style: TextStyle(fontFamily: 'QuickSand',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: ThemeProvider.of(context).accentColor),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                        style:  TextStyle(fontFamily: 'QuickSand',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ThemeProvider.of(context).accentColor,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Padding(
                        padding: const EdgeInsets.only(right: 0, bottom: 0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFFB388EB),
                          child: IconButton(
                            icon: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showDemoDialog(context: context);
                              // Respond to button press
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 2,color:ThemeProvider.of(context).focusColor.withOpacity(0.1),),
                  SizedBox(height: 20 ,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Adults",
                              style: TextStyle(fontFamily: 'QuickSand',
                                fontSize: 18,
                                color: Colors.purple,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("Ages 13 or above"),
                          Container(margin: EdgeInsets.all(15.0)),
                          Text("Children",
                              style: TextStyle(fontFamily: 'QuickSand',
                                fontSize: 18,
                                color: Colors.purple,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("Ages 2-12"),
                          Container(margin: EdgeInsets.all(15.0)),
                          Text("Infants",
                              style: TextStyle(fontFamily: 'QuickSand',
                                fontSize: 18,
                                color: Colors.purple,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("Under 2"),
                          Container(margin: EdgeInsets.all(15.0)),
                          Text("Pets",
                              style: TextStyle(fontFamily: 'QuickSand',
                                fontSize: 18,
                                color: Colors.purple,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("Bringing a pet service? "),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CounterButton(
                            loading: false,
                            onChange: (int val) {
                              setState(() {
                                _counterValue = val;
                              });
                            },
                            count: _counterValue,
                            countColor: Colors.purple,
                            buttonColor: Colors.purpleAccent,
                            progressColor: Colors.purpleAccent,
                          ),
                          Container(margin: EdgeInsets.all(10.0)),
                          CounterButton(
                            loading: false,
                            onChange: (int val) {
                              setState(() {
                                _counterValue1 = val;
                              });
                            },
                            count: _counterValue1,
                            countColor: Colors.purple,
                            buttonColor: Colors.purpleAccent,
                            progressColor: Colors.purpleAccent,
                          ),
                          Container(margin: EdgeInsets.all(10.0)),
                          CounterButton(
                            loading: false,
                            onChange: (int val) {
                              setState(() {
                                _counterValue3 = val;
                              });
                            },
                            count: _counterValue3,
                            countColor: Colors.purple,
                            buttonColor: Colors.purpleAccent,
                            progressColor: Colors.purpleAccent,
                          ),
                          Container(margin: EdgeInsets.all(10.0)),
                          CounterButton(
                            loading: false,
                            onChange: (int val) {
                              setState(() {
                                _counterValue2 = val;
                              });
                            },
                            count: _counterValue2,
                            countColor: Colors.purple,
                            buttonColor: Colors.purpleAccent,
                            progressColor: Colors.purpleAccent,
                          )
                        ],
                      ),
                    ],
                  ),
              SizedBox(height: 20 ,),
                  Divider(thickness: 2,color:ThemeProvider.of(context).focusColor.withOpacity(0.1),),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(margin: EdgeInsets.all(5.0)),
                            Text(
                                "Rs ${widget.hotelPrice} x ${_counterValue + _counterValue1} guests x $duration nights",
                                style: TextStyle(fontFamily: 'QuickSand',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                )),
                            Container(margin: EdgeInsets.all(10.0)),
                            Text("Service fee  ",
                                style: TextStyle(fontFamily: 'QuickSand',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                )),
                          ]),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(margin: EdgeInsets.all(5.0)),
                          Text(
                              "Rs ${total = (_counterValue * 4000 + (_counterValue1 * 2000)) * duration} ",
                              style: TextStyle(fontFamily: 'QuickSand',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              )),
                          Container(margin: EdgeInsets.all(10.0)),
                          Text(
                              "Rs ${fee = ((_counterValue * 4500 * 0.25) + (_counterValue1 * 4500 * 0.125)) * duration} ",
                              style: TextStyle(fontFamily: 'QuickSand',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ],
                  ),SizedBox(height: 15 ,),
                  Divider(thickness: 2,color:ThemeProvider.of(context).focusColor.withOpacity(0.1),),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(margin: EdgeInsets.all(10.0)),
                              Text("Total before taxes  ",
                                  style: TextStyle(fontFamily: 'QuickSand',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(margin: EdgeInsets.all(10.0)),
                              Text("RS ${total + fee}",
                                  style: TextStyle(fontFamily: 'QuickSand',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ]),
                      ]),
                  Container(margin: EdgeInsets.all(50.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                       primary: ThemeProvider.of(context).focusColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      'Reserve',
                      style: TextStyle(fontFamily: 'QuickSand',fontSize: 24),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homepage()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
      ),
    );
  }
}