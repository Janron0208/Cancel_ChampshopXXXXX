import 'package:champshop/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/my_constant.dart';

class ShowSignOut extends StatelessWidget {
  const ShowSignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeAuthen, (route) => false),
                );
          },
          tileColor: Color.fromARGB(255, 180, 244, 185),
          leading: Icon(
            Icons.exit_to_app,
            size: 34,
            color: Color.fromARGB(255, 62, 156, 11),
          ),
          title: ShowTitle(
            title: 'ออกจากระบบ',
            textStyle: MyConstant().h2Style(),
          ),
        ),
      ],
    );
  }
}