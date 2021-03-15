import 'package:e_commerce/admin/addProduct.dart';
import 'package:e_commerce/admin/manage_product.dart';
import 'package:e_commerce/admin/veiwOrder.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  //bool isAdmin = false;
  String _email, _password;

  final adminpassword = '1234567';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueGrey, Colors.lightBlueAccent]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('add Product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageProduct.id);
            },
            child: Text('Edit Product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, OrderScreen.id);
            },
            child: Text('view orders'),
          ),
        ],
      ),
    );
  }
}
