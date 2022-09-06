import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:champshop/utility/my_dialog.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utility/my_constant.dart';
import '../widgets/show_image.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();
  List<File?> files = [];
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFile();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => processAddProduct(),
              icon: Icon(Icons.cloud_upload))
        ],
        title: Text('เพิ่มสินค้า'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildProductName(constraints),
                    buildProductPrice(constraints),
                    buildProductDetail(constraints),
                    buildImage(constraints),
                    addProductButton(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container addProductButton(BoxConstraints constraints) {
    return Container(
        margin: EdgeInsets.only(top: 55, bottom: 40),
        width: constraints.maxWidth * 0.75,
        height: constraints.maxWidth * 0.12,
        child: ElevatedButton(
          style: MyConstant().myButtonStyle(),
          onPressed: () {
            processAddProduct();
          },
          child: Text('เพิ่มสินค้า'),
        ));
  }

  Future<Null> processAddProduct() async {
    if (formKey.currentState!.validate()) {
      bool checkFile = true;
      for (var item in files) {
        if (item == null) {
          checkFile = false;
        }
      }

      if (checkFile) {
        // print('## choose 4 images success');

        MyDialog().showProgressDialog(context);

        String apiSaveProduct =
            '${MyConstant.domain}/champshop/saveProduct.php';
        // print('### apiSaveProduct == $apiSaveProduct');

        int loop = 0;
        for (var item in files) {
          int i = Random().nextInt(1000000);
          String nameFile = 'product$i.jpg';
          Map<String, dynamic> map = {};
          map['file'] =
              await MultipartFile.fromFile(item!.path, filename: nameFile);
          FormData data = FormData.fromMap(map);
          await Dio().post(apiSaveProduct, data: data).then((value) {
            print('Upload Success');
            loop++;
            if (loop >= files.length) {
              Navigator.pop(context);
            }
          });
        }
      } else {
        MyDialog().normalDialog(context, 'ผิดพลาด!', 'กรุณาเลือกรูปภาพให้ครบ');
      }
    }
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
        files[index] = file;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDilog(int index) async {
    print('Click From index ==>> $index');
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: ListTile(
                leading: ShowImage(path: MyConstant.image1),
                title: ShowTitle(
                  title: 'เลือกภาพที่ ${index + 1}',
                  textStyle: MyConstant().h2Style(),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        processImagePicker(ImageSource.camera, index);
                      },
                      child: Text('กล้องถ่ายรูป'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        processImagePicker(ImageSource.gallery, index);
                      },
                      child: Text('แกลอรี่'),
                    ),
                  ],
                ),
              ],
            ));
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          width: constraints.maxWidth * 0.75,
          height: constraints.maxWidth * 0.75,
          child:
              file == null ? Image.asset(MyConstant.image3) : Image.file(file!),
        ),
        Container(
          width: constraints.maxWidth * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceImageDilog(0),
                  child: files[0] == null
                      ? Image.asset(MyConstant.image3)
                      : Image.file(
                          files[0]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceImageDilog(1),
                  child: files[1] == null
                      ? Image.asset(MyConstant.image3)
                      : Image.file(
                          files[1]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceImageDilog(2),
                  child: files[2] == null
                      ? Image.asset(MyConstant.image3)
                      : Image.file(
                          files[2]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceImageDilog(3),
                  child: files[3] == null
                      ? Image.asset(MyConstant.image3)
                      : Image.file(
                          files[3]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProductName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.8,
      margin: EdgeInsets.only(top: 8),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกชื่อสินค้า';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyConstant().h2Style(),
          labelText: 'ชื่อสินค้า',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary4),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary4),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary4),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildProductPrice(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.8,
      margin: EdgeInsets.only(top: 8),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกราคา';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: MyConstant().h2Style(),
          labelText: 'ราคา',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary4),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary4),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary4),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildProductDetail(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.8,
      margin: EdgeInsets.only(top: 8),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกรายละเอียด';
          } else {
            return null;
          }
        },
        maxLines: 4,
        decoration: InputDecoration(
          hintStyle: MyConstant().h2Style(),
          hintText: 'รายละเอียด',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary4),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary4),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.primary4),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
