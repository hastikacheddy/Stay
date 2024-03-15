import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lotel/login/welcomepage2.dart';
import 'package:lotel/pay/calendar_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:counter_button/counter_button.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:lotel/pay/payment/pages/home_page.dart';
import 'package:lotel/pay/payment/pages/homepage.dart';
import 'package:lotel/profile/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51Kt957AT2QM0He2elrwgwFjonXONBgAcYkTpAbCgUoZrwx5klCInHC2gVwogUVHcLba477z2bZn9Ak22o3GgZtMB00JA7yORTd';

  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: WelcomePage2(),
          );
        },
      ),
    );
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}


