import 'dart:async';
import '../scoped_models/main_scoped_model.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {

  final MainModel model;

  SplashPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Timer(Duration(milliseconds: 1000), () {
      Navigator.pushReplacementNamed(context, "/login");
    });
    super.initState();
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
      ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: Center(
          child: Text('This is Splash', style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}