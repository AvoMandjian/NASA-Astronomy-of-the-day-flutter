import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('$i images'),
        ),
        appBar: AppBar(
          title: Text('Let\'s see some Images'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              i++;
            });
          },
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
