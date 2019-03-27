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
  // Show some different formats.
  final formats = {
    //InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    //InputType.time: DateFormat("HH:mm"),
  };

  // Changeable in demo
  InputType inputType = InputType.date;
  bool editable = true;
  DateTime date;

  
  DateTime now = new DateTime.now();
  String dateFormat =DateFormat('yyyy-MM-dd').format(DateTime.now());


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('hi')),
      drawer: SideDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text('Format: "${formats[inputType].pattern}"'),

            //
            // The widget.
            //
            DateTimePickerFormField(
              inputType: inputType,
              format: formats[inputType],
              editable: editable,
              decoration: InputDecoration(
                  labelText: dateFormat, hasFloatingPlaceholder: false, border: OutlineInputBorder()),
              onChanged: (dt) => setState(() => date = dt),
            ),

            Text('Date value: $date'),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text('Date picker'),
              value: inputType != InputType.time,
              onChanged: (value) => updateInputType(date: value),
            ),
          
            CheckboxListTile(
              title: Text('Editable'),
              value: editable,
              onChanged: (value) => setState(() => editable = value),
            ),
          ],
        ),
      ));

  void updateInputType({bool date}) {
    
    setState(() => inputType = InputType.date);
  }
}

