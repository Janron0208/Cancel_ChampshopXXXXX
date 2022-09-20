import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/utility/my_dialog.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Prompay extends StatefulWidget {
  const Prompay({Key? key}) : super(key: key);

  @override
  State<Prompay> createState() => _PrompayState();
}

class _PrompayState extends State<Prompay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTitle(),
            buildCopyPrompay(),
          ],
        ),
      ),
    );
  }

  Widget buildCopyPrompay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          title: ShowTitle(
            title: '0972806742',
            textStyle: MyConstant().h1Style(),
          ),
          subtitle: ShowTitle(
              title: 'บัญชีพร้อมเพย์', textStyle: MyConstant().h2Style()),
          trailing: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: '0972806742'));
              MyDialog().normalDialog(context, 'คัดลอกเรียบร้อยร้อย', 'กรุณาไปยังแอพธนาคารของท่าน');
            },
            icon: Icon(Icons.copy),
          ),
        ),
      ),
    );
  }

  ShowTitle buildTitle() {
    return ShowTitle(
      title: 'การโอนเงินโดยใช้พร้อมเพย์',
      textStyle: MyConstant().h1Style(),
    );
  }
}
