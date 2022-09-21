import 'package:cached_network_image/cached_network_image.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/utility/my_dialog.dart';
import 'package:champshop/widgets/nav_confirm_add_wallet.dart';
import 'package:champshop/widgets/show_progress.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
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
            buildQRcodePrompay(),
            buildDownload(),
          ],
        ),
        
      ),floatingActionButton: NavConfirmAddWallet() ,
    );
  }

  ElevatedButton buildDownload() => ElevatedButton(
        onPressed: () async {
          String path = '/storage/emulated/0/Download';
          try {
            await FileUtils.mkdir([path]);
            await Dio()
                .download(MyConstant.urlPrompay, '$path/prompay.png')
                .then((value) => MyDialog().normalDialog(
                    context,
                    ' ดาวน์โหลดสำเร็จ',
                    'กรุณาไปที่แอพธนาคาร เพื่ออ่าน QR code ที่โหลดมา'));
          } catch (e) {
            print('## error ==>> ${e.toString()}');
            MyDialog().normalDialog(context, 'Storage Permission Denied',
                'กรุณาเปิด Permission Storage');
          }
        },
        child: Text('ดาวน์โหลด QR Code'),
      );

  Container buildQRcodePrompay() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: CachedNetworkImage(
        imageUrl: MyConstant.urlPrompay,
        placeholder: (context, url) => ShowProgress(),
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
              MyDialog().normalDialog(
                  context, 'คัดลอกเรียบร้อยร้อย', 'กรุณาไปยังแอพธนาคารของท่าน');
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
