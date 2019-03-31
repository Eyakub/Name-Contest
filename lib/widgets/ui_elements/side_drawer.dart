import 'package:flutter/material.dart';
import '../../scoped_models/main_scoped_model.dart';

class SideDrawer extends StatelessWidget {
  final MainModel model;
  SideDrawer(this.model);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(model.getUser.first_name),
            accountEmail: Text(model.getUser.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                            'https://yt3.ggpht.com/a-/AAuE7mCQh1zjDzo3kjPz4F_VxhTTwOeoCtQwPdfh4Q=s900-mo-c-c0xffffffff-rj-k-no'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
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
              Navigator.pushReplacementNamed(context, '/contestWishlist');
            },
          ),
          ListTile(
            leading: Icon(Icons.text_format),
            title: Text("My Submission"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/contestSubmissions');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/test');
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