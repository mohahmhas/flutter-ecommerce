import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  Button({@required this.text, @required this.icon, this.onPressed});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
          splashColor: Colors.blueGrey,
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.blueGrey),
              ),
              Icon(icon),
            ],
          ),
        )
      ],
    );
  }
}
