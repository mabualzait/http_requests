import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _jsonValue = await getJsonData();
  print(_jsonValue[0]);
  String _title = _jsonValue[0]['title'];
  runApp(new MaterialApp(
    title: "Http Requests",
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('HTTP Requests'),
        backgroundColor: Colors.lightGreen,
      ),
      body: new Container(
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: _jsonValue.length,
            padding: EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) return new Divider();
              final int index = position ~/ 2;
              return ListTile(
                  title: new Text(
                    "${_jsonValue[index]['title']}",
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  subtitle: new Text(
                    "${_jsonValue[index]['body']}",
                    style: new TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: new Text(
                      "${_jsonValue[index]['title'][0]}",
                      style: new TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  onTap: () =>
                      _showMyMessage(context, "${_jsonValue[index]['title']}")
              );
            },
          )),
    ),
  ));
}

void _showMyMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text("My Alert"),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: new Text('ok'),
      )
    ],
  );
  showDialog(context: context, child: alert);
}

Future<List> getJsonData() async {
  String urlApi = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(urlApi);
  return json.decode(response.body);
}
