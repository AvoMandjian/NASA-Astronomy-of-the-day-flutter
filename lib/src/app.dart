import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'loadingscreen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int day = 1;
  int month = 1;
  int year = 1996;
  Random range = Random();

  var data;
  var imgURL = '';
  var imgName = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    String url =
        'https://api.nasa.gov/planetary/apod?api_key=EdFoey2wS4yeNEbpn9unZPWIbdBHKGhoa5nnQh85&date=$year-$month-$day';
    http.Response response = await http.get(url);
    setState(() {
      data = json.decode(response.body);
      imgURL = data['hdurl'];
      imgName = data['title'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('$day/$month/$year'),
                Text('$imgName'),
                Card(
                  child: PinchZoomImage(
                    hideStatusBarWhileZooming: true,
                    image: Image.network(
                      '$imgURL',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('NASA Astronomy Picture of the Day'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              day = Random().nextInt(27) + 1;
              month = Random().nextInt(11) + 1;
              year = Random().nextInt(24) + 1996;
              getData();
              print(imgURL);
            });
          },
          child: Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
