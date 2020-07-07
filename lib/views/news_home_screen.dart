import 'package:flutter/cupertino.dart';
import 'package:flutter_news_homework/everything.dart';
import 'package:http/http.dart' as http;

class NewsHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewsState();
  }

}

class _NewsState extends State<NewsHome>{

  var url = 'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=abd0cdfe30854b3983f56072d37d2742';

  Everything everything;
  @override
  void initState(){
    super.initState();
    fetchData();
  }

  fetchData() async{
    var data = await http.get(url);
  }


  @override
  Widget build(BuildContext context) {
    
  }
}