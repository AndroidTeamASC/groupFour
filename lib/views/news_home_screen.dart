import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_homework/everything.dart';
import 'package:flutter_news_homework/views/everything_screen.dart';
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
        // appBar: AppBar(
        //   title: Text('News'),
        //   backgroundColor: Colors.cyan,
        // ),
        body: everything == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "News",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: everything.articles
                          .map((news) => Container(
                                height: 100,
                                padding: EdgeInsets.all(2.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DetailNewScreen.routeName,
                                        arguments: Articles(
                                          source: news.source,
                                          author: news.author,
                                          title: news.title,
                                          description: news.description,
                                          url: news.url,
                                          urlToImage: news.urlToImage,
                                          publishedAt: news.publishedAt,
                                          content: news.content,
                                        ));
                                  },
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
                                        height: 10,
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
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Popular",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            )),
                        Align(
                          alignment: Alignment.topRight,
                          child: RaisedButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, EverythingHome.routeName,
                              // arguments: Everything(
                              //   status: everything.status,
                              //   totalResults: everything.totalResults,
                              //   articles: everything.articles,
                              // ));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EverythingHome()));
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: everything.articles
                          .map((news) => Container(
                                height: 150,
                                padding: EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DetailScreen.routeName,
                                        arguments: Articles(
                                          source: news.source,
                                          author: news.author,
                                          title: news.title,
                                          description: news.description,
                                          url: news.url,
                                          urlToImage: news.urlToImage,
                                          publishedAt: news.publishedAt,
                                          content: news.content,
                                        ));
                                  },
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
                                        child: (news.description == null
                                            ? Text("Description")
                                            : Text(
                                                news.description,
                                                maxLines: 2,
                                                style: TextStyle(),
                                              )),
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

class DetailNewScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  @override
  Widget build(BuildContext context) {
    final Articles args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Everything News'),
      ),
      body: Column(children: [
        Image.network(args.urlToImage, width: 200, height: 200),
        Text(args.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text(args.author), Text(args.publishedAt)],
        ),
        Text(args.description),
      ]),
    );
  }
}
