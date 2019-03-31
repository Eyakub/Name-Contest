import 'package:flutter/material.dart';
import '../../scoped_models/main_scoped_model.dart';
import '../../pages/contest_details.dart';

class HomeContestList extends StatelessWidget {
  final MainModel model;
  HomeContestList(this.model);

  Widget _buildContestItem(BuildContext context, category) {
    return Container(
      height: 120,
      width: 100,
      child: Card(
          elevation: 2.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(3.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(category),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContestDetailsPage(model),
                ),
              );
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    const categoryList = [
      "Contest 1",
      "Contest 2",
      "Contest 3",
      "Contest 4",
      "Contest 5"
    ];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
      height: 135.0,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: categoryList.map((category) {
            return Builder(
              builder: (BuildContext context) {
                return _buildContestItem(context, category);
              },
            );
          }).toList()),
    );
  }
}
