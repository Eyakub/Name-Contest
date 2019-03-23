import 'package:flutter/material.dart';

class ContestDayLeft extends StatelessWidget {
  final String dayLeft;

  ContestDayLeft(this.dayLeft);

  @override
  Widget build(BuildContext context) {
    return new Text(
        dayLeft,
        style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito', color: Colors.black38),
      );
  }
}
