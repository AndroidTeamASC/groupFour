import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_news_homework/views/news_home_screen.dart';
=======
import 'package:flutter_news_homework/views/bottom_navigation.dart';
import 'package:flutter_news_homework/views/everything_screen.dart';

import 'everything.dart';
>>>>>>> ktp

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsHome(),
      // home: BottomNavigate(),
      //   home: EverythingHome(),
      //   routes: {
      //   DetailScreen.routeName: (context) => DetailScreen() //simple extract
      // },
    );
  }
}
