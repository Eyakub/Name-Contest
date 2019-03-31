import 'package:flutter/material.dart';

import '../widgets/ui_elements/contest_title.dart';
import '../widgets/ui_elements/side_drawer.dart';
import '../widgets/ui_elements/contest_day_left.dart';
import '../scoped_models/main_scoped_model.dart';

class ContestSubmissionPage extends StatefulWidget {
  //final String contestType;
  //ContestWishlist(this.contestType);
  final MainModel model;
  ContestSubmissionPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ContestSubmissionPageState();
  }
}

class _ContestSubmissionPageState extends State<ContestSubmissionPage> {
  List<Map<String, dynamic>> _submissionList = [
    {
      "contest_title": "Title 1",
      "submitted_name_submission": "E-Com",
      "contest_domain": "Django",
      "submission_date": "13 March"
    },
    {
      "contest_title": "Title 1",
      "submitted_name_submission": "E-Com",
      "contest_domain": "Django",
      "submission_date": "13 March"
    },
  ];

  Widget _buildSubmittedContestName(Map<String, dynamic> submissionList) {
    return new Text(
      submissionList['submitted_name_submission'],
      style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito', color: Colors.black38),
    );
  }

  Widget _buildDomainName(Map<String, dynamic> submissionList) {
    return new Text(
      submissionList['contest_domain'],
      style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito', color: Colors.black38),
    );
  }

  Widget _buildFavoriteIcon() {
    return new IconButton(
      icon: Icon(Icons.star_border),
      onPressed: null,
    );
  }

  Widget _buildSubmissionsItem(Map<String, dynamic> submissionList) {
    return Card(
      child: Container(
        height: 135,
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 6),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                  //decoration: BoxDecoration(color: Colors.blue),
                  child: ListTile(
                title: TitleDefault(submissionList['contest_title']),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 16.0,
                    ),
                    _buildSubmittedContestName(submissionList),
                    _buildDomainName(submissionList),
                    SizedBox(
                      height: 5,
                    ),
                    new Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today),
                        SizedBox(width: 4,),
                        Text(submissionList['submission_date'])
                      ],
                    )
                  ],
                ),
              )),
            ),
            Flexible(
              flex: 1,
              child: Container(
                //decoration: BoxDecoration(color: Colors.cyan),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        right: 4,
                        child: _buildFavoriteIcon(),
                      ),
                      
                      Positioned(
                        top: 84,
                        right: 2,
                        child: ContestDayLeft('13 Days Left'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContestSubmissionList() {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          _buildSubmissionsItem(_submissionList[index]),
      itemCount: _submissionList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Submissions'),
      ),
      drawer: SideDrawer(widget.model),
      body: Padding(
        padding:
            EdgeInsets.only(top: 14.0, bottom: 14.0, left: 10.0, right: 10.0),
        child: _buildContestSubmissionList(),
      ),
    );
  }
}
