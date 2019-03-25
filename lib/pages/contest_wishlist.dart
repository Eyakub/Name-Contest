import 'package:flutter/material.dart';

import '../widgets/ui_elements/contest_prize.dart';
import '../widgets/ui_elements/contest_title.dart';
import '../widgets/ui_elements/side_drawer.dart';
import '../widgets/ui_elements/contest_day_left.dart';

class ContestWishlistPage extends StatefulWidget {
  //final String contestType;
  //ContestWishlist(this.contestType);

  @override
  State<StatefulWidget> createState() {
    return _ContestWishListPageState();
  }
}

class _ContestWishListPageState extends State<ContestWishlistPage> {
  List<Map<String, dynamic>> _wishlistItems = [
    {
      "contest_title": "XYX",
      "contest_type": "Business Name",
      "contest_prize": "100"
    },
    {
      "contest_title": "ABC",
      "contest_type": "Domain Name",
      "contest_prize": "200"
    },
  ];

  Widget _buildContestType(Map<String, dynamic> wishlistItem) {
    return new Text(
      wishlistItem['contest_type'],
      style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
    );
  }

  Widget _buildWishlistIcon() {
    return new IconButton(
      icon: Icon(Icons.favorite),
      onPressed: null,
    );
  }

  Widget _buildPrivateIcon() {
    return new IconButton(
      icon: Icon(Icons.lock),
      onPressed: null,
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> wishlistItem) {
    return Card(
      child: Container(
        height: 107,
        padding: EdgeInsets.only(top: 6, bottom: 10, left: 2, right: 6),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                  //decoration: BoxDecoration(color: Colors.blue),
                  child: ListTile(
                title: TitleDefault(wishlistItem['contest_title']),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 16.0,
                    ),
                    _buildContestType(wishlistItem),
                    SizedBox(
                      height: 5,
                    ),
                    ContestPrize(wishlistItem['contest_prize']),
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
                        child: _buildWishlistIcon(),
                      ),
                      Positioned(
                        top: 32,
                        right: 4,
                        child: _buildPrivateIcon(),
                      ),
                      Positioned(
                        top: 66,
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

  Widget _buildContestWishlist() {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          _buildWishlistItem(_wishlistItems[index]),
      itemCount: _wishlistItems.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding:
            EdgeInsets.only(top: 14.0, bottom: 14.0, left: 10.0, right: 10.0),
        child: _buildContestWishlist(),
      ),
    );
  }
}
