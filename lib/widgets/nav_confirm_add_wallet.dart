import 'package:champshop/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_title.dart';

import '../utility/my_constant.dart';

class NavConfirmAddWallet extends StatelessWidget {
  const NavConfirmAddWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: InkWell(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
            context, MyConstant.routeConfrimAddWallet, (route) => false),
        child: Card(
          color: MyConstant.primary3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/bill.png',
                  width: 50,
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text('แจ้งชำระเงิน'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
