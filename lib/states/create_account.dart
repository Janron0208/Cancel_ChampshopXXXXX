import 'dart:io';

import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_image.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  File? file;
  final formKey = GlobalKey<FormState>();

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          width: size * 0.8,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกชื่อ-นามสกุลให้เรียบร้อย';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'ชื่อ - นามสกุล',
              prefixIcon: Icon(
                Icons.person_outline,
                color: MyConstant.primary4,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          width: size * 0.8,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกเบอร์โทรศัพท์ให้เรียบร้อย';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'เบอร์โทรศัพท์',
              prefixIcon: Icon(
                Icons.phone,
                color: MyConstant.primary4,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          width: size * 0.8,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกรหัสผ่านให้เรียบร้อย';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'รหัสผ่าน',
              prefixIcon: Icon(
                Icons.key,
                color: MyConstant.primary4,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          width: size * 0.8,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกอีเมล์ให้เรียบร้อย';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'อีเมล์',
              prefixIcon: Icon(
                Icons.mail,
                color: MyConstant.primary4,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          width: size * 0.8,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาชื่อบัญชีผู้ใช้ให้เรียบร้อย';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'ชื่อบัญชีผู้ใช้',
              prefixIcon: Icon(
                Icons.person,
                color: MyConstant.primary4,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          width: size * 0.8,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกที่อยู่ให้เรียบร้อย';
              } else {}
            },
            maxLines: 3,
            decoration: InputDecoration(
              hintStyle: MyConstant().h3Style(),
              // labelText: 'ที่อยู่',
              hintText: 'ที่อยู่',
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Icon(
                  Icons.home,
                  color: MyConstant.primary4,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column buildAvatar(double size) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.3,
          child: file == null
              ? ShowImage(path: MyConstant.avatar)
              : Image.file(file!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () => chooseImage(ImageSource.camera),
                icon: Icon(
                  Icons.add_a_photo,
                  size: 30,
                  color: MyConstant.primary3,
                )),
            IconButton(
                onPressed: () => chooseImage(ImageSource.gallery),
                icon: Icon(
                  Icons.add_photo_alternate,
                  size: 30,
                  color: MyConstant.primary3,
                )),
          ],
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildCreateNewAccount(),
        ],
        title: Text('สมัครสมาชิก'),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildAvatar(size),
                buildTitle('กรอกข้อมูลให้ถูกต้อง'),
                buildName(size),
                // buildRadioBuyer(),
                buildAddress(size),
                buildEmail(size),
                buildPhone(size),
                buildUser(size),
                buildPassword(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildCreateNewAccount() {
    return IconButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (typeUser == null) {
                print('object');
              } else {
                print('object');
              }
            }
          },
          icon: Icon(Icons.cloud_upload),
        );
  }

  RadioListTile<String> buildRadioBuyer() {
    return RadioListTile(
      value: 'buyer',
      groupValue: typeUser,
      onChanged: (value) {
        setState(() {
          typeUser = value as String?;
        });
      },
      title: ShowTitle(title: 'ลูกค้า', textStyle: MyConstant().h3Style()),
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h1Style(),
      ),
    );
  }
}
