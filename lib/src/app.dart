import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int i = 0;
  Random range = Random();

  String url = 'https://jsonplaceholder.typicode.com/albums/1/photos';
  var data;
  var imgURL = '';

  Future getData() async {
    http.Response response = await http.get(url);
    setState(() {
      data = json.decode(response.body);
      imgURL = data[range.nextInt(49)]['url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image.network(
            '$imgURL',
          ),
        ),
        appBar: AppBar(
          title: Text('Let\'s see some Images'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              i++;
              getData();
              print(imgURL);
            });
          },
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
