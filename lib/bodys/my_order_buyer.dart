import 'package:flutter/material.dart';

class MyOrderBuyer extends StatefulWidget {
  const MyOrderBuyer({Key? key}) : super(key: key);

  @override
  State<MyOrderBuyer> createState() => _MyOrderBuyerState();
}

class _MyOrderBuyerState extends State<MyOrderBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('ตระกร้าสินค้า'),
    );
  }
}
