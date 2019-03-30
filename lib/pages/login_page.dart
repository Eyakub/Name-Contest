import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../scoped_models/main_scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/login.dart';

class LoginPage extends StatefulWidget {
  final MainModel model;
  LoginPage(this.model);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<LoginModel> _loginUserData = [];

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  bool _isLoginLoading = false;
  String msg = '';
  var datauser;

  Future<Null> getUserData() async {
    var getToken = datauser.toString();

    return http.get(
      'http://10.0.2.2:8000/api/v1/account/user/',
      headers: {HttpHeaders.authorizationHeader: getToken},
    ).then((http.Response response) {
      final List<LoginModel> fetchUserData = [];
      final List<dynamic> userData = json.decode(response.body);
      if (userData == null) {
        setState(() {
          _isLoginLoading = false;
        });
        return;
      }
      userData.forEach(
        (dynamic userData) {
          userData = json.encode(userData).toString();
          Map<String, dynamic> userDataMap = json.decode(userData);
          //print(contestTypeMap);
          final LoginModel loginModel = LoginModel(
            userId: userDataMap['id'],
            username: userDataMap['username'],
            email: userDataMap['email'],
            firstName: userDataMap['firstName'],
            gender: userDataMap['gender'],
            mNumber: userDataMap['mNumber'],
          );
          fetchUserData.add(loginModel);
        },
      );
      //print(fetchUserData);
      setState(
        () {
          _loginUserData = fetchUserData;
          _isLoginLoading = false;
        },
      );
      print('Length: ' + _loginUserData.length.toString());
    });
  }

  Future<String> _login() async {
    final response = await http
        .post('http://10.0.2.2:8000/api/v1/account/authenticate/', body: {
      'username': user.text,
      'password': pass.text,
    });

    var temp = json.decode(response.body);
    datauser = temp['token'];
    //Rprint(datauser);
    if (datauser.length == 0) {
      setState(() {
        msg = 'Login Failed';
      });
    } else {
      setState(() {
        datauser = json.decode(response.body);
      });
    }
    getUserData();
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: user,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: pass,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            _login();
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      msg,
                      style: TextStyle(fontSize: 20.0, color: Colors.red),
                    ),
                    SizedBox(height: 20.0),
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have any account ?",
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
