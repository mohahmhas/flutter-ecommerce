import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/services/stor.dart';
import 'package:flutter/material.dart';

import '../constans.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: store.loadDetails(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                products.add(Product(
                  pName: data[kProductName],
                  pPrice: data[kProductPrice],
                  pQuantity: data[kProductQuantity],
                  pCategory: data[kProductCategory],
                ));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, [index]) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          color: Colors.yellow,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'product name :  \$ ${products[index].pName}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quantity :  \$ ${products[index].pQuantity}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Category :  \$ ${products[index].pCategory}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonTheme(
                          buttonColor: Colors.blue,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text('Confirm order'),
                          ),
                        ),
                        ButtonTheme(
                          buttonColor: Colors.blue,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text('Delete order'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('loading...'),
              );
            }
          }),
    );
  }
}
