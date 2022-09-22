// import 'package:champshop/widgets/show_title.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class Wallet extends StatefulWidget {
//   const Wallet({Key? key}) : super(key: key);

//   @override
//   State<Wallet> createState() => _WalletState();
// }

// class _WalletState extends State<Wallet> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ShowTitle(title: 'Wallet'),
//     );
//   }
// }

import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_title.dart';

class Wallet extends StatefulWidget {
  final int approveWallet, waitApproveWallet;

  const Wallet(
      {Key? key, required this.approveWallet, required this.waitApproveWallet})
      : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int? approveWallet, waitApproveWallet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.approveWallet = widget.approveWallet;
    this.waitApproveWallet = widget.waitApproveWallet;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: MyConstant().planBackground(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              newListTile(Icons.wallet_giftcard, 'จำนวนเงินที่ใช้ได้',
                  '$approveWallet thb'),
              newListTile(Icons.wallet_membership, 'จำนวนเงินที่รอตรวจสอบ',
                  '$waitApproveWallet thb'),
              newListTile(Icons.grading_sharp, 'จำนวนเงินทั้งหมด',
                  '${approveWallet! + waitApproveWallet!} thb'),
            ],
          ),
        ),
      ),
    );
  }

  Widget newListTile(IconData iconData, String title, String subTitle) {
    return Container(
      width: 300,
      child: Card(
        color: MyConstant.primary2.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ListTile(
            leading: Icon(
              iconData,
              color: Colors.white,
              size: 48,
            ),
            title: ShowTitle(
              title: title,
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: subTitle,
              textStyle: MyConstant().h1Style(),
            ),
          ),
        ),
      ),
    );
  }
}