import 'package:flutter/material.dart';

class HomeWinnerList extends StatelessWidget {
  Widget _buildCircleImage(BuildContext context, category) {
    return Container(
      height: 90,
      width: 90,
      margin: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new AssetImage('assets/unnamed.jpg'),
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context, category) {
    return Container(
      width: 85,
      margin: EdgeInsets.only(left: 10.0),
      alignment: Alignment.center,
      child: new Text(category),
    );
  }

  Widget _buildPrice(BuildContext context, category) {
    return Container(
      width: 85,
      margin: EdgeInsets.only(left: 10.0),
      alignment: Alignment.center,
      child: new Text(category),
    );
  }

  Widget _buildCategoryItem(BuildContext context, category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCircleImage(context, category),
        _buildName(context, category),
        _buildPrice(context, category),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const nameList = ["Eyakub", "Sorkar", "Toha", "Shihab", "Adib"];
    const Map<String, String> winnerList = {
      'Eyakub': '\$5',
      'Sorkar': '\$5',
      'Toha': '\$5',
      'Shihab': '\$5',
      'Adib': '\$5',
    };
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
      height: 170.0,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: nameList.map((category) {
            return Builder(
              builder: (BuildContext context) {
                return _buildCategoryItem(context, category);
              },
            );
          }).toList()),
    );
  }
}
