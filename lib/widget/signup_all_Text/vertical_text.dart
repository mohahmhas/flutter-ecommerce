import 'package:flutter/material.dart';

class VerticlSignup extends StatefulWidget {
  @override
  _VerticlTextState createState() => _VerticlTextState();
}

class _VerticlTextState extends State<VerticlSignup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
        quarterTurns: -1,
        child: Row(
          children: [
            Text(
              'Sign ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              children: [
                Text(
                  'up',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 70,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
