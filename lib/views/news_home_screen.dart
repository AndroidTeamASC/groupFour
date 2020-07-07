import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_homework/everything.dart';
import 'package:http/http.dart' as http;

class NewsHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsState();
  }
}

class _NewsState extends State<NewsHome> {
  Everything everything;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var data = await http.get(
        "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=abd0cdfe30854b3983f56072d37d2742");

    var jsonData = jsonDecode(data.body);
    everything = Everything.fromJson(jsonData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
          backgroundColor: Colors.cyan,
        ),
        body: everything == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Align(
                  alignment: Alignment.topLeft,
                  child:Text("News",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,),
                 ),
                ),
                  
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: everything.articles
                          .map((news) => Container(
                                padding: EdgeInsets.all(2.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                      child: Column(
                                    children: [
                                      Container(
                                          child: (news.urlToImage == null
                                              ? Image.network(
                                                  "https://images.wsj.net/im-206342/social",
                                                  width: 200,
                                                  height: 200,
                                                )
                                              : Image.network(
                                                  news.urlToImage,
                                                  height: 150,
                                                  fit: BoxFit.fill,
                                                ))),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: 100,
                                        child: Text(
                                          news.title,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              wordSpacing: 0.5,
                                              letterSpacing: 1.5),
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Text("Popular"),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: everything.articles
                          .map((news) => Container(
                                height: 150,
                                padding: EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                      child: Row(
                                    children: [
                                      Container(
                                          child: (news.urlToImage == null
                                              ? Image.network(
                                                  "https://images.wsj.net/im-206342/social",
                                                  width: 200,
                                                  height: 200,
                                                )
                                              : Image.network(
                                                  news.urlToImage,
                                                  height: 150,
                                                  width: 150,
                                                  fit: BoxFit.fill,
                                                ))),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 100,
                                        child: Text(
                                          news.description,
                                          maxLines: 2,
                                          style: TextStyle(),
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                              ))
                          .toList(),
                    ),
                  )
                ],
              ));
  }
}
