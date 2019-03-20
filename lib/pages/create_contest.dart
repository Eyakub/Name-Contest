import 'package:flutter/material.dart';
import '../widgets/ui_elements/side_drawer.dart';

class CreateContest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateContestState();
  }
}

class _CreateContestState extends State<CreateContest> {
  Widget _buildFirstStep() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    int groupValue;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contest'),
      ),
      drawer: SideDrawer(),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        //alignment: AlignmentDirectional(0.0, 0.0),
        //alighment: AlignmentDirectional(0.0, 0.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Choose a Contest Type',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor),
            ),
            new Column(
              children: <Widget>[
                new Radio(
                  value: 0,
                  groupValue: groupValue,
                  onChanged: (e) => SawTooth(e),
                ),
                new Text(
                  'Carnivore',
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
