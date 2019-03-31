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
  bool _isContestListLoading = false;

  User _currentUser;
  String _token;
}

class ContestModel extends ConnectedProductsModel {
  List<Contest> get allContests {
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

  Future<Null> fetchContestList() {
    _isContestListLoading = true;
    notifyListeners();
    return http
        .get('http://10.0.2.2:8000/api/v1/contest/contest/')
        .then((http.Response response) {
      final List<Contest> fetchedContestList = [];
      print(json.decode(response.body));

      final Map<String, dynamic> contestListData = json.decode(response.body);

      if (contestListData == null) {
        _isContestListLoading = false;
        notifyListeners();
        return;
      }
      contestListData.forEach((String contestId, dynamic contestData) {
        final Contest contest = Contest(
          id: contestId,
          title: contestData['title'],
          description: contestData['description'],
          contestFee: contestData['contestFee'],
          prizeMoney: contestData['prizeMoney'],
          endDate: contestData['endDate'],
          contestType: contestData['contestType'],
          startDate: contestData['startDate'],
          privateContest: contestData['privateContest'],
          package: contestData['package'],
        );
        fetchedContestList.add(contest);
      });
      _contests = fetchedContestList;
      //print(fetchedContestList);
      notifyListeners();
    });
  }
}

class WinnerModel extends ConnectedProductsModel {}

class UserModel extends ConnectedProductsModel {

  String get getToken{
    return _token;
  }

  User get getUser{
    return _currentUser;
  }

  set setToken(String value) => _token = value;

  set setUser(User currentUser) => _currentUser = currentUser;

}
