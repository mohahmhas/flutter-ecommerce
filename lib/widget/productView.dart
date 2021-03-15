import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/screens/user/productinfo.dart';
import 'package:flutter/material.dart';

Widget productView(String cat, List<Product> allproducts) {
  List<Product> products = [];
  products = getProductByCatigory(cat, allproducts);
  return GridView.builder(
    itemCount: products.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.9, crossAxisCount: 2),
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].pName,
                          style: TextStyle(fontWeight: FontWeight.bold),
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
}

List<Product> getProductByCatigory(String cat, List<Product> allProduct) {
  List<Product> products = [];
  try {
    for (var product in allProduct) {
      if (product.pCategory == cat) {
        products.add(product);
      }
    }
  } on Error catch (e) {
    print(e);
  }
  return products;
}
