import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Search/searchnames.dart';
import '../components/Homecorousel.dart';
import '../viewscreens/popularviewall.dart';
import '../components/Latest.dart';
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
      "name": "Popular",
      "url":
          "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=1",
    },
    {
      "name": "Top Rated",
      "url":
          "https://api.themoviedb.org/3/movie/top_rated?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=1",
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
      children: [getlatesthead(name), Latest(url: url)],
    ));
  }

  Widget getbestdramaname() {
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
                    child: Text('Top movies in 2020',
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
                              movieurlname: 'popular',
                              originalmoviename: 'Popular',
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

  Widget gettrendingname() {
    return Container(
        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Text("Trending",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
            Container(
                child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Popularviewall(
                              movieurlname: 'Trending',
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

  Widget getlatesthead(name) {
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
                              movieurlname: 'upcoming',
                              originalmoviename: 'Upcoming',
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

  Widget getpopularhead() {
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
                    child: Text('Popular',
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
                              movieurlname: 'popular',
                              originalmoviename: 'Popular',
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

  Widget topratedhead() {
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
                    child: Text('Top Rated',
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
                                movieurlname: 'top_rated',
                                originalmoviename: 'Top Rated',
                              )));
                },
                child: Text("VIEW ALL",
                    style: TextStyle(
                        color: Colors.white,
                        //fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
            )
          ],
        ));
  }
}
