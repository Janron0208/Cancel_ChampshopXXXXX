import 'package:champshop/widgets/nav_confirm_add_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:champshop/utility/my_constant.dart';
// import 'package:champshop/widgets/nav_confirm_add_wallet.dart';
import 'package:champshop/widgets/show_title.dart';

class Bank extends StatefulWidget {
  const Bank({Key? key}) : super(key: key);

  @override
  _BankState createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTitle(),
          buildKTBbank(),
          buildKbank(),
        ],
      ),
      floatingActionButton: NavConfirmAddWallet() ,
      
    );
  }

  Widget buildKTBbank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      height: 150,
      child: Center(
        child: Card(
          color: Color.fromARGB(255, 174, 229, 243),
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 163, 255),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('images/ktb.svg'),
              ),
            ),
            title: ShowTitle(
              title: 'ธนาคารกรุงไทย สาขาบิ๊กซีกัลปพฤกษ์',
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: 'ชื่อบัญชี นายณัฐพล จันทร์รอน เลขบัญชี  913-0-04149-5',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ),
    );
  }

  Container buildKbank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      height: 150,
      child: Center(
        child: Card(
          color: Colors.green[100],
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('images/kbank.svg'),
              ),
            ),
            title: ShowTitle(
              title: 'ธนาคารกสิกรไทย สาขาบิ๊กซีบางบอน',
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: 'ชื่อบัญชี นายณัฐพล จันทร์รอน เลขบัญชี  056-2-32767-5',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
          title: 'การโอนเงินเข้า บัญชีธนาคาร',
          textStyle: MyConstant().h1Style()),
    );
  }
}
