import 'package:flutter/material.dart';


  class LoginModel {
    final int userId;
    final String username;
    final String firstName;
    double balance;
    final String gender;
    bool isSuperuser;
    final String mNumber;
    final String email;

    LoginModel({
      @required this.userId,
      @required this.username,
      @required this.firstName,
      @required this.mNumber,
      @required this.email,
      @required this.gender,
      this.balance,
      this.isSuperuser,
    });
  }