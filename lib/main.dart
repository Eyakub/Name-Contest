import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'pages/login_page.dart';
import './pages/home_page.dart';
import './pages/splash_page.dart';
import './pages/contest_list.dart';
import './pages/create_contest.dart';
//import 'package:flutter/rendering.dart';
import './scoped_models/main_scoped_model.dart';

void main() {
  //debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = new MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: (MaterialApp(
        title: 'Eyakub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          fontFamily: 'Nunito',
        ),
        routes: {
          '/': (BuildContext context) => SplashPage(_model),
          '/login': (BuildContext context) => LoginPage(_model),
          '/home': (BuildContext context) => HomePage(_model),
          '/contests': (BuildContext context) => ContestListPage(_model),
          '/createContest': (BuildContext context) => CreateContest(),
        },
        onGenerateRoute: (RouteSettings settings) {
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => HomePage(_model));
        },
      )),
    );
  }
}
