import 'package:flutter/material.dart';

class MyConstant {
  
  //General
  static String appName = 'ChampShop';

  //Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = 'buyerService';
  static String routeSalerService = 'salerService';

  //Image
  static String image1 = 'images/image1.png';

  //color
  static Color primary1 = Color.fromARGB(255, 116, 78, 148);
  static Color primary2 = Color.fromARGB(255, 146, 117, 189);
  static Color primary3 = Color.fromARGB(255, 192, 151, 225);
  static Color primary4 = Color.fromARGB(255, 215, 192, 239);

  //Style
  TextStyle headStyle() => TextStyle(
    fontSize:40,
    color: primary3,
    fontWeight: FontWeight.bold,
    
  );
  TextStyle h1Style() => TextStyle(
    fontSize: 24,
    color: primary1,
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




}