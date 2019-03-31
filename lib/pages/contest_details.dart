import 'package:flutter/material.dart';
import '../widgets/ui_elements/side_drawer.dart';
import '../scoped_models/main_scoped_model.dart';
class ContestDetailsPage extends StatelessWidget {
  final MainModel model;
  ContestDetailsPage(this.model);
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        drawer: SideDrawer(model),
        body: new Center(
          child:
          Text("The is details page"),
        ),
    );
  }
}
