import 'package:flutter/material.dart';

class TitleDefault extends StatelessWidget {
  final String title;

  TitleDefault(this.title);

  @override
  Widget build(BuildContext context) {
    return new Text(
      title,
      style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
    );
  }
}
