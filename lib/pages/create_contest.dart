import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/ui_elements/side_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CreateContest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateContestState();
  }
}

class _CreateContestState extends State<CreateContest> {
  double _result = 0.0;
  int _radioValue = 0;
  bool pressAttention = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _currentStep = 1;

  bool _isContestTypeLoading = false;
  bool _isPackageLoading = false;

  List<ContestType> _contestTypes = [];
  List<ContestPackage> _contestPackages = [];

  int _value = 0;
  void _setvalue(int value) => setState(() => _value = value);

  @override
  initState() {
    fetchContestType();
    //print(_contestTypes.length);
    super.initState();
  }

  void buttonPressState(String btnName) {
    if (btnName == 'Budget') {
      if (pressAttention == false) {
        pressAttention = true;
      } else {
        pressAttention = false;
      }
    }
  }

  void test() {
    return null;
  }

  Future<Null> fetchContestType() {
    //print("Loading Contest Type");
    //var client = createHttpClient();
    setState(() {
      _isContestTypeLoading = true;
    });
    return http
        .get('http://10.0.2.2:8000/api/v1/contest/contest-type/?format=json')
        .then((http.Response response) {
      final List<ContestType> fetchedContestTypeList = [];
      //print(json.decode(response.body));
      final List<dynamic> contestTypeListData = json.decode(response.body);
      //print(contestTypeListData);
      if (contestTypeListData == null) {
        setState(() {
          _isContestTypeLoading = false;
        });
        return;
      }

      contestTypeListData.forEach((dynamic contestTypeData) {
        contestTypeData = json.encode(contestTypeData).toString();
        Map<String, dynamic> contestTypeMap = json.decode(contestTypeData);
        //print(contestTypeMap);
        final ContestType contestType =
            ContestType(id: contestTypeMap['id'], name: contestTypeMap['name']);
        fetchedContestTypeList.add(contestType);
      });
      setState(() {
        _contestTypes = fetchedContestTypeList;
        print(_contestTypes);
        _isContestTypeLoading = false;
      });
    });
  }

  List<ContestType> get allContestType {
    return List.from(_contestTypes);
  }

  List<ContestType> get displayContestTypes {
    return List.from(_contestTypes);
  }

  Widget makeRadioList() {
    List<Widget> list = new List<Widget>();

    for (int i = 0; i < _contestTypes.length; i++) {
      list.add(
        new RadioListTile(
          value: i,
          groupValue: _value,
          onChanged: _setvalue,
          activeColor: Colors.green,
          //controlAffinity: ListTileControlAffinity.leading,
          title: Text(allContestType[i].name),
        ),
      );
    }

    Column column = new Column(
      children: list,
    );
    return column;
  }

  Widget makePackageInfoList() {
    final list = <Widget>[];

    for (int i = 0; i < 3; i++) {
      list.add(
        new RaisedButton(
          child: new Text('Budget'),
          textColor: Colors.white,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(6.0),
          ),
          color: pressAttention ? Colors.cyan : Colors.transparent,
          onPressed: () => setState(() => pressAttention = !pressAttention),
        ),
      );
      list.add(
        new Text(
          '200+ Submissions\n\$100 Prize Money\nDuration 10 Days',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      );

      list.add(
        SizedBox(
          height: 8.0,
        ),
      );
    }

    Column column = new Column(
      children: list,
    );
    return column;
  }

  Future<Null> fetchContestPackage() {
    setState(() {
      _isPackageLoading = true;
    });
    return http
        .get(
            'http://10.0.2.2:8000/api/v1/contest/package/all/?format=json&return_type=json&contest_type=1')
        .then(
      (http.Response response) {
        //print(response.body);
        final List<ContestPackage> fetchedContestPackageList = [];
        final List<dynamic> contestPackageListData = json.decode(response.body);
        if (contestPackageListData == null) {
          setState(() {
            _isPackageLoading = false;
          });
          return;
        }
        contestPackageListData.forEach(
          (dynamic contestPackageData) {
            contestPackageData = json.encode(contestPackageData).toString();
            Map<String, dynamic> contestPackageMap = json.decode(contestPackageData);
            //print(contestTypeMap);
            final ContestPackage contestPackage = ContestPackage(
              id: contestPackageMap['id'],
              packageName: contestPackageMap['name'],
              prizeMoney: contestPackageMap['prize_money'],
              minimumIdeaSubmission:
                  contestPackageMap['minimum_idea_submission'],
            );
            fetchedContestPackageList.add(contestPackage);
          },
        );
        setState(
          () {
            _contestPackages = fetchedContestPackageList;
            _isPackageLoading = false;
          },
        );
        //print("Contest Package Length: " + _contestPackages.length.toString());
        
      },
    );
  }

