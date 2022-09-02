import 'package:champshop/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:champshop/states/authen.dart';
import 'package:champshop/states/buyer_service.dart';
import 'package:champshop/states/create_account.dart';
import 'package:champshop/states/saler_service.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/salerService': (BuildContext context) => SalerService(),
};

String? initlalRount;

void main() {
  initlalRount = MyConstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRount,
      theme: ThemeData(
        fontFamily: 'Prompt',
        scaffoldBackgroundColor:  Color.fromARGB(255, 247, 240, 225),
      ),
    );
  }
}
