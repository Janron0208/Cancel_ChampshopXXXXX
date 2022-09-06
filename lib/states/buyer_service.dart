import 'package:champshop/utility/my_constant.dart';
import 'package:champshop/widgets/show_signout.dart';
import 'package:flutter/material.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({Key? key}) : super(key: key);

  @override
  State<BuyerService> createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer'),
        
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
