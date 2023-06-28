import 'package:flutter/material.dart';
import 'package:stop_watch/screens/home_screen.dart';

import 'utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STOP WATCH APP',
      theme: ThemeData(
        primarySwatch: basetheme,
        primaryColor: Color(0xFF3F425D),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFC6D9ED),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
            ),
          ],
          title: Text(
            'StopWatch',
            style: TextStyle(color: Color(0xFF3F425D)),
          ),
        ),
        body: MyStopWWatchHomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
