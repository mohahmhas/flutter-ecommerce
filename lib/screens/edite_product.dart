import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/services/stor.dart';
import 'package:e_commerce/widget/buttonLogin.dart';
import 'package:e_commerce/widget/text_fields.dart';
import 'package:flutter/material.dart';
import '../constans.dart';

class EditeProduct extends StatelessWidget {
  static String id = 'EditeProduct';
  String _name, _price, _descreption, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              Container(
                height: height * 0.06,
              ),
              Column(
                children: [
                  TextFields(
                    onClick: (value) {
                      _name = value;
                    },
                    hint: 'product Name',
                    label: 'product Name',
                    icon: Icons.near_me,
                  ),
                  Container(
                    height: height * 0.01,
                  ),
                  TextFields(
                    onClick: (value) {
                      _price = value;
                    },
                    hint: 'Product Price',
                    label: 'Product Price',
                    icon: Icons.monetization_on_sharp,
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFields(
                    onClick: (value) {
                      _descreption = value;
                    },
                    hint: 'Product Description ',
                    label: 'Product Description',
                    icon: Icons.description_outlined,
                  ),
                  Container(
                    height: height * 0.01,
                  ),
                  TextFields(
                    onClick: (value) {
                      _category = value;
                    },
                    hint: 'Product Category',
                    label: 'Product Category',
                    icon: Icons.category_outlined,
                  ),
                  Container(
                    height: height * 0.01,
                  ),
                  TextFields(
                    onClick: (value) {
                      _imageLocation = value;
                    },
                    hint: 'Product Location',
                    label: 'Product Location',
                    icon: Icons.location_city,
                  ),
                  Button(
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        _store.editProduct(
                            ({
                              kProductName: _name,
                              kProductCategory: _category,
                              kProductDescription: _descreption,
                              kProductPrice: _price,
                              kProductLocation: _imageLocation,
                            }),
                            product.pId);
                      }
                    },
                    text: 'Add product',
                    icon: Icons.save_alt,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
