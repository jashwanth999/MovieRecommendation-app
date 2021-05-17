import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Search/searchnames.dart';
import '../components/Homecorousel.dart';
import '../viewscreens/popularviewall.dart';
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
          "https://api.themoviedb.org/3/movie/top_rated?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=1",
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
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Searchnames()));
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
      children: [getlatesthead(name, url), Latest(url: url)],
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
                Container(
                    child: Text(name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
              ],
            ),
            Container(
                child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Popularviewall(
                              movieurlname: name,
                              originalmoviename: name,
                              url: url,
                            )));
              },
              child: Text("VIEW ALL",
                  style: TextStyle(
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ))
          ],
        ));
  }
}
