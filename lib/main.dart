
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp>{

  //Buttons- Flat and Raised buttons
  String _value = 'Hello World!';

  int val = 0;

  void _add(){
    setState(() {
      val++;
    });
  }

  void _substarct(){
    setState(() {
      val--;
    });
  }


  void _onPressed(String value){
    setState(() {
      _value = value;
    });
  }

  //Textfields

  String textValue = '';

  void _submit(String value){
    setState(() {
      textValue = 'Submit = $value';
    });
  }

  void _change(String value){
    setState(() {
      textValue = 'Change = $value';
    });
  }

  //Checkboxes
  bool _value1 = false;
  bool _value2 = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);

  //Radio
  int _radioValue1 = 0;
  int _radioValue2 = 0;

  void _setRadioValue1(int value) => setState(() => _radioValue1 = value);
  void _setRadioValue2(int value) => setState(() => _radioValue2 = value);

  Widget makeRadios(){
    List<Widget> list = new List();
    for (int i = 0 ;i<3; i++){
      list.add(new Radio(value: i, groupValue: _radioValue1, onChanged: _setRadioValue1));
    }

    Column column = new Column(children: list,);
    return column;
  }

  Widget makeRadiosListTiles(){
    List<Widget> list = new List();
    for (int i = 0 ;i<3; i++){
      list.add(new RadioListTile(
          value: i, 
          groupValue: _radioValue2, 
          onChanged: _setRadioValue2,
        activeColor: Colors.green,
          controlAffinity: ListTileControlAffinity.platform,
        title: new Text('Item: ${i}'),
        subtitle: new Text('Subtitle'),
      ));
    }

    Column column = new Column(children: list,);
    return column;
  }

  //switch
  bool _switchValue1 = false;
  bool _switchValue2 = false;

  void _switchValue1Changed(bool value) => setState(() => _switchValue1 = value);
  void _switchValue2Changed(bool value) => setState(() => _switchValue2 = value);

  //Slider
  double _slideValue = 0.0;

  void _setSlideValue (double value) => setState(() => _slideValue = value);

  //Datepicker
  String _dateValue = '';
  Future _selectDate() async{
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2015),
        lastDate: new DateTime(2022));

    if (picked != null) setState(() {
      _dateValue = picked.toString();
    });
  }

  //App bar
  int _appbarValue = 0;
  void _appBarAdd() => setState(() => _appbarValue++);

  //Floating Action button
  String _fabValue = '';
  void _onFabClick () => setState(()=> _fabValue = DateTime.now().toString());

  //List View
  Map _countries = new Map();
  
  void _getData() async{
    var url = 'http://country.io/names.json';
    var response = await http.get(url);
     if (response.statusCode == 200){
       setState(() {
         _countries = json.decode(response.body);
         print('Loaded ${_countries.length} countries');
       });
     }
  }


  @override
  void initState() {
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Name Here"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add), onPressed: _appBarAdd)
        ],
      ),
      persistentFooterButtons: <Widget>[
        new IconButton(icon: new Icon(Icons.list), onPressed: null),
        new IconButton(icon: new Icon(Icons.archive), onPressed: null),
        new IconButton(icon: new Icon(Icons.people), onPressed: null)
      ],
      floatingActionButton: new FloatingActionButton(
          onPressed: _onFabClick,
        child: new Icon(Icons.add),
      ),
      drawer: new Drawer(
        child: new Container(
          padding: EdgeInsets.all(32.0),
          child: new Column(
            children: <Widget>[
              new Text("Hello drwaer"),
              new RaisedButton(onPressed: () => Navigator.pop(context), child: new Text("close"),)
            ],
          ),
        ),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text(_appbarValue.toString()),
              new Text(_value),
              new RaisedButton(onPressed: () => _onPressed("Testst"), child: new Text('Click Me')),
              new FlatButton(onPressed: () => _onPressed("Flat"), child: new Text('Click Me!')),
              new Text('Value is $val'),
              new IconButton(icon: new Icon(Icons.add), onPressed: _add),
              new IconButton(icon: new Icon(Icons.remove), onPressed: _substarct),
              new Text(textValue),
              new TextField(
                decoration: new InputDecoration(
                  labelText: "Enter",
                  hintText: "Hint",
                  icon: new Icon(Icons.people)
                ),
                autocorrect: true,
                autofocus: true,
                keyboardType: TextInputType.number,
                onChanged: _change,
                onSubmitted: _submit,
              ),
              Checkbox(value: _value1, onChanged: _value1Changed),
//              CheckboxListTile(
//                value: _value2,
//                onChanged: _value2Changed,
//                title: new Text("Hello"),
//                controlAffinity: ListTileControlAffinity.leading,
//                subtitle: new Text('Subtitle'),
//                secondary: new Icon(Icons.archive),
//                activeColor: Colors.red,
//              ),
              //makeRadios(),
              //makeRadiosListTiles()
//              Switch(value: _switchValue1, onChanged: _switchValue1Changed,),
//              SwitchListTile(
//                  value: _switchValue2,
//                  onChanged: _switchValue2Changed,
//                title: new Text('Hello'),
//              ),
              new Text('Value is ${(_slideValue*100).round()}'),
              new Slider(value: _slideValue, onChanged: _setSlideValue),
              new RaisedButton(onPressed: _selectDate, child: new Text('Select Date'),),
              new Image.asset('images/pic.jpeg'),
              new Expanded(child:new Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg')),
              new Expanded(child:new Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg')),
              new Expanded(child: new ListView.builder(
                  itemCount : _countries.length,
                  itemBuilder: (BuildContext context, int index){
                    String key = _countries.keys.elementAt(index);
                    return new Row(
                      children: <Widget>[
                        new Text('${key} :'),
                        new Text(_countries[key])
                      ],
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}