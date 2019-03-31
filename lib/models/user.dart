import 'package:flutter/material.dart';


  class User {
    final int id;
    final String first_name;
    final String last_name;
    final double balance;
    final String gender;
    bool is_superuser;
    final String phone_no;
    final String email;

    User({
      @required this.id,
      @required this.first_name,
      @required this.last_name,
      @required this.phone_no,
      @required this.email,
      @required this.gender,
      @required this.balance,
      this.is_superuser,
    });
  }