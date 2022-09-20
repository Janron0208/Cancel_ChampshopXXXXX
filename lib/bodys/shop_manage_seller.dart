import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:champshop/models/user_model.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_progress.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShopManageSeller extends StatefulWidget {
  final UserModel userModel;
  const ShopManageSeller({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ShopManageSeller> createState() => _ShopManageSellerState();
}

class _ShopManageSellerState extends State<ShopManageSeller> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  Future<Null> refreshUserModel() async {
    print('## refreshUserModel Work');
    String apiGetUserWhereId =
        '${MyConstant.domain}/champshop/getUserWhereId.php?isAdd=true&id=${userModel!.id}';
    await Dio().get(apiGetUserWhereId).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.primary4,
        child: Icon(Icons.edit),
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeEditProfileSaler)
                .then((value) => refreshUserModel()),
      ),
      body: LayoutBuilder(
          builder: (context, constraints) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowTitle(
                        title: 'ชื่อร้าน : ',
                        textStyle: MyConstant().h1Style()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShowTitle(
                              title: userModel!.name,
                              textStyle: MyConstant().h2Style()),
                        ),
                      ],
                    ),
                    ShowTitle(
                        title: 'ที่อยู่ : ', textStyle: MyConstant().h1Style()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ShowTitle(
                              title: userModel!.address,
                              textStyle: MyConstant().h2Style(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ShowTitle(
                      title: 'เบอร์โทรศัพท์ : ${userModel!.phone}',
                      textStyle: MyConstant().h1Style(),
                    ),
                    ShowTitle(
                        title: 'อีเมลล์ : ', textStyle: MyConstant().h1Style()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShowTitle(
                              title: userModel!.email,
                              textStyle: MyConstant().h2Style()),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ShowTitle(
                        title: 'รูปโปรไฟล์',
                        textStyle: MyConstant().h1Style(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          width: constraints.maxWidth * 0.6,
                          child: CachedNetworkImage(
                            imageUrl:
                                '${MyConstant.domain}${userModel!.avatar}',
                            placeholder: (context, url) => ShowProgress(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
    );
  }
}