  void _nextStep() {
    setState(() {
      _currentStep = _currentStep + 1;
      if(_currentStep == 2) {
          fetchContestPackage();
      }
    });
  }

  void _previousStep() {
    setState(() {
      _currentStep = _currentStep - 1;
    });
  }

  Widget _buildStepOne() {
    Widget content;
    //int groupValue;
    if (!_isContestTypeLoading && _contestTypes.length > 0) {
      content = Container(
        padding: EdgeInsets.all(10.0),
        //alignment: AlignmentDirectional(0.0, 0.0),
        //alighment: AlignmentDirectional(0.0, 0.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Choose a Contest Type',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 20.0,
            ),
            new Column(
              children: <Widget>[
                makeRadioList(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).accentColor,
                      onPressed: _nextStep,
                      child: Text('Next'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      );
    } else if (_isContestTypeLoading) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: () {
        fetchContestType();
      },
      child: content,
    );
  }

  Widget _buildStepTwo() {
    Widget content;
    if (_contestPackages.length > 0 && !_isPackageLoading) {      
      content = Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Choose Package',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              SizedBox(
                height: 6.0,
              ),
              makePackageInfoList(),
              SizedBox(
                height: 14.0,
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Choose Contest Options',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                  new Row(
                    children: <Widget>[
                      new Checkbox(
                        value: true,
                        onChanged: null,
                      ),
                      Text('Contest Free \$90')
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Checkbox(
                        value: false,
                        onChanged: null,
                      ),
                      Text('Private Contest \$50')
                    ],
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    textColor: Colors.white,
                    color: Theme.of(context).accentColor,
                    onPressed: _previousStep,
                    child: Text('Previous'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  new RaisedButton(
                    textColor: Colors.white,
                    color: Theme.of(context).accentColor,
                    onPressed: _nextStep,
                    child: Text('Next'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    } else if (_isPackageLoading) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    }
    return content;
  }

  Widget _buildStepThree() {
    return new Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(labelText: 'Title'),
              //initialValue: product == null ? '' : product.title,
              validator: (String value) {
                //if(value.trim().length <= 0){
                if (value.isEmpty || value.length < 5) {
                  return "Title is required and should be minimum 5 character.";
                }
              },
              onSaved: (String value) {
                //_formData['title'] = value;
              },
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(labelText: 'Description'),
              //initialValue: product == null ? '' : product.title,
              validator: (String value) {
                //if(value.trim().length <= 0){
                if (value.isEmpty || value.length < 5) {
                  return "Title is required and should be minimum 5 character.";
                }
              },
              onSaved: (String value) {
                //_formData['title'] = value;
              },
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(labelText: 'Start Date'),
              //initialValue: product == null ? '' : product.title,
              validator: (String value) {
                //if(value.trim().length <= 0){
                if (value.isEmpty || value.length < 5) {
                  return "Title is required and should be minimum 5 character.";
                }
              },
              onSaved: (String value) {
                //_formData['title'] = value;
              },
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(labelText: 'End Date'),
              //initialValue: product == null ? '' : product.title,
              validator: (String value) {
                //if(value.trim().length <= 0){
                if (value.isEmpty || value.length < 5) {
                  return "Title is required and should be minimum 5 character.";
                }
              },
              onSaved: (String value) {
                //_formData['title'] = value;
              },
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration:
                  InputDecoration(labelText: 'Preferred Domain Extensions'),
              //initialValue: product == null ? '' : product.title,
              validator: (String value) {
                //if(value.trim().length <= 0){
                if (value.isEmpty || value.length < 5) {
                  return "Title is required and should be minimum 5 character.";
                }
              },
              onSaved: (String value) {
                //_formData['title'] = value;
              },
            ),
            new Row(
              children: <Widget>[
                new Checkbox(
                  onChanged: null,
                  value: true,
                ),
                new Text('Unregistered Domain Only')
              ],
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(labelText: 'Keywords Suggestion'),
              //initialValue: product == null ? '' : product.title,
              validator: (String value) {
                //if(value.trim().length <= 0){
                if (value.isEmpty || value.length < 5) {
                  return "Title is required and should be minimum 5 character.";
                }
              },
              onSaved: (String value) {
                //_formData['title'] = value;
              },
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(labelText: 'Words To Avoid'),
              //initialValue: product == null ? '' : product.title,
              validator: (String value) {
                //if(value.trim().length <= 0){
                if (value.isEmpty || value.length < 5) {
                  return "Title is required and should be minimum 5 character.";
                }
              },
              onSaved: (String value) {
                //_formData['title'] = value;
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  onPressed: _previousStep,
                  child: Text('Previous'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                new RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  onPressed: _nextStep,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepFour() {
    return new Container(
      padding: EdgeInsets.all(10.0),
      child: new ListView(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Contest Overview',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
            ],
          ),
          new Text(
            'Type',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            'Type Name',
            style:
                TextStyle(fontSize: 12.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 6.0,
          ),
          new Text(
            'Title',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            'Title Name',
            style:
                TextStyle(fontSize: 12.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 6.0,
          ),
          new Text(
            'Description',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            'Description Here',
            style:
                TextStyle(fontSize: 12.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 6.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Text(
                    'Start Date',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new Text(
                    'Start Date',
                    style: TextStyle(
                        fontSize: 12.0, color: Theme.of(context).accentColor),
                  ),
                ],
              ),
              new Column(
                children: <Widget>[
                  new Text(
                    'End Date',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new Text(
                    'End Date',
                    style: TextStyle(
                        fontSize: 12.0, color: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 6.0,
          ),
          new Text(
            'Keywords Suggestion',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            'Keywords Suggestion',
            style:
                TextStyle(fontSize: 12.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 6.0,
          ),
          new Text(
            'Words To Avoid',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            'Words To Avoid',
            style:
                TextStyle(fontSize: 12.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 6.0,
          ),
          new Text(
            'Language Preferences',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            'Language Preferences',
            style:
                TextStyle(fontSize: 12.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 6.0,
          ),
          new Text(
            'Preferred Domain Extensions',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            'Preferred Domain Extensions',
            style:
                TextStyle(fontSize: 12.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 6.0,
          ),
          new Text(
            'Unregistered Domain Only',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            'Yes/No',
            style:
                TextStyle(fontSize: 12.0, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 10.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bill Breakdown',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    'Package Type',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new Text(
                    'Package Type',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    'Contest Fee',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new Text(
                    'Contest Fee',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          new Text(
            'Do you agree to our Terms and Conditions?',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                onPressed: _previousStep,
                child: Text('Previous'),
              ),
              SizedBox(
                width: 10.0,
              ),
              new RaisedButton(
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                onPressed: test,
                child: Text('Submit'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_currentStep == 1) {
      return _buildStepOne();
    } else if (_currentStep == 2) {
      return _buildStepTwo();
    } else if (_currentStep == 3) {
      return _buildStepThree();
    } else {
      return _buildStepFour();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contest'),
      ),
      drawer: SideDrawer(),
      body: Center(
        child: _buildBody(),
      ), //_buildBody(),
    );
  }
}

class ContestType extends CreateContest {
  final int id;
  final String name;

  ContestType({@required this.id, @required this.name});
}

class ContestPackage extends CreateContest {
  final int id;
  final String packageName;
  final double prizeMoney;
  final int minimumIdeaSubmission;

  ContestPackage(
      {@required this.id,
      @required this.packageName,
      @required this.prizeMoney,
      @required this.minimumIdeaSubmission});
}
