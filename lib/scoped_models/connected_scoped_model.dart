import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/winner.dart';
import '../models/contest.dart';

class ConnectedProductsModel extends Model {
  List<Contest> _contests = [];
  int _selContestIndex;
}

class ContestModel extends ConnectedProductsModel {
  List<Contest> get displayContests {
    return List.from(_contests);
  }

  int get selectedContestIndex {
    return _selContestIndex;
  }

  Contest get selectedContest {
    if (selectedContestIndex == null) {
      return null;
    }
    return _contests[selectedContestIndex];
  }

  Future<Null> fetchContest() {
    notifyListeners();
    return http
        .get('https://flutter-app-9488a.firebaseio.com/contests.json')
        .then((http.Response response) {
      final List<Contest> fetchedContestList = [];
      //print(json.decode(response.body));

      final Map<String, dynamic> contestListData = json.decode(response.body);

      if (contestListData == null) {
        notifyListeners();
        return;
      }
      contestListData.forEach((String contestId, dynamic contestData) {
        final Contest contest = Contest(
          id: contestId,
          title: contestData['title'],
          description: contestData['description'],
          contestPrice: contestData['contestPrice'],
          endDate: contestData['endDate'],
          contestType: contestData['contestType'],
          startDate: contestData['startDate'],
          package: contestData['package'],
        );
        fetchedContestList.add(contest);
      });
      _contests = fetchedContestList;
      notifyListeners();
    });
  }
}

class WinnerModel extends ConnectedProductsModel {}

class UserModel extends ConnectedProductsModel {}
