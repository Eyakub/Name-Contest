import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Eyakub Sorkar"),
            accountEmail: Text("eyakubsorkar@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                            'https://yt3.ggpht.com/a-/AAuE7mCQh1zjDzo3kjPz4F_VxhTTwOeoCtQwPdfh4Q=s900-mo-c-c0xffffffff-rj-k-no'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("My Profile"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/userProfile');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Start A Contest"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/createContest');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("My Wishlist"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.text_format),
            title: Text("My Submission"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text("Sign Out"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}