import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_signout.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:flutter/material.dart';

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
        title: 'แสดงสินค้าทั้งหมด',
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
        title: 'กระเป๋าตังค์',
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
        title: 'ตระกร้าสินค้า',
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

  UserAccountsDrawerHeader buildHeader() =>
      UserAccountsDrawerHeader(accountName: null, accountEmail: null);
}
