import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lotel/profile/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lotel/profile/widgets/profile_list_item.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:lotel/profile/Profile.dart';
import 'package:lotel/profile/service.dart';
import 'package:lotel/profile/FAQ.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class scanner extends StatefulWidget {
  @override
  State<scanner> createState() => _scannersState();
}

class _scannersState extends State<scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(' ${result!.code}', style: TextStyle(fontSize: 25))
                  : Text('Scan hotel code', style: TextStyle(fontSize: 25)),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result!.code == "Jalsa beach hotel") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServicePage(
                        hotelName: "Jalsa Hotel",
                        hotelPrice: "1500",
                        hotelPicture: "img/hot2.jpg",
                      )));
        } else if (result!.code == "Riu hotel Mauritius") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServicePage(
                        hotelName: "Riu Hotel",
                        hotelPrice: "1500",
                        hotelPicture: "img/hot3.jpg",
                      )));
        } else if (result!.code == "Lux hotel Mauritius") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServicePage(
                        hotelName: "Lux Hotel",
                        hotelPrice: "1500",
                        hotelPicture: "img/hot1.jpg",
                      )));
        }
        reassemble();
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
