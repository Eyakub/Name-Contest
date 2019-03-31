import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/contest.dart';
import '../../widgets/contest/contest_card.dart';
import '../../scoped_models/main_scoped_model.dart';

class Contests extends StatelessWidget {
  Widget _buildContestList(List<Contest> contests) {
    Widget contestCards;
    if (contests.length > 0) {
      contestCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ContestCard(contests[index], index),
        itemCount: contests.length,
      );
    } else {
      // productCards = Center(
      //   child: Text("No products found, please add some"),
      // );
      contestCards = Container();
    }
    return contestCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[products widget] build');
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildContestList(model.allContests);
      },
    );
  }
}