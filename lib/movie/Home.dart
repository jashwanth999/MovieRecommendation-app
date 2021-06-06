import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Search/searchnames.dart';
import 'package:flutter_app/components/Swiper.dart';
import 'package:flutter_app/viewscreens/Popularviewlist.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../components/Homecorousel.dart';
import '../components/Movieslist.dart';

class Home extends StatefulWidget {
  final id;
  final username;
  @override
  Home({Key key, @required this.id, this.username}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String s = "";
  Future getdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var recent = sharedPreferences.getStringList("recent");
    print(recent);
    return recent[recent.length - 1];
  }

  List data = [
    {
      "name": "",
      "url": "",
    },
    {
      "name": "",
      "url": "",
    },
    {
      "name": "Top Rated",
      "url":
          "https://api.themoviedb.org/3/movie/top_rated?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=2",
    },
    {
      "name": "",
      "url":
          "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=1",
    },
    {
      "name": "Top Movies of 2020",
      "url":
          "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2020",
    },
    {
      "name": "Top Movies 2019",
      "url":
          "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2019",
    },
    {
      "name": "Action Movies",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=18",
    },
    {
      "name": "Horror",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=27"
    },
    {
      "name": "kids",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=16"
    },
    {
      "name": "Thriller",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=9648"
    },
    {
      "name": "Romance",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=10749"
    },
    {
      "name": "Family",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=10751"
    },
    {
      "name": "Crime",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=80"
    },
    {
      "name": "",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=80"
    },
  ];

  List random = [
    "images/gif1.gif",
    "images/gif3.webp",
    "images/gif4.gif",
    "images/gif5.gif",
    "images/gif6.gif",
    "images/gif7.webp",
    "images/gif8.gif",
    "images/gif9.webp",
    "images/gif10.webp"
  ];
  void initState() {
    super.initState();
    this.getdata().then((value) => {
          setState(() {
            s = value;
          }),
          print(s)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: getlist()));
  }

  Widget getlist() {
    return Container(
        child: ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) return gethead();
              if (index == 1) return Homecorousel();
              if (index == 3)
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Swiper(
                                  userid: widget.id,
                                  username: widget.username)));
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                                color: Color.fromRGBO(255, 255, 250, 0.7),
                                colorBlendMode: BlendMode.modulate,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    random[Random().nextInt(random.length)])),
                          ),
                          Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                  child: Shimmer.fromColors(
                                      period: Duration(milliseconds: 2000),
                                      baseColor: Colors.grey[100],
                                      direction: ShimmerDirection.ltr,
                                      highlightColor: Colors.grey[600],
                                      child: Text(
                                        "SWIPE CARDS",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )))),
                          Positioned(
                              top: 90,
                              right: 10,
                              child: Shimmer.fromColors(
                                  period: Duration(milliseconds: 2000),
                                  baseColor: Colors.grey[100],
                                  direction: ShimmerDirection.ltr,
                                  highlightColor: Colors.grey[800],
                                  child: Container(
                                      child: Icon(
                                    AntDesign.right,
                                    size: 40,
                                    color: Colors.white,
                                  ))))
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ));
              if (index == 13) {
                if (s == "") return Container();
                return getlatest("Cuz you searched for " + s,
                    "http://movie-bj-9.herokuapp.com/send/" + s, s);
              }

              return getlatest(data[index]["name"], data[index]['url'], "");
            }));
  }

  Widget gethead() {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Row(children: [
              Container(
                  height: 43,
                  width: 43,
                  child: Image(
                    color: Colors.pink,
                    fit: BoxFit.cover,
                    image: AssetImage("images/logo3.png"),
                  )),
              Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: Colors.grey[100],
                  direction: ShimmerDirection.ltr,
                  highlightColor: Colors.grey[800],
                  child: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text("TRY ME",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold)))),
            ])),
            InkWell(
                highlightColor: Colors.grey,
                hoverColor: Colors.white,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Searchnames(
                                userid: widget.id,
                                username: widget.username,
                              )));
                },
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28.0,
                )),
          ],
        ));
  }

  Widget getlatest(name, url, recentname) {
    return Container(
        child: Column(
      children: [
        getlatesthead(name, url),
        Latest(
          url: url,
          id: widget.id,
          username: widget.username,
          recentname: recentname,
        )
      ],
    ));
  }

  Widget getlatesthead(name, url) {
    return Container(
        margin: EdgeInsets.only(top: 15, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 25,
                  width: 5,
                  margin: EdgeInsets.only(right: 8, left: 2),
                  decoration: BoxDecoration(color: Colors.blue[300]),
                ),
                Shimmer.fromColors(
                    period: Duration(milliseconds: 2000),
                    baseColor: Colors.grey[100],
                    direction: ShimmerDirection.ltr,
                    highlightColor: Colors.grey[800],
                    child: Container(
                        width: 250,
                        child: Text(name.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)))),
              ],
            ),
            name == "Cuz you searched for " + s
                ? Container()
                : Container(
                    child: InkWell(
                    highlightColor: Colors.grey,
                    hoverColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Popularviewlist(
                                    originalmoviename: name,
                                    url: url,
                                    userid: widget.id,
                                    username: widget.username,
                                  )));
                    },
                    child: Text("MORE",
                        style: TextStyle(
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ))
          ],
        ));
  }
}
