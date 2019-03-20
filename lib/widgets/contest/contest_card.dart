import 'package:flutter/material.dart';

import '../contest/contest_price.dart';
import '../contest/contest_title.dart';
import '../../scoped_models/main_scoped_model.dart';
import '../../models/contest.dart';

class ContestCard extends StatelessWidget {
  final Contest contest;
  final int contestIndex;

  ContestCard(this.contest, this.contestIndex);

  Widget _buildContestCardItem() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TitleDefault(contest.title),
            SizedBox(
              height: 6.0,
            ),
            ContestPrice(contest.contestPrice.toString()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
