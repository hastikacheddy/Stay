import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotel/login/create_login.dart';
import 'package:lotel/login/home_signin_widget.dart';
import 'package:lotel/login/sign_in.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuFrame extends StatelessWidget {
  PageController pageController = PageController();

  MenuFrame() {
    /// Init Alan Button with project key from Alan Studio
    //AlanVoice.addButton("44c3c94ca046ade6f501091bbeb49f0d2e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          image: DecorationImage(
            image: AssetImage("assets/images/ven2.png"),
            fit: BoxFit.cover,
          ),

        ),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    /* Material(
                      child: Container(

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text('STAY',
                              style: TextStyle(fontSize: 44,
                                  fontWeight: FontWeight.bold,color: Colors.white,
                                  ),),
                          ],
                        ),
                      ),
                    ),


                    Text('Best App for your stay',
                      style: TextStyle(color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
        */
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: <Widget>[
                    /*  HomeSignInWidget(goToSignIn: (){
                      pageController.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);

                    },goToSignUp: (){
                      pageController.animateToPage(2, duration: Duration(milliseconds: 600), curve: Curves.easeInOut);
                    },),
                  */
                    SignIn(
                      SignIntoSignUp: () {
                        pageController.animateToPage(2,
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeInOut);
                      },
                    ),
                    /*CreateLogin(cancelBackToHome: (){
                    pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
                  },),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
