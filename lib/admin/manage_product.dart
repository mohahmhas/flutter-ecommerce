import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/screens/edite_product.dart';
import 'package:e_commerce/services/stor.dart';
import 'package:e_commerce/widget/custom_menu.dart';
import 'package:flutter/material.dart';
import '../constans.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';
  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
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
                return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9, crossAxisCount: 2),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTapUp: (details) async {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.width - dy;
                        await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              MyPopupMenuItem(
                                onClick: () {
                                  Navigator.pushNamed(context, EditeProduct.id,
                                      arguments: products[index]);
                                },
                                child: Text('Edit'),
                              ),
                              MyPopupMenuItem(
                                onClick: () {
                                  _store.deleteProduct(products[index].pId);
                                  Navigator.pop(context);
                                },
                                child: Text('Delete'),
                              ),
                            ]);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
      ),
    );
  }
}
