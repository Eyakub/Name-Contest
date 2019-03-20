import 'package:flutter/material.dart';

class ContestEndDate extends StatefulWidget {
  final String endDate;
  ContestEndDate(this.endDate);

  @override
  State<StatefulWidget> createState() {

    return _ContestEndDateState();
  }
  
}

class _ContestEndDateState extends State<ContestEndDate> {
  DateTime today = new DateTime.now();

   String dateSlug = '2018';
      //"${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      child: Text(
        dateSlug,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
