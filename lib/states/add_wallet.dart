import 'package:champshop/bodys/bank.dart';
import 'package:champshop/bodys/cradic.dart';
import 'package:champshop/bodys/prompay.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:flutter/material.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  List<Widget> widgets = [
    Bank(),
    Prompay(),
    Credic(),
  ];
  List<IconData> icons = [
    Icons.attach_money,
    Icons.book,
    Icons.credit_card,
  ];
  List<String> titles = ['Bank', 'Promptpay', 'Credit'];

  int indexPosition = 0;

  List<BottomNavigationBarItem> BottomNavigationBarItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int i = 0;
    for (var item in titles) {
      BottomNavigationBarItems.add(
        createBottomNavigationBarItem(icons[i], item),
      );
      i++;
    }
  }

  BottomNavigationBarItem createBottomNavigationBarItem(
          IconData iconData, String string) =>
      BottomNavigationBarItem(
        icon: Icon(iconData),
        label: string,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เติมเงินผ่าน ${titles[indexPosition]}'),
      ),
      body: widgets[indexPosition],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: MyConstant.primary3),
        items: BottomNavigationBarItems,
        currentIndex: indexPosition,
        onTap: (value) {
          setState(() {
            indexPosition = value;
          });
        },
      ),
    );
  }
}
