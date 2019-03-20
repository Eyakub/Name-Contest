import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final String gender;
  final String dob;
  final String address;

  User({
    @required this.id,
    @required this.email,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
    @required this.phone,
    @required this.gender,
    @required this.dob,
    @required this.address,
  });
}
