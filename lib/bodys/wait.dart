import 'package:flutter/material.dart';
import 'package:champshop/models/wallet_model.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_list_wallet.dart';
import 'package:champshop/widgets/show_title.dart';

class Wait extends StatefulWidget {
  final List<WalletModel> walletModels;
  const Wait({Key? key, required this.walletModels}) : super(key: key);
  @override
  _WaitState createState() => _WaitState();
}

class _WaitState extends State<Wait> {
  List<WalletModel>? waitWalletModels;

  @override
  void initState() {
    super.initState();
    waitWalletModels = widget.walletModels;
    print('waitList ==> ${waitWalletModels!.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: waitWalletModels?.isEmpty ?? true
          ? Center(
              child: ShowTitle(
              title: 'No Wait Wallet',
              textStyle: MyConstant().h1Style(),
            ))
          : ShowListWallet(walletModels: waitWalletModels),
    );
  }
}