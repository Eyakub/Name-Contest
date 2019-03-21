import 'package:flutter/material.dart';
import '../widgets/ui_elements/side_drawer.dart';

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

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _result = 0;
          break;
        case 1:
          _result = 0;
          break;
        case 3:
          _result = 0;
          break;
        case 4:
          _result = 0;
          break;
        default:
      }
    });
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

  void _nextStep() {
    setState(() {
      _currentStep = _currentStep + 1;
    });
  }

  void _previousStep() {
    setState(() {
      _currentStep = _currentStep - 1;
    });
  }

  Widget _buildStepOne() {
    int groupValue;
    return new Container(
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
          new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: (e) => SawTooth(e),
                  ),
                  new Text(
                    'Business',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: (e) => SawTooth(e),
                  ),
                  new Text(
                    'Business Name & Domain Name',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: (e) => SawTooth(e),
                  ),
                  new Text(
                    'Domain',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: (e) => SawTooth(e),
                  ),
                  new Text(
                    'Product Name',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: (e) => SawTooth(e),
                  ),
                  new Text(
                    'Product Name & Domain',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: (e) => SawTooth(e),
                  ),
                  new Text(
                    'Tagline',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
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
  }

  Widget _buildStepTwo() {
    return new Center(
      child: SingleChildScrollView(
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
            new Column(
              children: <Widget>[
                new RaisedButton(
                  child: new Text('Budget'),
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0),
                  ),
                  color: pressAttention ? Colors.cyan : Colors.transparent,
                  onPressed: () =>
                      setState(() => pressAttention = !pressAttention),
                ),
                new Text(
                  '200+ Submissions\n\$100 Prize Money\nDuration 10 Days',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            new Column(
              children: <Widget>[
                new RaisedButton(
                  child: new Text('Standard'),
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0),
                  ),
                  color: pressAttention ? Colors.cyan : Colors.transparent,
                  onPressed: () =>
                      setState(() => pressAttention = !pressAttention),
                ),
                new Text(
                  '500+ Submissions\n\$200 Prize Money\nDuration 20 Days',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            new Column(
              children: <Widget>[
                new RaisedButton(
                  child: new Text('Premium'),
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0),
                  ),
                  color: pressAttention ? Colors.cyan : Colors.transparent,
                  onPressed: () =>
                      setState(() => pressAttention = !pressAttention),
                ),
                new Text(
                  '1000+ Submissions\n\$500 Prize Money\nDuration 30 Days',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
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
      body: _buildBody(),
    );
  }
}
