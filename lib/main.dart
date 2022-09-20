import 'package:champshop/states/add_product.dart';
import 'package:champshop/states/edit_product.dart';
import 'package:champshop/states/edit_profile_saler.dart';
import 'package:champshop/states/show_cart.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:champshop/states/authen.dart';
import 'package:champshop/states/buyer_service.dart';
import 'package:champshop/states/create_account.dart';
import 'package:champshop/states/saler_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/salerService': (BuildContext context) => SalerService(),
  '/addProduct': (BuildContext context) => AddProduct(),
  '/editProfileSaler': (BuildContext context) => EditProfileSaler(),
  '/showCart': (BuildContext context) => ShowCart(),
};

String? initlalRount;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initlalRount = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'buyer':
        initlalRount = MyConstant.routeBuyerService;
        runApp(MyApp());
        break;
      case 'seller':
        initlalRount = MyConstant.routeSalerService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor =
        MaterialColor(0xff90B77D, MyConstant.mapMaterialColor);
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRount,
      theme: ThemeData(
        primarySwatch: materialColor,
        fontFamily: 'Prompt',
        scaffoldBackgroundColor: Color.fromARGB(255, 246, 241, 233),
      ),
    );
  }
}
