import 'package:flutter/material.dart';
import 'package:flutter_app/components/Topbarscreens/Recommendations.dart';
import 'package:flutter_app/components/Topbarscreens/Reviews.dart';
import "../components/Topbarscreens/About.dart";
import '../components/Topbarscreens/Cast.dart';
import 'package:dio/dio.dart';

class Topbar extends StatefulWidget {
  final moviename;
  Topbar({
    Key key,
    @required this.moviename,
  }) : super(key: key);

  @override
  _TopbarState createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  List moviedetails;

  void getpopularresponse() async {
    try {
      var response = await Dio().get(
          "http://movie-bj-9.herokuapp.com/getmovie/" +
              widget.moviename.toString());
      var data = response.data;

      setState(() {
        moviedetails = [data];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getpopularresponse();
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
                          expandedHeight: 320,
                          pinned: true,
                          bottom: TabBar(
                            isScrollable: true,
                            indicatorWeight: 3,
                            indicatorColor: Colors.pink,
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
                                child: GestureDetector(
                                  child: Container(
                                    child: Text("Recommends",
                                        style: TextStyle(fontSize: 18)),
                                  ),
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
                                  child: Stack(
                            children: [
                              moviedetails == null
                                  ? Center(child: CircularProgressIndicator())
                                  : Container(
                                      width: double.infinity,
                                      height: 240,
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original" +
                                                moviedetails[0]
                                                    ['backdrop_path'],
                                          ))),
                              Positioned(
                                  bottom: 60,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              width: 30,
                                              height: 30,
                                              child: Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    "https://play-lh.googleusercontent.com/IO3niAyss5tFXAQP176P0Jk5rg_A_hfKPNqzC4gb15WjLPjo5I-f7oIZ9Dqxw2wPBAg",
                                                  ))),
                                          Container(
                                              width: 30,
                                              height: 30,
                                              child: Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRg5PtQDBAG-OciYiSal0Xghm5FeD5EmbzlA&usqp=CAU",
                                                  ))),
                                          Container(
                                              width: 30,
                                              height: 30,
                                              child: Text(
                                                "💯",
                                                style: TextStyle(fontSize: 20),
                                              )),
                                        ],
                                      )))
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
                            overview: moviedetails[0]['overview'],
                            moviename: moviedetails[0]['original_title'],
                            id: moviedetails[0]['id']),
                        Cast(id: moviedetails[0]['id']),
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

  Widget getcard() {
    return Container(
      width: 300,
      height: 450,
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: 150,
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    spreadRadius: 5.0,
                    blurRadius: 4.0,
                  ), //BoxShadow
                ],
              ),
              child: Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    "https://movies-b26f.kxcdn.com/wp-content/uploads/2020/05/king_kong_2005_-_photofest_-_h_2017-1-770x470.jpg",
                  ))),
        ],
      ),
    );
  }
}
