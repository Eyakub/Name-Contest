import 'package:flutter/material.dart';

class Contest{
  final String id;
  final String contestType;
  final String package;
  final int contestFee;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  int privateContestFee;
  String keywordSuggestion;
  String wordsToAvoid;
  String examples;
  String languagePreferences;


  Contest({
    @required this.id,
    @required this.contestType,
    @required this.package,
    @required this.contestFee,
    @required this.title,
    @required this.description,
    @required this.startDate,
    @required this.endDate,
    this.privateContestFee,
    this.keywordSuggestion,
    this.wordsToAvoid,
    this.examples,
    this.languagePreferences,
  });
}