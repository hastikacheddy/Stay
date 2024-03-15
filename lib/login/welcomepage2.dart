import 'dart:ui';

import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotel/login/create_login.dart';

import 'package:lotel/login/terms_conditions.dart';

import 'package:lotel/mainApp/pages/navpages/home_page.dart';
import 'package:lotel/mainApp/pages/navpages/main_app_page.dart';

import 'menu_frame.dart';

class WelcomePage2 extends StatefulWidget {
  const WelcomePage2({Key? key}) : super(key: key);

  @override
  State<WelcomePage2> createState() => _WelcomePage2State();
}

class _WelcomePage2State extends State<WelcomePage2> {
  @override
  bool _greetingIsPlayed = false;

  _WelcomePage2State() {
    /// Init Alan Button with project key from Alan Studio
    //AlanVoice.addButton("44c3c94ca046ade6f501091bbeb49f0d2e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
    AlanVoice.onButtonState.add((state) {
      if (state.name == "ONLINE" && !_greetingIsPlayed) {
        _greetingIsPlayed = true;
        AlanVoice.activate();
        AlanVoice.playText(
            "Welcome, your can use your voice to navigate our app");
      }
    });
  }

  void _handleCommand(Map<String, dynamic> command) {
    switch (command["command"]) {
      case "gotosignuppage":
        gotosignup();
        break;

      case "gotologin":
        gotologin();
        break;

      case "termsandconditions":
        break;
    }
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[
        // MenuVideoWidget(),



        Container(

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/ven2.png"),
              fit: BoxFit.fill,
            ),
          ),



          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        'stay',
                        style: TextStyle(
                          fontFamily: 'Ayita',
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 58,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            child: Text('Enjoy Life',
                                style: TextStyle(
                                  wordSpacing: 2.5,
                                  fontFamily: 'Ayita',
                                  color: Colors.white
                                      .withOpacity(0.5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.383,
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Container(
                          width: width * 0.8,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 187, 137, 252),
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.android,
                                  color: Colors.white, size: 30.0),
                              Text(
                                '  CONTINUE AS GUEST',
                                style: TextStyle(fontFamily: 'QuickSand',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MainAppPage())

                            ///main page
                            );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 187, 137, 252),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 10.0,
                          ),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'SIGN UP WITH EMAIL',
                                  style: TextStyle(fontFamily: 'QuickSand',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateLogin()));
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    /*

                            InkWell(onTap:(){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => TermsCondition())
                              ) ;
                            },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40,right: 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    border: Border.all(width:3,color: Colors.white.withOpacity(0)),
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 10.0,
                                  ),

                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        ImageIcon(
                                          AssetImage("assets/images/festival.png"),
                                          color: Colors.red,
                                          size: 34,
                                        ),
                                       Text('    TAKE PART ',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              foreground: Paint()..shader = LinearGradient(
                                                colors: <Color>[
                                                  Colors.red,
                                                  Colors.pink,
                                                  Colors.purple,
                                                  Colors.deepPurple,
                                                  Colors.deepPurple,
                                                  Colors.indigo,
                                                  Colors.blue,
                                                  Colors.lightBlue,
                                                  Colors.cyan,
                                                  Colors.teal,
                                                  Colors.green,
                                                  Colors.lightGreen,
                                                  Colors.lime,
                                                  Colors.yellow,
                                                  Colors.amber,
                                                  Colors.orange,
                                                  Colors.deepOrange,
                                                  //add more color here.
                                                ],
                                              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))
                                          )),
                                      ],),
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => TakePart())
                                      ) ;
                                    },
                                  ),
                                ),
                              ),
                            ),


                            */
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.login,
                                color: Colors.white,
                                size: 30.0),
                            InkWell(
                              child: Text(
                                '  LOGIN',
                                style: TextStyle(fontFamily: 'QuickSand',
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MenuFrame()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'By signin up you agree to our ',
                              style: TextStyle(fontFamily: 'QuickSand',
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 0,
                            ),
                            InkWell(
                              /*onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TermsCondition()))
                              },*/
                              child: Text(
                                'terms and conditions',
                                style: TextStyle(fontFamily: 'QuickSand',
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    )));
  }

  void gotosignup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateLogin()));
  }

  void gotologin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MenuFrame()));
  }
}
