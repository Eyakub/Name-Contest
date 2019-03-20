import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  String buttonText;
  final VoidCallback onPressed;
  TextStyle textStyle,buttonTextStyle;
  //passing props in react style
  TextButton({
    this.buttonText,
    this.onPressed,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
        child: Text(this.buttonText, style: this.buttonTextStyle,),
      ),
      onTap: onPressed,
    );
  }
}