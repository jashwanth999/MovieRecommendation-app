import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Search/searchnames.dart';
import '../components/Homecorousel.dart';
import '../viewscreens/popularviewall.dart';
import '../components/Latest.dart';
import '../components/Toprated.dart';
import '../components/Popular.dart';

class Home extends StatefulWidget {
  final id;
  final username;
  @override
  Home({Key key, @required this.id, this.username}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  gethead(),
                  Homecorousel(),
                  getpopular(),
                  gettoprated(),
                  getlatest()
                ]))));
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

  Widget gettoprated() {
    return Container(
        child: Column(
      children: [
        topratedhead(),
        Toprated(),
      ],
    ));
  }

  Widget getpopular() {
    return Container(
        child: Column(
      children: [getpopularhead(), Popular()],
    ));
  }

  Widget getlatest() {
    return Container(
        child: Column(
      children: [getlatesthead(), Latest()],
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
                      fontSize: 22,
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

  Widget getlatesthead() {
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
                    child: Text('Latest',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
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
                            fontSize: 22,
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
                            fontSize: 22,
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
