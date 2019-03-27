import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../widgets/ui_elements/side_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/contest_type.dart';
import '../models/contest_package.dart';
import '../models/country.dart';
import '../models/language.dart';

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
  bool _isCountryLoading = false;
  bool _isLanguageLoading = false;

  List<ContestType> _contestTypes = [];
  List<ContestPackage> _contestPackages = [];
  List<Country> _country = [];
  List<Language> _languages = [];
  String selectedLanguage;

  // Show some different formats.
  final formats = {
    InputType.date: DateFormat('yyyy-MM-dd'),
  };

  // Changeable in demo
  InputType inputType = InputType.date;
  bool editable = true;
  DateTime date;

  static String startDateString =
      DateFormat('yyyy-MM-dd').format(DateTime.now());
  static DateTime startDate = DateTime.parse(startDateString);
  static DateTime endDate = startDate.add(new Duration(days: 10));
  static String endDateString = DateFormat('yyyy-MM-dd').format(endDate);

  int _value = 0;
  void _setvalue(int value) => setState(() => _value = value);

  bool _unregisteredDomain = true;
  void _setUnregisteredDomain(bool value) =>
      setState(() => _unregisteredDomain = value);

  bool _privateContest = false;
  void _setPrivateContest(bool value) =>
      setState(() => _privateContest = value);

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

  ///BUTTONS
  Widget _previousButtom() {
    return new RaisedButton(
      textColor: Colors.white,
      color: Theme.of(context).accentColor,
      onPressed: _previousStep,
      child: Text('Previous'),
    );
  }

  Widget _nextButton() {
    return new RaisedButton(
      textColor: Colors.white,
      color: Theme.of(context).accentColor,
      onPressed: _nextStep,
      child: Text('Next'),
    );
  }

  ///STEP ONE CONTENT
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

  ///STEP TWO CONTENT
  Widget makePackageInfoList() {
    final list = <Widget>[];

    for (int i = 0; i < _contestPackages.length; i++) {
      int days = ((allContestPackage[i].maximumContestLength) / 24).round();
      list.add(
        new RaisedButton(
          child: new Text(allContestPackage[i].packageName),
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
          allContestPackage[i].minimumIdeaSubmission.toString() +
              '+ Submissions\n' +
              (allContestPackage[i].prizeMoney).round().toString() +
              '\$ Prize Money\nDuration ' +
              days.toString() +
              ' Days',
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

  List<ContestPackage> get allContestPackage {
    return List.from(_contestPackages);
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
            Map<String, dynamic> contestPackageMap =
                json.decode(contestPackageData);
            //print(contestTypeMap);
            final ContestPackage contestPackage = ContestPackage(
              id: contestPackageMap['id'],
              packageName: contestPackageMap['name'],
              prizeMoney: contestPackageMap['prize_money'],
              minimumIdeaSubmission:
                  contestPackageMap['minimum_idea_submission'],
              maximumContestLength: contestPackageMap['maximum_contest_length'],
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

  ///STEP THREE CONTENT

  ///STEP FOUR CONTENT

  /// Fetching Content Info

  //country
  Future<Null> fetchCountry() {
    setState(() {
      _isCountryLoading = true;
    });
    return http.get('http://10.0.2.2:8000/api/v1/others/country/').then(
      (http.Response response) {
        //print(response.body);
        final List<Country> fetchedCountryList = [];
        final List<dynamic> contestCountryData = json.decode(response.body);
        if (contestCountryData == null) {
          setState(() {
            _isCountryLoading = false;
          });
          return;
        }
        contestCountryData.forEach(
          (dynamic contestCountryData) {
            contestCountryData = json.encode(contestCountryData).toString();
            Map<String, dynamic> contestCountryMap =
                json.decode(contestCountryData);
            //print(contestTypeMap);
            final Country country = Country(
              countryName: contestCountryMap['name'],
            );
            fetchedCountryList.add(country);
          },
        );

        setState(
          () {
            _country = fetchedCountryList;
            _isCountryLoading = false;
          },
        );
        //print("Contest Package Length: " + _contestPackages.length.toString());
      },
    );
  }

  List<Country> get allCountry {
    return List.from(_country);
  }

  //Language
  Future<Null> fetchLanguages() {
    setState(() {
      _isLanguageLoading = true;
    });
    return http.get('http://10.0.2.2:8000/api/v1/others/language/').then(
      (http.Response response) {
        //print(response.body);
        final List<Language> fetchedLanguageList = [];
        final List<dynamic> contestLanguageData = json.decode(response.body);
        if (contestLanguageData == null) {
          setState(() {
            _isLanguageLoading = false;
          });
          return;
        }
        contestLanguageData.forEach(
          (dynamic contestLanguageData) {
            contestLanguageData = json.encode(contestLanguageData).toString();
            Map<String, dynamic> contestLanguageMap =
                json.decode(contestLanguageData);
            //print(contestTypeMap);
            final Language language = Language(
              id: contestLanguageMap['id'],
              languageName: contestLanguageMap['name'],
            );
            fetchedLanguageList.add(language);
          },
        );

        setState(
          () {
            _languages = fetchedLanguageList;
            _isLanguageLoading = false;
          },
        );
        //print("Contest Package Length: " + _languages.length.toString());
      },
    );
  }

  List<Language> get allLanguage {
    return List.from(_languages);
  }

  Widget _buildDomainExtentionInput() {
    if (false) {
      return TextFormField(
        //focusNode: _titleFocusNode,
        decoration: InputDecoration(
          labelText: 'Preferred Domain Extensions',
          border: OutlineInputBorder(),
        ),
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
      );
    } else {
      return Container();
    }
  }

  Widget _buildCheckBoxUnregistered() {
    if (false) {
      return new Row(
        children: <Widget>[
          new Checkbox(
            onChanged: _setUnregisteredDomain,
            value: _unregisteredDomain,
          ),
          new Text('Unregistered Domain Only')
        ],
      );
    } else {
      return Container();
    }
  }

  void _nextStep() {
    setState(() {
      _currentStep = _currentStep + 1;
      if (_currentStep == 2) {
        fetchContestPackage();
      } else if (_currentStep == 3) {
        fetchLanguages();
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
                    _nextButton(),
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
                        value: _privateContest,
                        onChanged: _setPrivateContest,
                      ),
                      Text('Private Contest \$50')
                    ],
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _previousButtom(),
                  SizedBox(
                    width: 10.0,
                  ),
                  _nextButton(),
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
            new Center(
              child: new Text(
                'Contest Information',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return "Title is required.";
                }
              },
              onSaved: (String value) {
                //_formData['title'] = value;
              },
            ),
            SizedBox(
              height: 6.0,
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return "Description is required.";
                }
              },
              onSaved: (String value) {
                //_formData['title'] = value;
              },
            ),
            SizedBox(
              height: 6.0,
            ),
            new DateTimePickerFormField(
              inputType: inputType,
              format: formats[inputType],
              editable: editable,
              decoration: InputDecoration(
                  labelText: startDateString,
                  hasFloatingPlaceholder: false,
                  border: OutlineInputBorder()),
              onChanged: (dt) => setState(() {
                    date = dt;
                  }),
              onSaved: (DateTime value) {},
            ),
            SizedBox(
              height: 6.0,
            ),
            new TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  labelText: endDateString,
                  hasFloatingPlaceholder: false,
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 6.0,
            ),
            _buildDomainExtentionInput(),
            SizedBox(
              height: 6.0,
            ),
            _buildCheckBoxUnregistered(),
            SizedBox(
              height: 6.0,
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(
                labelText: 'Keywords Suggestion',
                border: OutlineInputBorder(),
              ),
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
              height: 6.0,
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(
                labelText: 'Words To Avoid',
                border: OutlineInputBorder(),
              ),
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
              height: 6.0,
            ),
            new TextFormField(
              //focusNode: _titleFocusNode,
              decoration: InputDecoration(
                labelText: 'Examples',
                border: OutlineInputBorder(),
              ),
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
            new FormField(
              builder: (FormFieldState state) {
                return Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 6.0),
                  child: new DropdownButton(
                    value: selectedLanguage,
                    hint: Text('Language Preference'),
                    items: _languages.map((languageList) {
                      return new DropdownMenuItem(
                        child: new Text(languageList.languageName),
                        value: languageList.id.toString(),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value;
                        //print('Selected: ' + selectedLanguage);
                      });
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _previousButtom(),
                SizedBox(
                  width: 10.0,
                ),
                _nextButton(),
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
