import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/provider/cartItem.dart';
import 'package:e_commerce/screens/user/cartScrren.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 0;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              /*child: Image(
                fit: BoxFit.fill,
                image: AssetImage(product.pLocation),
              ),*/
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 40, 19, 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, CartScrren.id);
                        },
                        child: Icon(Icons.shopping_cart_outlined))
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              child: Column(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.pName,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              product.pDescription,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '\$ ${product.pPrice}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: Colors.blueAccent,
                                    child: GestureDetector(
                                      onTap: addmeth,
                                      child: SizedBox(
                                        child: Icon(Icons.add),
                                        height: 28,
                                        width: 28,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  _quantity.toString(),
                                  style: TextStyle(fontSize: 60),
                                ),
                                ClipOval(
                                  child: Material(
                                    color: Colors.blueAccent,
                                    child: GestureDetector(
                                      onTap: subtract(),
                                      child: SizedBox(
                                        child: Icon(Icons.remove),
                                        height: 28,
                                        width: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.099,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Builder(
                      builder: (context) => RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          addToCart(context, product);
                        },
                        child: Text(
                          'add to cart',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  addmeth() {
    setState(() {
      _quantity++;
    });
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart.pId == product.pId) {
        exist = true;
      }
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('you\'v add this item before'),
      ));
    } else {
      cartItem.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Added To card'),
      ));
    }
  }
}
