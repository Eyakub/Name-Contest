import 'package:flutter/material.dart';
import '../widgets/ui_elements/side_drawer.dart';
class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestState();
  }
}

class _TestState extends State<Test> {
  int _value1 = 0;
  int _value2 = 0;

  void _setvalue1(int value) => setState(() => _value1 = value);
  void _setvalue2(int value) => setState(() => _value2 = value);

  // Widget makeRadios() {
  //   List<Widget> list = new List<Widget>();

  //   for (int i = 0; i < 3; i++) {
  //     list.add(new Radio(value: i, groupValue: _value1, onChanged: _setvalue1));
  //   }

  //   Column column = new Column(
  //     children: list,
  //   );

  //   return column;
  // }

  Widget makeRadioTiles() {
    List<Widget> list = new List<Widget>();

    for (int i = 0; i < 3; i++) {
      list.add(new RadioListTile<int>(
        value: i,
        groupValue: _value2,
        onChanged: _setvalue2,
        activeColor: Colors.green,
        //controlAffinity: ListTileControlAffinity.trailing,
        title: new Text('Item: $i'),
      ));
    }

    Column column = new Column(
      children: list,
    );
    return column;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      drawer: SideDrawer(),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              makeRadioTiles(),
            ],
          ),
        ),
      ),
    );
  }
}
