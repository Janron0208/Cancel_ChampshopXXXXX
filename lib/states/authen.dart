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
  bool statusRedEye = true;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: [
              buildImage(size),
              buildAppName(),
              buildTextUser(),
              buildUser(size),
              buildPassword(size),
              buildLogin(size),
              buildCreateAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTextUser() {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: ShowTitle(title: 'เข้าสู่ระบบ', textStyle: MyConstant().h1Style()),
    );
  }

  TextButton buildCreateAccount() => TextButton(
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeCreateAccount),
        style: TextButton.styleFrom(
          primary: MyConstant.primary2,
        ),
        child: Text('สมัครสมาชิก'),
      );

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // margin: EdgeInsets.symmetric(vertical: 20),
          margin: EdgeInsets.only(top: 25, bottom: 8),
          width: size * 0.8,
          height: size * 0.129,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle(),
            onPressed: () {},
            child: Text('เข้าสู่ระบบ'),
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
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'ชื่อบัญชีผู้ใช้',
              suffixIcon: Icon(
                Icons.person_outline,
                color: MyConstant.primary4,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(35),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(35),
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
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            obscureText: statusRedEye,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                },
                icon: statusRedEye
                    ? Icon(
                        Icons.remove_red_eye,
                        color: MyConstant.primary4,
                      )
                    : Icon(
                        Icons.remove_red_eye_outlined,
                        color: MyConstant.primary4,
                      ),
              ),

              labelStyle: MyConstant().h3Style(),
              labelText: 'รหัสผ่าน',
              // suffixIcon: Icon(
              //   Icons.lock_outline,
              //   color: MyConstant.primary2,
              // ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(35),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.primary4),
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              ShowTitle(
                  title: MyConstant.appName,
                  textStyle: MyConstant().headStyle()),
              ShowTitle(
                  title: "ร้านจำหน่ายอุปกรณ์ก่อสร้าง",
                  textStyle: MyConstant().h3Style())
            ],
          ),
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 100),
          width: size * 0.45,
          child: ShowImage(path: MyConstant.image1),
        ),
      ],
    );
  }
}
