// import 'dart:convert';

// import 'package:champshop/models/user_model.dart';
// import 'package:champshop/utility/my_constant.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditProfileSaler extends StatefulWidget {
//   const EditProfileSaler({Key? key}) : super(key: key);

//   @override
//   State<EditProfileSaler> createState() => _EditProfileSalerState();
// }

// class _EditProfileSalerState extends State<EditProfileSaler> {

//   UserModel? userModel;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     findUser();
//   }

//   Future<Null> findUser() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String user = preferences.getString('user')!;

//     String apiGetUser = '${MyConstant.domain}/champshop/getUserWhereUser.php?isAdd=true&user=$user';
//     await Dio().get(apiGetUser).then((value) {
//       print('value from API ==>> $value');
//       for (var item in json.decode(value.data)) {
//         setState(() {
//           userModel = UserModel.fromMap(item);
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('แก้ไขข้อมูลร้านค้า'),
//       ),
//     );
//   }
// }

//อันบนคืออันเก่า

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:champshop/models/user_model.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/utility/my_dialog.dart';
import 'package:champshop/widgets/show_image.dart';
import 'package:champshop/widgets/show_progress.dart';
import 'package:champshop/widgets/show_title.dart';

class EditProfileSaler extends StatefulWidget {
  const EditProfileSaler({Key? key}) : super(key: key);

  @override
  _EditProfileSalerState createState() => _EditProfileSalerState();
}

class _EditProfileSalerState extends State<EditProfileSaler> {
  UserModel? userModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('user')!;

    String apiGetUser =
        '${MyConstant.domain}/champshop/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiGetUser).then((value) {
      print('value from API ==>> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          nameController.text = userModel!.name;
          addressController.text = userModel!.address;
          phoneController.text = userModel!.phone;
          emailController.text = userModel!.email;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Seller'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                buildTitle('General :'),
                buildName(constraints),
                buildAddress(constraints),
                buildPhone(constraints),
                buildEmail(constraints),
                buildTitle('Avatar :'),
                buildAvatar(constraints),
                // buildButtonEditProfile(),
                buildButtonEditProfile1(constraints),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildButtonEditProfile1(BoxConstraints constraints) {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 40),
        width: constraints.maxWidth * 0.75,
        height: constraints.maxWidth * 0.12,
        child: ElevatedButton(
          style: MyConstant().myButtonStyle(),
          onPressed: () {
            processEditProfileSeller();
          },
          child: Text('บันทึกข้อมูล'),
          
          
        ));
  }

  Future<Null> processEditProfileSeller() async {
    print('processEditProfileSeller Work');

    MyDialog().showProgressDialog(context);

    if (formKey.currentState!.validate()) {
      if (file == null) {
        print('## User Current Avatar');
        editValueToMySQL(userModel!.avatar);
      } else {
        String apiSaveAvatar = '${MyConstant.domain}/champshop/saveAvatar.php';

        List<String> nameAvatars = userModel!.avatar.split('/');
        String nameFile = nameAvatars[nameAvatars.length - 1];
        nameFile = 'edit${Random().nextInt(100)}$nameFile';

        print('## User New Avatar nameFile ==>>> $nameFile');

        Map<String, dynamic> map = {};
        map['file'] =
            await MultipartFile.fromFile(file!.path, filename: nameFile);
        FormData formData = FormData.fromMap(map);
        await Dio().post(apiSaveAvatar, data: formData).then((value) {
          print('Upload Succes');
          String pathAvatar = '/champshop/avatar/$nameFile';
          editValueToMySQL(pathAvatar);
        });
      }
    }
  }

  Future<Null> editValueToMySQL(String pathAvatar) async {
    print('## pathAvatar ==> $pathAvatar');
    String apiEditProfile =
        '${MyConstant.domain}/champshop/editProfileSellerWhereId.php?isAdd=true&id=${userModel!.id}&name=${nameController.text}&email=${emailController.text}&address=${addressController.text}&phone=${phoneController.text}&avatar=$pathAvatar';
    await Dio().get(apiEditProfile).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  ElevatedButton buildButtonEditProfile() => ElevatedButton.icon(
      onPressed: () => processEditProfileSeller(),
      icon: Icon(Icons.edit),
      label: Text('บันทึก'));

  Future<Null> createAvatar({ImageSource? source}) async {
    try {
      var result = await ImagePicker().getImage(
        source: source!,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              IconButton(
                onPressed: () => createAvatar(source: ImageSource.camera),
                icon: Icon(
                  Icons.add_a_photo,
                  color: MyConstant.primary2,
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.6,
                height: constraints.maxWidth * 0.6,
                child: userModel == null
                    ? ShowProgress()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: userModel!.avatar == null
                            ? ShowImage(path: MyConstant.avatar)
                            : file == null
                                ? buildShowImageNetwork()
                                : Image.file(file!),
                      ),
              ),
              IconButton(
                onPressed: () => createAvatar(source: ImageSource.gallery),
                icon: Icon(
                  Icons.add_photo_alternate,
                  color: MyConstant.primary2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  CachedNetworkImage buildShowImageNetwork() {
    return CachedNetworkImage(
      imageUrl: '${MyConstant.domain}${userModel!.avatar}',
      placeholder: (context, url) => ShowProgress(),
    );
  }

  Row buildName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Name';
              } else {
                return null;
              }
            },
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildEmail(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Email';
              } else {
                return null;
              }
            },
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'อีเมลล์ :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAddress(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Address';
              } else {
                return null;
              }
            },
            maxLines: 3,
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Address :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhone(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Phone';
              } else {
                return null;
              }
            },
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  ShowTitle buildTitle(String title) {
    return ShowTitle(
      title: title,
      textStyle: MyConstant().h2Style(),
    );
  }
}
