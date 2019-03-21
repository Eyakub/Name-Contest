import 'package:flutter/material.dart';

class ContestPrice extends StatelessWidget {
  final String price;

  ContestPrice(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      child: Text(
        '\$' + price,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
