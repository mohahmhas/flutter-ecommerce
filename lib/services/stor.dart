import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce/model/product.dart';
import '../constans.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addProduct(Product product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductCategory: product.pCategory,
      kProductLocation: product.pLocation,
      kProductPrice: product.pPrice,
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductsCollection).snapshots();
  }

  deleteProduct(id) {
    return _firestore.collection(kProductsCollection).doc(id).delete();
  }

  editProduct(data, id) {
    _firestore.collection(kProductsCollection).doc(id).update(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrders).doc();
    documentRef.set(data);
    for (var product in products)
      documentRef.collection(kOrderDetails).doc().set({
        kProductName: product.pName,
        kProductLocation: product.pLocation,
        kProductPrice: product.pPrice,
        kProductQuantity: product.pQuantity,
        kProductCategory: product.pCategory,
      });
  }

  Stream<QuerySnapshot> loadOrdars() {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadDetails(id) {
    return _firestore
        .collection(kOrders)
        .doc(id)
        .collection(kOrderDetails)
        .snapshots();
  }
}
