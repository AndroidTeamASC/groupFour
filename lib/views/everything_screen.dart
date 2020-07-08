import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../everything.dart';

class EverythingHome extends StatefulWidget {
  static const routeName = '/everythingArguments';
  @override
  State<StatefulWidget> createState() {
    return EverythingHomeState(
        url:
            "http://newsapi.org/v2/everything?q=apple&from=2020-07-06&to=2020-07-06&sortBy=popularity&apiKey=8f39db3aa4ef40ea83d8ff29a4794ef4");
  }
}

class EverythingHomeState extends State<EverythingHome> {
  String url;
  EverythingHomeState({this.url});

  // var url =
  //     "http://newsapi.org/v2/everything?q=apple&from=2020-07-06&to=2020-07-06&sortBy=popularity&apiKey=8f39db3aa4ef40ea83d8ff29a4794ef4";

  Everything everything;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var data = await http.get(url);
    var jsonData = jsonDecode(data.body);
    everything = Everything.fromJson(jsonData);
    print("Data" + jsonData.toString());

    setState(() {});
  }

  Widget build(BuildContext context) {
    final Everything args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('News'),
      // ),
      body: everything == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              scrollDirection: Axis.vertical,
              children: everything.articles
                  .map(
                    (news) => Padding(
                      padding: EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, DetailScreen.routeName,
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
                        child: Hero(
                            tag: news.urlToImage,
                            child: Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    child: Image.network(news.urlToImage),
                                    width: 100,
                                    height: 100,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      news.title,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.2,
                                        wordSpacing: 0.6,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class DetailScreen extends StatelessWidget {
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
