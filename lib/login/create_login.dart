import 'dart:convert';

import 'package:alan_voice/alan_voice.dart';

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotel/login/menu_frame.dart';
import 'package:lotel/login/terms_conditions.dart';
import 'package:lotel/login/welcomepage2.dart';

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

class CreateLogin extends StatefulWidget {
  @override
  _CreateLoginState createState() => _CreateLoginState();
}

class _CreateLoginState extends State<CreateLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email, passwordConfirm;
  String password = "";
  bool saveAttempted = false;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final currentState = FieldState("", "", "");

  void setVisuals() {
    var visual = jsonEncode(currentState);
    AlanVoice.setVisualState(visual);
  }

  void savedetails() {
    setState(() {
      saveAttempted = true;
    });
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _createUser(email: email, pw: password);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _greetingIsPlayed = false;

  _CreateLoginState() {
    /// Init Alan Button with project key from Alan Studio
    //AlanVoice.addButton("44c3c94ca046ade6f501091bbeb49f0d2e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
    AlanVoice.onButtonState.add((state) {
      if (state.name == "ONLINE" && !_greetingIsPlayed) {
        _greetingIsPlayed = true;
        AlanVoice.activate();
        AlanVoice.playText(
            "To Register, please enter a valid email and password. Thank you");
      }
    });
  }

  void _handleCommand(Map<String, dynamic> command) {
    switch (command["command"]) {
      case "getName":
        nameController.text = command["text"];
        currentState.name = nameController.text;
        setVisuals();
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

      case "welcome":
        gotowelcomepage();
        break;

      case "savesignup":
        savedetails();
        break;
    }
  }

  void _createUser({required String email, required String pw}) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pw)
        .then((authResult) {
      /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(38.0),
            child: Text('Welcome ${authResult.user!.email}',style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.w300,decoration: TextDecoration.none,color: Colors.black
            ),),
          ),
        );
      }));*/

      gotowelcomepage();
      //gotomainpage();
    }).catchError((err) {
      print(err.code);
      if (err.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                    'This email already has an account associated with it'),
                actions: <Widget>[
                  CupertinoDialogAction(
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
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/ven2.png"),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 39.0,
                  fontFamily: 'Ayita',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  labelText: 'Enter your Email',
                  labelStyle:
                      TextStyle(color: Colors.white, fontFamily: 'QuickSand',),
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
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    if (pwValue.length < 8) {
                      return 'Password must be at least 8 characters';
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
                    labelText: 'Enter your Password',
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
              TextFormField(
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (textValue) {
                  currentState.name = textValue;
                  setVisuals();
                  setState(() {
                    passwordConfirm = textValue;
                  });
                },
                validator: (pwConfValue) {
                  if (pwConfValue!.isEmpty) {
                    return 'this field is mandatory';
                  }
                  if (password.isEmpty) {
                    if (pwConfValue != password) {
                      return 'Type in password first';
                    }
                  } else if (pwConfValue != password) {
                    return 'password should match';
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
                  labelText: 'Re-enter your password',
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
              SizedBox(
                height: 40.0,
              ),
              Row(
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
                            width: 2,
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
                    width: 38.0,
                  ),
                  InkWell(
                    onTap: () {
                      savedetails();
                    },
                    child: Container(
                      width: width * 0.3,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 187, 137, 252),
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                      ),
                      child: Text(
                        'SAVE',
                        style: TextStyle(fontFamily: 'QuickSand',
                          color: Colors.white,
                          fontSize: 20.0,

                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.0,
              ),

              /*  GestureDetector(
                child: Text("Agreed to terms and conditions",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,
                    decoration:TextDecoration.underline
                ),),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TermsCondition())
                  ) ;
                },
              )

             */
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MenuFrame()))
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.login,
                            color: Colors.white,
                            size: 24.0),
                        Text(
                          ' LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void gotowelcomepage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomePage2()));
    ;
  }
}
/*
void gotomainpage() {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => mainPage()));
  ;
}
}*/
