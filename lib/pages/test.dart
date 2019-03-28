import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/ui_elements/side_drawer.dart';

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestState();
  }
}

class _TestState extends State<Test> {
  Color _myColor = Colors.green;
  String _myAccountState = "Account Enabled";

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('hi')),
        drawer: SideDrawer(),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text("Manage Accounts"),
              centerTitle: true,
            ),
            body: new Center(
              child: new Column(
                children: <Widget>[
                  new Text(_myAccountState),
                  new RaisedButton(
                      child: new Text("Click Me"),
                      color: _myColor,
                      onPressed: () {
                        setState(() {
                          if (_myColor == Colors.green) {
                            _myAccountState = "Account Disabled";
                            _myColor = Colors.red;
                          } else {
                            _myAccountState = "Account Enabled";
                            _myColor = Colors.green;
                          }
                        });
                      })
                ],
              ),
            ),
          ),
        ),
      );
}
