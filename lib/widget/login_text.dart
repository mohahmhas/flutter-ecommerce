import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextLogin extends StatefulWidget {
  @override
  _LoginTextState createState() => _LoginTextState();
}

class _LoginTextState extends State<TextLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: 10),
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          children: [
            Container(
              height: 80,
            ),
            Column(
              children: [
                Row(children: [
                  Text(
                    'Welcom In ',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ]),
                Row(children: [
                  Text(
                    'Shop ',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'onLine ',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
