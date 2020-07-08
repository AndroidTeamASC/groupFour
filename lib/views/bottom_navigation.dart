import 'package:flutter/material.dart';
import 'package:flutter_news_homework/views/everything_screen.dart';

import 'news_home_screen.dart';

class BottomNavigate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BottomNavState();
  }
}

class BottomNavState extends State<BottomNavigate> {

  int selectedIndex = 0;//clicked index

  static const TextStyle textStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static  List<Widget> widgetOption = <Widget>[
    NewsHome(),
    EverythingHome(),
    
    // Text('Home', style: textStyle, ),
    // Text('Favourite', style: textStyle, ),
  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title:  Text('Bottom Navigation'),),
     body: Center(
       child: widgetOption.elementAt(selectedIndex),
     ),
     bottomNavigationBar: BottomNavigationBar(
       items: const <BottomNavigationBarItem>[
         BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home'),),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),title: Text('Favourite'),),
       ],
       currentIndex: selectedIndex,
       selectedItemColor: Colors.green,
       onTap: onItemtapped,
     ),
   );
  }

  void onItemtapped(int index){
    setState(() {
      selectedIndex = index;//0>>1 = if(click 1)

    });
  } 
}