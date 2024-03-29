import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main_scoped_model.dart';
import '../widgets/contest/contest_card.dart';
import '../models/contest.dart';

class ContestListPage extends StatefulWidget{
  final MainModel model;
  ContestListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ContestListPageState();
  }
}

class _ContestListPageState extends State<ContestListPage>{

  Widget _buildContestList(List<Contest> products) {
    Widget contestCards;
    if (products.length > 0) {
      contestCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ContestCard(products[index], index),
        itemCount: products.length,
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
        return _buildContestList(model.displayContests);
      },
    );
  }

}