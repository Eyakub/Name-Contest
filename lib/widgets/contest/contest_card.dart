import 'package:flutter/material.dart';

import '../ui_elements/contest_prize.dart';
import '../ui_elements/contest_title.dart';
import '../../models/contest.dart';
import '../ui_elements/contest_end_date.dart';

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
            ContestPrize(contest.contestFee.toString()),
            SizedBox(
              height: 6.0,
            ),
            ContestEndDate(contest.endDate),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildContestCardItem(),
        ],
      ),
    );
  }
}
