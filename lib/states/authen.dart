import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_image.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            buildImage(size),
            buildAppName()
          ],
        ),
      ),
    );
  }

  Row buildAppName() {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                  title: MyConstant.appName, textStyle: MyConstant().h1Style()),
            ],
          );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.45,
          child: ShowImage(path: MyConstant.image1),
        ),
      ],
    );
  }
}
