import 'package:flutter/material.dart';

class ContestPrize extends StatelessWidget {
  final String prize;

  ContestPrize(this.prize);

  @override
  Widget build(BuildContext context) {
    return new Text(
        '\$' + prize,
        style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
      );
  }
}
