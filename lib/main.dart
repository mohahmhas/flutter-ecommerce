import 'package:e_commerce/admin/addProduct.dart';
import 'package:e_commerce/admin/manage_product.dart';
import 'package:e_commerce/provider/adminMode.dart';
import 'package:e_commerce/provider/cartItem.dart';
import 'package:e_commerce/provider/modelHud.dart';
import 'package:e_commerce/screens/adminHome.dart';
import 'package:e_commerce/screens/edite_product.dart';
import 'package:e_commerce/screens/loginScreen.dart';
import 'package:e_commerce/screens/register.dart';
import 'package:e_commerce/screens/user/cartScrren.dart';
import 'package:e_commerce/screens/user/homePage.dart';
import 'package:e_commerce/screens/user/productinfo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'admin/orderDetails.dart';
import 'admin/veiwOrder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          OrderDetails.id: (context) => OrderDetails(),
          OrderScreen.id: (context) => OrderScreen(),
          CartScrren.id: (context) => CartScrren(),
          EditeProduct.id: (context) => EditeProduct(),
          ManageProduct.id: (context) => ManageProduct(),
          AddProduct.id: (context) => AddProduct(),
          AdminHome.id: (context) => AdminHome(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage(),
          ProductInfo.id: (context) => ProductInfo(),
        },
      ),
    );
  }
}
