import 'dart:convert';

import 'dart:ui';

import 'package:alan_voice/alan_voice.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotel/login/create_login.dart';

import 'package:lotel/login/welcomepage2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:local_auth/local_auth.dart';

import 'package:lotel/mainApp/pages/navpages/home_page.dart';
import 'package:lotel/mainApp/pages/navpages/main_app_page.dart';

class FieldState {
  String? name;
  String? email;
  String? password;

  FieldState(this.name, this.email, this.password);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}

class SignIn extends StatefulWidget {
  final Function SignIntoSignUp;
  SignIn({required this.SignIntoSignUp});
  get password => null;
  get user => null;
  bool? get wantsTouchId => null;
  @override
  State<SignIn> createState() => _SignInState();
} //void here

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(r'^.{8,}$').hasMatch(this);
  }
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email, password;
  bool _useTouchId = false;
  bool saveAttempted = false;
  final formKey = GlobalKey<FormState>();
  bool userfound = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final currentState = FieldState("", "", "");
  final LocalAuthentication auth = LocalAuthentication();
  final storage = FlutterSecureStorage();

  final bool wantsTouchId = false;
  late bool userHasTouchId = false;
  late final authenticated;

  get user => FirebaseAuth.instance.currentUser;

  void setVisuals() {
    var visual = jsonEncode(currentState);
    AlanVoice.setVisualState(visual);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  logindetails() {

    setState(() {

      saveAttempted = true;
    });
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _signIn(em: email, pw: password);
    }

    ;

    setState(() {
      userfound = true;

    });
  }

  void _handleCommand(Map<String, dynamic> command) {
    switch (command["command"]) {
      case "savelogin":
        logindetails();
        break;

      case "getEmail":
        nameController.text = command["text"];
        currentState.email = nameController.text;
        setVisuals();
        break;

      case "getPassword":
        nameController.text = command["text"];
        currentState.password = nameController.text;
        setVisuals();
        break;

      case "gotosignuppage":
        widget.SignIntoSignUp();
        break;

      case "welcome":
        gocancel();
        break;
    }
  }

  void _signIn({required String em, required String pw}) {
    _auth
        .signInWithEmailAndPassword(email: em, password: pw)
        .then((authResult) {
      /* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return SignedInPage(
          user: user,
          password: password,
        );

      }));


      */

      setState(() {
        userfound = true;

      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainAppPage()),
        (Route<dynamic> route) => false,
      );

      //gotomainpage();
    }).catchError((err) {
      print(err.code);
      setState(() {
        userfound = false;

      });

      if (err.code == 'ERROR_WRONG_PASSWORD') {



        showCupertinoDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('the password was incorrect,please try again'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 39.0,
                    fontFamily: 'Ayita',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  child: TextFormField(
                    controller: emailController,
                    onChanged: (textValue) {
                      currentState.email = textValue;
                      setVisuals();
                      setState(() {
                        email = textValue;
                      });
                    },
                    validator: (emailValue) {
                      if (emailValue!.isEmpty) {
                        return 'this field is mandatory';
                      }

                      if (userfound == false) {
                        return 'user email not found';
                      }

                      String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                          "\\@" +
                          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                          "(" +
                          "\\." +
                          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                          ")+";
                      RegExp regExp = new RegExp(p);

                      if (regExp.hasMatch(emailValue)) {
                        // So, the email is valid
                        return null;
                      }
                      return 'This is not a valid email';
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.red,
                      ),


                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.red.withOpacity(0.8), width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Enter your email',
                      labelStyle:
                      TextStyle(color: Colors.white,fontFamily: 'QuickSand',),
                      focusColor: Colors.white,

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Color.fromARGB(255, 187, 137, 252),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: TextFormField(
                    controller: passwordController,
                    onChanged: (textValue) {
                      currentState.password = textValue;
                      setVisuals();
                      setState(() {
                        password = textValue;
                      });
                    },
                    validator: (pwValue) {
                      if (pwValue!.isEmpty) {
                        return 'this field is mandatory';
                      }

                      if (userfound == false) {
                        return "user password not valid";
                      }

                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.red,
                      ),
                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.red.withOpacity(0.8), width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Enter your password',
                      labelStyle:
                      TextStyle(color: Colors.white,fontFamily: 'QuickSand',),
                      focusColor: Color.fromARGB(255, 187, 137, 252),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Color.fromARGB(255, 187, 137, 252),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    logindetails();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomePage2()));
                          },
                          child: Container(
                            width: width * 0.3,
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 12.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                30.0,
                              ),
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 187, 137, 252)),
                            ),
                            child: Text(
                              'CANCEL',
                              style: TextStyle(fontFamily: 'QuickSand',
                                color: Colors.white.withOpacity(0.9),

                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.12,
                        ),
                        Container(
                          width: width * 0.3,
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 187, 137, 252),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            'LOG IN',
                            style: TextStyle(
                              fontFamily: 'QuickSand',
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Color.fromARGB(255, 187, 137, 252).withOpacity(0.8),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateLogin()));
              },
              child: Text(
                'Don\'t have an account ? SignUp',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void gocancel() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomePage2()));
    ;
  }

  /*void gotomainpage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => mainpage()));
    ;
  }*/

}
