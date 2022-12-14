import 'dart:convert';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:champshop/models/user_model.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/utility/my_dialog.dart';
import 'package:champshop/widgets/show_image.dart';
import 'package:champshop/widgets/show_signout.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bodys/my_money_buyer.dart';
import '../bodys/my_order_buyer.dart';
import '../bodys/show_all_shop_buyer.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({Key? key}) : super(key: key);

  @override
  State<BuyerService> createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  List<Widget> widgets = [
    ShowAllShopBuyer(),
    MyMoneyBuyer(),
    MyOrderBuyer(),
  ];
  int indexWidget = 0;
  UserModel? userModel;


  @override
  void initState() {
    super.initState();
    findUserLogin();
  }

   Future<void> findUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idUserLogin = preferences.getString('id');

    var urlAPI =
        '${MyConstant.domain}/champshop/getUserWhereId.php?isAdd=true&id=$idUserLogin';
    await Dio().get(urlAPI).then((value) async {
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          print('#### id login ==> ${userModel!.id}');
        });
      }

      var path =
          '${MyConstant.domain}/champshop/getWalletWhereIdBuyer.php?isAdd=true&idBuyer=${userModel!.id}';
      await Dio().get(path).then((value) {
        print('#### value getWalletWhereId ==> $value');

        if (value.toString() == 'null') {
          print('#### action Alert add Wallet');
          MyDialog(
            funcAction: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, MyConstant.routeAddWallet);
            },
          ).actionDialog(context, 'No Wallet', 'Please Add Waller');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer'),
        actions: [
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, MyConstant.routeShowCart),
            icon: Icon(Icons.shopping_cart),
            color: Colors.white,
          )
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(),
                menuShowAllShop(),
                menuMyMoney(),
                menuMyOrder(),
              ],
            ),
            ShowSignOut(),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowAllShop() {
    return ListTile(
      leading: Icon(
        Icons.shopping_bag_outlined,
        size: 36,
        color: MyConstant.primary2,
      ),
      title: ShowTitle(
        title: '???????????????????????????????????????????????????',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyMoney() {
    return ListTile(
      leading: Icon(
        Icons.money,
        size: 36,
        color: MyConstant.primary2,
      ),
      title: ShowTitle(
        title: '????????????????????????????????????',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyOrder() {
    return ListTile(
      leading: Icon(
        Icons.list,
        size: 36,
        color: MyConstant.primary2,
      ),
      title: ShowTitle(
        title: '????????????????????????????????????????????????',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
    );
  }

 UserAccountsDrawerHeader buildHeader() => UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1,
          center: Alignment(-0.8, -0.2),
          colors: [Colors.white, MyConstant.primary3],
        ),
      ),
      currentAccountPicture: userModel == null
          ? ShowImage(path: MyConstant.image1)
          : userModel!.avatar.isEmpty
              ? ShowImage(path: MyConstant.image1)
              : CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      '${MyConstant.domain}${userModel!.avatar}'),
                ),
      accountName: ShowTitle(
        title: userModel == null ? '' : userModel!.name,
        textStyle: MyConstant().h2Style(),
      ),
      accountEmail: null);
}

