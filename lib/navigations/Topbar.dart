import 'package:flutter/material.dart';
import 'package:flutter_app/components/Error.dart';
import 'package:flutter_app/components/Topbarscreens/Recommendations.dart';
import 'package:flutter_app/components/Topbarscreens/Reviews.dart';
import 'package:flutter_app/components/wachlist/Addwatchlist.dart';
import 'package:flutter_icons/flutter_icons.dart';
import "../components/Topbarscreens/About.dart";
import '../components/Topbarscreens/Cast.dart';
import 'package:dio/dio.dart';

class Topbar extends StatefulWidget {
  final moviename;
  final userid;
  final username;
  Topbar({Key key, @required this.moviename, this.userid, this.username})
      : super(key: key);

  @override
  _TopbarState createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  List moviedetails;

  void getpopularresponse() async {
    if (widget.moviename == null || widget.moviename == "") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Error()));
    }
    try {
      var response = await Dio().get(
          "http://movie-bj-9.herokuapp.com/getmovie/" +
              widget.moviename.toString());
      var data = response.data;

      setState(() {
        moviedetails = [data];
      });
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Error()));
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      this.getpopularresponse();
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Error()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: DefaultTabController(
            length: 4,
            child: moviedetails == null
                ? Center(child: CircularProgressIndicator())
                : NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverAppBar(
                          backgroundColor: Colors.black,
                          expandedHeight: 380,
                          pinned: true,
                          bottom: TabBar(
                            isScrollable: true,
                            indicatorWeight: 3,
                            indicator: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.greenAccent, width: 3.0),
                              ),
                            ),
                            unselectedLabelColor: Colors.white,
                            tabs: [
                              Tab(
                                child: Container(
                                  child: Text("About",
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Text("Cast",
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Text("Recommends",
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Text("Reviews",
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ),
                            ],
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              moviedetails[0]['backdrop_path'] == null
                                  ? Container(
                                      width: double.infinity,
                                      height: 230,
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            "images/loading3.jpg",
                                          )))
                                  : Container(
                                      width: double.infinity,
                                      height: 230,
                                      child: Image(
                                          fit: BoxFit.cover,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.6),
                                          colorBlendMode: BlendMode.modulate,
                                          image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original" +
                                                moviedetails[0]
                                                    ['backdrop_path'],
                                          ))),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.all(5),
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.blueGrey),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 4, left: 5),
                                                      child: Icon(
                                                          AntDesign.play,
                                                          size: 22,
                                                          color: Colors.white)),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 4,
                                                        left: 12,
                                                        top: 2),
                                                    child: Text(
                                                      "Trailer",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ))),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Addwatchlist(
                                                          userid: widget.userid,
                                                          username:
                                                              widget.username,
                                                          movieid:
                                                              moviedetails[0]
                                                                  ["id"],
                                                          moviename: moviedetails[
                                                                  0][
                                                              "original_title"],
                                                          posterpath:
                                                              moviedetails[0][
                                                                  "poster_path"],
                                                        )));
                                          },
                                          child: Container(
                                              margin: EdgeInsets.all(5),
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.blueGrey),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 4, left: 10),
                                                      child: Icon(
                                                          AntDesign.plus,
                                                          size: 22,
                                                          color: Colors.white)),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 4,
                                                        left: 5,
                                                        top: 2),
                                                    child: Text(
                                                      "Watchlist",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              )))
                                    ],
                                  )),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        widget.moviename,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none,
                                            color: Colors.blueAccent
                                                .withOpacity(0.8)),
                                      )),
                                      Container(
                                          child: Row(
                                        children: [
                                          Icon(
                                            FontAwesome.star,
                                            color: Colors.amber,
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            child: Text(
                                              moviedetails[0]['vote_average']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      )),
                                    ],
                                  )),
                            ],
                          ))),
                          actions: [
                            GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).showBottomSheet<void>(
                                    (BuildContext context) {
                                      return Container(
                                        height: 220,
                                        decoration:
                                            BoxDecoration(color: Colors.black),
                                        child: Center(
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.pink,
                                                        size: 30,
                                                      ))),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.more_vert)),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        About(
                            userid: widget.userid,
                            username: widget.username,
                            overview: moviedetails[0]['overview'],
                            moviename: moviedetails[0]['original_title'],
                            id: moviedetails[0]['id']),
                        Cast(
                          id: moviedetails[0]['id'],
                          userid: widget.userid,
                          username: widget.username,
                        ),
                        Recommendations(
                            id: moviedetails[0]['id'],
                            movie_name: widget.moviename),
                        Reviews(
                          id: moviedetails[0]['id'],
                          moviename: widget.moviename,
                        )
                      ],
                    ))));
  }
}
