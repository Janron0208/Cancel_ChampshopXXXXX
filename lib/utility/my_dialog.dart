import 'package:flutter/material.dart';

import '../widgets/show_image.dart';
import '../widgets/show_title.dart';
import 'my_constant.dart';

class MyDialog {
  Future<Null> showProgressDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: Center(child: CircularProgressIndicator()),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }

  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image2),
          title: ShowTitle(title: title, textStyle: MyConstant().error1Style()),
          subtitle:
              ShowTitle(title: message, textStyle: MyConstant().error2Style()),
        ),
        children: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('ตกลง'))
        ],
      ),
    );
  }
}
