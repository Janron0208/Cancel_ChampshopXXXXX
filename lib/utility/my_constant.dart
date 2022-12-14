import 'package:flutter/material.dart';

class MyConstant {
  //General
  static String appName = 'ChampShop';
  static String domain =
      'https://f6c2-2403-6200-88a0-d9a1-7404-8993-ae6f-f9e4.ap.ngrok.io';
  static String urlPrompay = 'https://promptpay.io/0972806742.png';
  static String publicKey = 'pkey_test_5t7lszdmwdl3ljpa0vh';
  static String secreKey = 'skey_test_5t7lszf95tqyh4yoy4z';

  //Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSalerService = '/salerService';
  static String routeAddProduct = '/addProduct';
  static String routeEditProfileSaler = '/editProfileSaler';
  static String routeShowCart = '/showCart';
  static String routeAddWallet = '/addWallet';
  static String routeConfrimAddWallet = '/conFirmAddWallet';

  //Image
  static String avatar = 'images/avatar.png';
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String image5 = 'images/image5.png';

  //color
  static Color primary1 = Color(0xff483838);
  static Color primary2 = Color(0xff42855B);
  static Color primary3 = Color(0xff90B77D);
  static Color primary4 = Color(0xffD2D79F);
  static Color primarybg = Color.fromARGB(255, 242, 255, 215);
  static Color error1 = Color.fromARGB(255, 255, 108, 108);
  static Color error2 = Color.fromARGB(255, 255, 143, 143);
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(255, 150, 234, 0.1),
    100: Color.fromRGBO(255, 150, 234, 0.2),
    200: Color.fromRGBO(255, 150, 234, 0.3),
    300: Color.fromRGBO(255, 150, 234, 0.4),
    400: Color.fromRGBO(255, 150, 234, 0.5),
    500: Color.fromRGBO(255, 150, 234, 0.6),
    600: Color.fromRGBO(255, 150, 234, 0.7),
    700: Color.fromRGBO(255, 150, 234, 0.8),
    800: Color.fromRGBO(255, 150, 234, 0.9),
    900: Color.fromRGBO(255, 150, 234, 1.0),
  };

  //Background
  BoxDecoration planBackground() => BoxDecoration(color: MyConstant.primarybg);

  BoxDecoration gradintLinearBackground() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ MyConstant.primary3, MyConstant.primary4],
        ),
      );

  BoxDecoration gradientRadioBackground() => BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.5),
          radius: 1.5,
          colors: [Colors.white, MyConstant.primary3],
        ),
      );

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
