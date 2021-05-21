import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Search/searchnames.dart';
import 'package:flutter_app/components/Swiper.dart';
import 'package:flutter_app/viewscreens/Popularviewlist.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
          "https://api.themoviedb.org/3/movie/top_rated?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US",
    },
    {
      "name": "",
      "url":
          "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=1",
    },
    {
      "name": "Popular",
      "url":
          "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=1",
    },
    {
      "name": "Top Movies 2020",
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
      "name": "Highest Grossing Comedy",
      "url":
          "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=35&with_cast=23659&sort_by=revenue.desc",
    },
  ];
  List random = [
    "https://media4.giphy.com/media/FjOsaw9z4BhrW/giphy.webp?cid=ecf05e47eute4qggz1w4r9xvmvfrz9rp5sb137m69oueuel6&rid=giphy.webp&ct=g",
    "https://media4.giphy.com/media/hvdL7Xcmperfi/200w.webp?cid=ecf05e47eute4qggz1w4r9xvmvfrz9rp5sb137m69oueuel6&rid=200w.webp&ct=g",
    "https://media2.giphy.com/media/EOfarA6ZUqzZu/giphy.webp?cid=ecf05e47reqkq2a2b4z9qd8glcnitq4zmx0p4cvrfwuzjxxh&rid=giphy.webp&ct=g",
    "https://media1.giphy.com/media/OPOIcmwa6Ew2A/giphy.webp?cid=ecf05e47jrjqiwc0qsq96bwibzcrrqdmj84xl8a4kuvg4oo0&rid=giphy.webp&ct=g",
    "https://media3.giphy.com/media/ZCU3YxmmD8lh6savbB/giphy.webp?cid=ecf05e470ruaj4i5c77h2xuitfl1hzc7gg785m3c23k4vuxw&rid=giphy.webp&ct=g",
    "https://media3.giphy.com/media/11OOAQSnUaZT2M/200w.webp?cid=ecf05e47ll9grii3i5nt42w9g0ktp1tyk989w5e9g5cxr1fc&rid=200w.webp&ct=g",
    "https://media4.giphy.com/media/fIIu2R4Z57iMw/giphy.webp?cid=ecf05e471yhc4ruonuc9pdac60r5j7nye28gdmpi47i2h9x7&rid=giphy.webp&ct=g",
    "https://media3.giphy.com/media/NENOgw8mgH0NW/giphy.webp?cid=ecf05e471yhc4ruonuc9pdac60r5j7nye28gdmpi47i2h9x7&rid=giphy.webp&ct=g"
        "https://media2.giphy.com/media/zRQIOikoG10CMxtpBh/200w.webp?cid=ecf05e47o9094zwn0qatljlqxx6rqqrvnsaybgl96cihigfh&rid=200w.webp&ct=g",
    "https://media0.giphy.com/media/GRM7Z2s6AougoR3rvv/200w.webp?cid=ecf05e47o9094zwn0qatljlqxx6rqqrvnsaybgl96cihigfh&rid=200w.webp&ct=g"
        "https://media0.giphy.com/media/c67v7Gkbr6bYOf5O4s/200w.webp?cid=ecf05e47cg1nqdxowvsyx5k7sdiudbj28yv4i3hsuwddf1mi&rid=200w.webp&ct=g"
  ];
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
                                color: Color.fromRGBO(255, 255, 250, 0.5),
                                colorBlendMode: BlendMode.modulate,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    random[Random().nextInt(random.length)])),
                          ),
                          Positioned(
                              bottom: 20,
                              left: 20,
                              child: Shimmer.fromColors(
                                  period: Duration(milliseconds: 2000),
                                  baseColor: Colors.grey[100],
                                  direction: ShimmerDirection.ltr,
                                  highlightColor: Colors.grey[800],
                                  child: Container(
                                      child: Text(
                                    "TRY NEW",
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
              return getlatest(data[index]["name"], data[index]['url']);
            }));
  }

  Widget gethead() {
    return Container(
        margin: EdgeInsets.only(top: 28, left: 5, right: 5, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Text("Try Me 🍻",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ))),
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
                  size: 30.0,
                )),
          ],
        ));
  }

  Widget getlatest(name, url) {
    return Container(
        child: Column(
      children: [
        getlatesthead(name, url),
        Latest(
          url: url,
          id: widget.id,
          username: widget.username,
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
                        child: Text(name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold)))),
              ],
            ),
            Container(
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
