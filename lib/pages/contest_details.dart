import 'package:flutter/material.dart';
import '../widgets/ui_elements/side_drawer.dart';
class ContestDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        drawer: SideDrawer(),
        body: new Center(
          child:
          Text("The is details page"),
        ),
    );
  }
}
