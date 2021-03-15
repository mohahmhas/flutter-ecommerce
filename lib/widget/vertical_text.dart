import 'package:flutter/material.dart';

class VerticlText extends StatefulWidget {
  @override
  _VerticlTextState createState() => _VerticlTextState();
}

class _VerticlTextState extends State<VerticlText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
        quarterTurns: -1,
        child: Row(
          children: [
            Text(
              'Log ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              children: [
                Text(
                  'in',
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
