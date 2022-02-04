import 'package:flutter/material.dart';
import 'package:flutterfinalodevi/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String url =
      "https://run.mocky.io/v3/05b478c7-5974-4709-92bc-d50010c12827";

  List<valorat_team> myAllData = [];

  @override
  void initState() {
    loadData();
  }

  loadData() async {
    var response = await http.get(url, headers: {"Aceept": "application/json"});
    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      for (var data in jsonBody) {
        myAllData.add(new valorat_team(
            data['ortalama_kill'], data['main_hero'], data['nick_name']));
      }
      setState(() {});
      myAllData
          .forEach((someData) => print("Name : ${someData.ortalama_kill}"));
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('VALORANT TEAM'),
      ),
      body: myAllData.length == 0
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : showMyUI(),
    ));
  }

  Widget showMyUI() {
    return new ListView.builder(
        itemCount: myAllData.length,
        itemBuilder: (_, index) {
          return new Container(
            margin: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: new Card(
              elevation: 10.0,
              child: new Container(
                padding: new EdgeInsets.all(12.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    new Text(
                        'ORTALAMA KİLL : ${myAllData[index].ortalama_kill}'),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    new Text(
                        'MAİN HERO : ${myAllData[index].main_hero}'),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    new Text(
                        'NİCK NAME : ${myAllData[index].nick_name}'),
                    new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 3.0)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
