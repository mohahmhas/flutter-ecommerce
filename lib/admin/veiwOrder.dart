import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/admin/orderDetails.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/model/order.dart';
import 'package:e_commerce/services/stor.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrdars(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('thire is no orders'),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.docs) {
              orders.add(Order(
                documentID: doc.id,
                address: kAddress,
                totalPrice: doc.data()[kTotallPrice],
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetails.id,
                        arguments: orders[index].documentID);
                  },
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
                            'Totall Price = \$ ${orders[index].totalPrice}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Address is = \$ ${orders[index].totalPrice}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
