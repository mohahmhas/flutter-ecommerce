import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/screens/user/cartScrren.dart';
import 'package:e_commerce/screens/user/productinfo.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/services/stor.dart';
import 'package:e_commerce/widget/productView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constans.dart';

const kUnActiveColor = Color(0xFFC1BDB8);

class HomePage extends StatefulWidget {
  static String id = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  final _store = Store();
  User _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  List<Product> _product;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Stack(
        children: [
          DefaultTabController(
            length: 4,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _bottomBarIndex,
                fixedColor: Colors.lightBlueAccent,
                onTap: (value) {
                  setState(() {
                    _bottomBarIndex = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      title: Text('k'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('k'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('k'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('k'), icon: Icon(Icons.person)),
                ],
              ),
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: <Color>[
                        Colors.lightBlueAccent,
                        Colors.blueGrey[600],
                        // Colors.red[100]
                      ])),
                ),
                elevation: 0,
                bottom: TabBar(
                  onTap: (value) {
                    setState(() {
                      _tabBarIndex = value;
                    });
                  },
                  tabs: [
                    Text(
                      'Jacket',
                      style: TextStyle(
                        color:
                            _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                        fontSize: _tabBarIndex == 0 ? 18 : null,
                      ),
                    ),
                    Text(
                      'Trosers',
                      style: TextStyle(
                        color:
                            _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                        fontSize: _tabBarIndex == 1 ? 18 : null,
                      ),
                    ),
                    Text(
                      'T-shirt',
                      style: TextStyle(
                        color:
                            _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                        fontSize: _tabBarIndex == 2 ? 18 : null,
                      ),
                    ),
                    Text(
                      'shose',
                      style: TextStyle(
                        color:
                            _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                        fontSize: _tabBarIndex == 3 ? 18 : null,
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  jacketView(),
                  productView(kTrousers, _product),
                  productView(kTshirts, _product),
                  productView(kShoes, _product),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 40, 19, 15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScrren.id);
                      },
                      child: Icon(Icons.shopping_cart_outlined))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget jacketView() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueGrey[100], Colors.lightBlueAccent[100]]),
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();

                products.add(Product(
                  pId: doc.id,
                  pCategory: data[kProductCategory],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pName: data[kProductName],
                  pPrice: data[kProductPrice],
                ));
              }
              _product = [...products];
              products.clear();
              products = getProductByCatigory(kJackets, _product);
              return GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.9, crossAxisCount: 2),
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProductInfo.id,
                          arguments: products[index]);
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                              fit: BoxFit.fill,
                              scale: 1.0),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: 0.6,
                            child: Container(
                              color: Colors.blue,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[index].pName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('\$ ${products[index].pPrice} '),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: Text('loading...'));
            }
          }),
    );
  }
}
