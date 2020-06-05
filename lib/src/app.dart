import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

// import 'package:flutter_advanced_networkimage/provider.dart';
// import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/zoomable.dart';
// import 'package:show_pics_list/src/loadingScreen.dart';

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
              children: [
                Expanded(
                  child: Text('$day/$month/$year'),
                ),
                Expanded(
                  child: Text('$imgName'),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    child: ZoomableWidget(
                      maxScale: 100,
                      child: Image.network(
                        imgURL,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
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
            });
          },
          child: Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}

// CachedNetworkImage(
//                     imageUrl: imgURL,
//                     progressIndicatorBuilder:
//                         (context, url, downloadProgress) =>
//                             CircularProgressIndicator(
//                                 value: downloadProgress.progress),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),

// TransitionToImage(
//                         image: AdvancedNetworkImage(
//                           imgURL,
//                         ),
//                         width: double.infinity,
//                         loadingWidget: Loading(),
//                         loadingWidgetBuilder: (
//                           BuildContext context,
//                           double progress,
//                           imageData,
//                         ) {
//                           // print(imageData.lengthInBytes);
//                           return Container(
//                             width: 300.0,
//                             height: 300.0,
//                             alignment: Alignment.center,
//                             child: CircularProgressIndicator(
//                               value: progress == 0.0 ? null : progress,
//                             ),
//                           );
//                         }),
