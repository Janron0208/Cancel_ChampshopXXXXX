import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:champshop/models/product_model.dart';
import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/utility/my_dialog.dart';
import 'package:champshop/widgets/show_progress.dart';
import 'package:champshop/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  const EditProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  ProductModel? productModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  List<String> pathImages = [];
  List<File?> files = [];
  bool statusImage = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productModel = widget.productModel;
    convertStringToArray();
    nameController.text = productModel!.name;
    priceController.text = productModel!.price;
    detailController.text = productModel!.detail;
  }

  void convertStringToArray() {
    String string = productModel!.images;
    string = string.substring(1, string.length - 1);
    List<String> strings = string.split(',');
    for (var item in strings) {
      pathImages.add(item.trim());
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('แก้ไขรายการสินค้า'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(FocusScopeNode()),
                behavior: HitTestBehavior.opaque,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitle('ข้อมูลสินค้า'),
                      buildName(constraints),
                      buildPrice(constraints),
                      buildDetail(constraints),
                      buildTitle('รูปสินค้า'),
                      buildImage(constraints, 0),
                      buildImage(constraints, 1),
                      buildImage(constraints, 2),
                      buildImage(constraints, 3),
                      buildEditProduct(constraints),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Row buildEditProduct(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(top: 55, bottom: 40),
            width: constraints.maxWidth * 0.75,
            height: constraints.maxWidth * 0.12,
            child: ElevatedButton(
              style: MyConstant().myButtonStyle(),
              onPressed: () => processEdit(),
              child: Text('บันทึก'),
            )),
      ],
    );
  }

  Future<Null> chooseImage(int index, ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxHeight: 800,
        maxWidth: 800,
      );
      setState(() {
        files[index] = File(result!.path);
        statusImage = true;
      });
    } catch (e) {}
  }

  Container buildImage(BoxConstraints constraints, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 117, 191, 124)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => chooseImage(index, ImageSource.camera),
            icon: Icon(Icons.add_a_photo),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: constraints.maxWidth * 0.5,
            child: files[index] == null
                ? CachedNetworkImage(
                    imageUrl:
                        '${MyConstant.domain}/champshop/${pathImages[index]}',
                    placeholder: (context, url) => ShowProgress(),
                  )
                : Image.file(files[index]!),
          ),
          IconButton(
            onPressed: () => chooseImage(index, ImageSource.gallery),
            icon: Icon(Icons.add_photo_alternate),
          ),
        ],
      ),
    );
  }

  Row buildName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกชื่อสินค้า';
              } else {
                return null;
              }
            },
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'ชื่อสินค้า',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPrice(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกราคา';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.number,
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'ราคา',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildDetail(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกรายละเอียด';
              } else {
                return null;
              }
            },
            maxLines: 3,
            controller: detailController,
            decoration: InputDecoration(
              labelText: 'รายละเอียดสินค้า',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTitle(String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ShowTitle(title: title, textStyle: MyConstant().h1Style()),
        ),
      ],
    );
  }

 Future<Null> processEdit() async {
    if (formKey.currentState!.validate()) {
      
      MyDialog().showProgressDialog(context);


      String name = nameController.text;
      String price = priceController.text;
      String detail = detailController.text;
      String id = productModel!.id;
      String images;
      if (statusImage) {
        //Uploa image and Refresh array pathImages
      int index = 0;
      for (var item in files) {
        if (item != null) {
          int i = Random().nextInt(1000000);
          String nameImage = 'productEdit$i.jpg';
          String apiUploadImage = '${MyConstant.domain}/champshop/saveProduct.php';

          Map<String, dynamic> map = {};
          map['file'] = await MultipartFile.fromFile(item.path, filename: nameImage);
          FormData formData = FormData.fromMap(map);
          await Dio().post(apiUploadImage, data: formData).then((value) {
            pathImages[index] = '/product/$nameImage';
          });

        }
        index++;
      }



        images = pathImages.toString();
        Navigator.pop(context);
      } else {
        images = pathImages.toString();
      }

      print('## statusImage = $statusImage');
      print('### id = $id, name = $name, price = $price, detail = $detail');
      print('## Images = $images');

      String apiEditProduct = '${MyConstant.domain}/champshop/editProductWhereId.php?isAdd=true&id=$id&name=$name&price=$price&detail=$detail&images=$images';
      await Dio().get(apiEditProduct).then((value) => Navigator.pop(context));
    }
  }
}
