import 'dart:convert';

import 'package:champshop/models/sqlite_model.dart';
import 'package:champshop/models/user_model.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/utility/sqlite_helper.dart';
import 'package:champshop/widgets/show_progress.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/my_dialog.dart';
import '../widgets/show_image.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({Key? key}) : super(key: key);

  @override
  _ShowCartState createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLiteModel> sqliteModels = [];
  bool load = true;
  UserModel? userModel;
  int? total;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processReadSQLite();
  }

  Future<Null> processReadSQLite() async {
    if (sqliteModels.isNotEmpty) {
      sqliteModels.clear();
    }

    await SQLiteHelper().readSQLite().then((value) {
      // print('### value on processReadSQLite ==>> $value');
      setState(() {
        load = false;
        sqliteModels = value;
        // findDetailSeller();  //อันนี้ที่ปิดอยู่เพราะ Error
        calculateTotal();
      });
    });
  }

  void calculateTotal() async {
    total = 0;
    for (var item in sqliteModels) {
      int sumInt = int.parse(item.sum.trim());
      setState(() {
        total = total! + sumInt;
      });
    }
  }

  Future<void> findDetailSeller() async {
    String idSeller = sqliteModels[0].idSeller;
    print('### idSeller ==>> $idSeller');
    String apiGetUserWhereId =
        '${MyConstant.domain}/champshop/getUserWhereId.php?isAdd=true&id=$idSeller';
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
      appBar: AppBar(
        title: Text('ตะกร้าสินค้า'),
      ),
      body: load
          ? ShowProgress()
          : sqliteModels.isEmpty
              ? Container(decoration: MyConstant().planBackground(),
                child: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        width: 200,
                        child: ShowImage(path: MyConstant.image4),
                      ),
                      ShowTitle(
                          title: 'ไม่มีรายการในตะกร้าสินค้า',
                          textStyle: MyConstant().h1Style()),
                    ],
                  )),
              )
              : buildContent(),
    );
  }

  Container buildContent() {
    return Container(
      decoration: MyConstant().planBackground(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showSeller(),
          buildHead(),
          listProduct(),
          buildDivider(),
          buildTotal(),
          buildDivider(),
          buttonController(),
        ],
      ),
    );
  }

  Future<void> confirmEmptyCart() async {
    print('### confirmEmptyCart Work');
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: ListTile(
                leading: ShowImage(path: MyConstant.image4),
                title: ShowTitle(
                    title: 'ล้างรายการสินค้า ?',
                    textStyle: MyConstant().h1Style()),
                subtitle: ShowTitle(
                    title: 'ลบสินค้าทั้งหมดในตะกร้าใช่ไหม ?',
                    textStyle: MyConstant().h3Style()),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    await SQLiteHelper().emptySQLite().then((value) {
                      Navigator.pop(context);
                      processReadSQLite();
                    });
                  },
                  child: Text('ยืนยัน'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('ยกเลิก'),
                ),
              ],
            ));
  }

  Row buttonController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () async {
            // MyDialog().showProgressDialog(context);

            // SharedPreferences preferences =
            //     await SharedPreferences.getInstance();
            // String idBuyer = preferences.getString('id')!;

            // var path =
            //     '${MyConstant.domain}/champshop/getWalletWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer';
            // await Dio().get(path).then((value) {
            //   Navigator.pop(context);
            //   print('#### value == $value');
            //   if (value.toString() == 'null') {
            //     print('#### action Alert add Wallet');
            //     MyDialog(
            //       funcAction: () {
            //         Navigator.pop(context);
                    Navigator.pushNamed(context, MyConstant.routeAddWallet);
            //       },
            //     ).actionDialog(context, 'No Wallet', 'Please Add Waller');
            //   } else {
            //     print('#12feb check Wallet can Payment');

            //     int approveWallet = 0;
            //     // for (var item in json.decode(value.data)) {
            //     //   WalletModel walletModel = WalletModel.fromMap(item);
            //     //   if (walletModel.status == 'Approve') {
            //     //     approveWallet =
            //     //         approveWallet + int.parse(walletModel.money.trim());
            //     //   }
            //     // }
            //     print('#12feb approveWallet ==> $approveWallet');
            //     // if (approveWallet - total! >= 0) {
            //     //   print('#12feb Can Order');
            //     //   MyDialog(funcAction: orderFunc).actionDialog(
            //     //       context,
            //     //       'Confirm Order ?',
            //     //       'Order Total : $total thb \n Please Confirm Order');
            //     // } else {
            //     //   print('#12feb Cannot Order');
            //     //   MyDialog().normalDialog(context, 'Cannot Order ?',
            //     //       'Approve Money : $approveWallet thb \n Total : $total thb \n จำนวนเงิน ไม่พอจ่าย คุณรอให้ Admin Approve ก่อน หรือ Add Wallet เข้ามา');
            //     // }
            //   }
            // });
          },
          child: Text('สั่งซื้อ'),
        ),
        Container(
          margin: EdgeInsets.only(left: 4, right: 8),
          child: ElevatedButton(
            onPressed: () => confirmEmptyCart(),
            child: Text('ล้างรายการ'),
          ),
        ),
      ],
    );
  }

  Row buildTotal() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowTitle(
                title: 'ราคารวมทั้งหมด :',
                textStyle: MyConstant().h1Style(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                title: total == null ? '' : total.toString(),
                textStyle: MyConstant().h1Style(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Divider buildDivider() {
    return Divider(
      color: MyConstant.primary1,
    );
  }

  ListView listProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ShowTitle(
                title: sqliteModels[index].name,
                textStyle: MyConstant().h3Style(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].price,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].amount,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].sum,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                int idSQLite = sqliteModels[index].id!;
                print('### Delete idSQLite ==>> $idSQLite');
                await SQLiteHelper()
                    .deleteSQLiteWhereId(idSQLite)
                    .then((value) => processReadSQLite());
              },
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Colors.red.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildHead() {
    return Container(
      decoration: BoxDecoration(color: MyConstant.primary3),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ShowTitle(
                  title: 'รายการ',
                  textStyle: MyConstant().h2Style(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'ราคา',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'จำนวน',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'ราคา',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Padding showSeller() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
        title: userModel == null ? '' : userModel!.name,
        textStyle: MyConstant().h1Style(),
      ),
    );
  }

  Future<void> orderFunc() async {
    Navigator.pop(context);
    print('orderFucn work');
  }
}
