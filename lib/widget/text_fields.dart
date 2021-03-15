import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final String hint;
  final String label;
  final IconData icon;
  final Function onClick;
  // ignore: missing_return
  String _errorMassage(String str) {
    switch (hint) {
      case 'Enter your Email':
        return 'Email is Required !';

      case 'Enter your Password':
        return 'passwoed is Required !';

      case 'Enter your Name':
        return 'Name is Required !';
    }
  }

  TextFields(
      {@required this.onClick,
      @required this.hint,
      @required this.label,
      @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return _errorMassage(hint);
              }
            },
            onSaved: onClick,
            obscureText: hint == 'Enter your Password' ? true : false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.blueGrey,
              ), //icon
              filled: true,
              fillColor: Colors.lightBlueAccent[50],
              labelText: label,
              hintText: hint,

              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(20)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(20)),
              border: InputBorder.none,

              labelStyle: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
