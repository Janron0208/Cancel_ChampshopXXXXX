import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_image.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:flutter/material.dart';

class ShowNoData extends StatelessWidget {
  final String title;
  final String pathImage;
  const ShowNoData({
    Key? key,
    required this.title,
    required this.pathImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(decoration: MyConstant().gradintLinearBackground(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              width: 200,
              child: ShowImage(path: pathImage),
            ),
            ShowTitle(title: title, textStyle: MyConstant().h1Style()),
          ],
        ),
      ),
    );
  }
}