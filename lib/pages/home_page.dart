import 'package:flutter/material.dart';
import '../widgets/ui_elements/side_drawer.dart';
import '../widgets/ui_elements/text_button.dart';
import '../widgets/ui_elements/image_carousel.dart';
import '../widgets/home/home_contest_list.dart';
import '../widgets/home/home_recent_winner_list.dart';
import '../scoped_models/main_scoped_model.dart';

class HomePage extends StatefulWidget {
  final MainModel model;
  HomePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Contest'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 6.0,
            ),
            ImageCarousel(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Contests',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  TextButton(
                    buttonText: 'Show All',
                    buttonTextStyle: TextStyle(fontSize: 16.0),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/contests');
                    },
                  ),
                ],
              ),
            ),
            HomeContestList(),
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Recent Winners',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  TextButton(
                    buttonText: "Show All",
                    buttonTextStyle: TextStyle(fontSize: 16.0),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            HomeWinnerList(),
          ],
        ),
      ),
    );
  }
}
