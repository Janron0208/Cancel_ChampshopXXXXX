import 'dart:convert';

import 'package:champshop/bodys/shop_manage_seller.dart';
import 'package:champshop/bodys/show_order_seller.dart';
import 'package:champshop/bodys/show_product_seller.dart';
import 'package:champshop/models/user_model.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_signout.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalerService extends StatefulWidget {
  const SalerService({Key? key}) : super(key: key);

  @override
  State<SalerService> createState() => _SalerServiceState();
}

class _SalerServiceState extends State<SalerService> {
  List<Widget> widgets = [
    ShowOrderSeller(),
    ShopManageSeller(),
    ShowProductSeller()
  ];
  int indexWidget = 0;
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    print('## id Logined ==> $id ');
    String apiGetUserWhereId =
        '${MyConstant.domain}/champshop/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiGetUserWhereId).then((value) {
      print('## value ==> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          print('### name logined = ${userModel!.name}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เจ้าของร้าน'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                buildHead(),
                menuShowOrder(),
                menuShowManage(),
                menuShowProduct(),
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  UserAccountsDrawerHeader buildHead() {
    return UserAccountsDrawerHeader(
        otherAccountsPictures: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.face),
            iconSize: 36,
            color: Colors.white, tooltip: 'แก้ไขข้อมูล',
          ),
        ],
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [MyConstant.primary2, MyConstant.primary3],
            center: Alignment(-0.8, -0.2),
            radius: 1,
          ),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundImage:
              NetworkImage('${MyConstant.domain}${userModel!.avatar}'),
        ),
        accountName: Text(userModel == null ? 'Name ?' : userModel!.name),
        accountEmail: Text(userModel == null ? 'Type ?' : userModel!.type));
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1_outlined),
      title: ShowTitle(
        title: 'รายการสั่งซื้อ',
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  ListTile menuShowManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_2_outlined),
      title: ShowTitle(
        title: 'รายละเอียดร้านค้า',
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_3_outlined),
      title: ShowTitle(
        title: 'รายการสินค้า',
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}
