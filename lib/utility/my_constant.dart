import 'package:flutter/material.dart';

class MyConstant {
  //General
  static String appName = 'ChampShop';
  static String domain =
      'https://a84c-2403-6200-88a0-7110-ccd0-287d-ccb7-6455.ap.ngrok.io';

  //Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSalerService = '/salerService';

  //Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String avatar = 'images/avatar.png';

  //color
  static Color primary1 = Color(0xff483838);
  static Color primary2 = Color(0xff42855B);
  static Color primary3 = Color(0xff90B77D);
  static Color primary4 = Color(0xffD2D79F);
  static Color error1 = Color.fromARGB(255, 255, 108, 108);
  static Color error2 = Color.fromARGB(255, 255, 143, 143);

  //Style
  TextStyle headStyle() => TextStyle(
        fontSize: 40,
        color: primary2,
        fontWeight: FontWeight.bold,
      );
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: primary2,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: primary2,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: primary3,
        fontWeight: FontWeight.normal,
      );
  TextStyle error1Style() => TextStyle(
        fontSize: 18,
        color: error1,
        fontWeight: FontWeight.normal,
      );
      TextStyle error2Style() => TextStyle(
        fontSize: 14,
        color: error2,
        fontWeight: FontWeight.normal,
      );

  //Buttons
  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
