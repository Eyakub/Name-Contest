import 'package:flutter/material.dart';

class ContestPackage {
  final int id;
  final String packageName;
  final double prizeMoney;
  final int minimumIdeaSubmission;
  final int maximumContestLength;

  ContestPackage(
      {@required this.id,
      @required this.packageName,
      @required this.prizeMoney,
      @required this.minimumIdeaSubmission,
      @required this.maximumContestLength,});
}