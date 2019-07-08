import 'package:flutter/material.dart';
import 'package:hacker_news/src/screens/news_list.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HackersNews',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsList(),
    );
  }
}
