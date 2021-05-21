import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigations/Topbar.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class Swiper extends StatefulWidget {
  final userid;
  final username;

  Swiper({Key key, @required this.userid, this.username}) : super(key: key);

  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  List val;
  Future postdata(movieid, moviename, posterpath) async {
    final String url = "https://fast-tor-93770.herokuapp.com/saved/" +
        widget.userid +
        "/" +
        movieid.toString();
    dynamic dat = {
      "userid": widget.userid,
      "username": widget.username,
      "savedlist": [
        {
          "movieid": movieid.toString(),
          "moviename": moviename,
          "poster_path": posterpath
        }
      ]
    };
    try {
      await Dio().post(url,
          data: dat,
          options: Options(
              headers: {'Content-Type': 'application/json;charset=UTF-8'}));
    } catch (e) {
      print(e);
    }
  }

  List url = [
    "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=1",
    "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=2",
    "https://api.themoviedb.org/3/movie/popular?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US&page=3",
    "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=18",
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2020",
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2019",
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2017",
    "http://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&primary_release_year=2016"
  ];
  Future getresponse() async {
    var response = await Dio().get(url[Random().nextInt(url.length)]);
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          val = data["results"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getresponse();
  }

  bool right = false;
  Future<void> _showMyDialog(movieid, moviename, posterpath) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Container(
                height: 120,
                width: 140,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          postdata(movieid, moviename, posterpath)
                              .then((val) => {
                                    Navigator.pop(context),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: Text("SAVED",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        action: SnackBarAction(
                                          label: 'Cancel',
                                          onPressed: () {},
                                        ),
                                      ),
                                    )
                                  });
                        },
                        child: Container(
                            child: Row(
                          children: [
                            Icon(
                              Icons.bookmark,
                              color: Colors.red,
                              size: 30,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "SAVE THIS MOVIE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                )),
                          ],
                        ))),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            right = false;
                          });
                        },
                        child: Container(
                            child: Text(
                          "CLOSE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )))
                  ],
                ))),
          );
        });
  }

  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "TRY NEW",
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: val == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              alignment: Alignment.center,
              height: double.infinity,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.only(bottom: 20),
              child: new TinderSwapCard(
                orientation: AmassOrientation.BOTTOM,
                totalNum: val.length,
                stackNum: 3,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 1.0,
                maxHeight: MediaQuery.of(context).size.width * 1.6,
                minWidth: MediaQuery.of(context).size.width * 0.85,
                minHeight: MediaQuery.of(context).size.width * 1,
                cardBuilder: (context, index) => Card(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Topbar(
                                      userid: widget.userid,
                                      username: widget.username,
                                      moviename: val[index]
                                          ['original_title'])));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: FadeInImage.assetNetwork(
                                  image: "https://image.tmdb.org/t/p/w500" +
                                      val[index]["poster_path"],
                                  placeholder: "images/loading.png",
                                  fit: BoxFit.cover,
                                ))))),
                cardController: controller = CardController(),
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  if (align.x < 0) {
                  } else if (align.x > 3) {
                    /* ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: Text("SAVED",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        action: SnackBarAction(
                          label: 'Cancel',
                          onPressed: () {
                           
                          },
                        ),
                      ),
                    );*/
                    setState(() {
                      right = true;
                    });
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                  if (right) {
                    _showMyDialog(
                        val[index]["id"],
                        val[index]["original_title"],
                        val[index]["poster_path"]);
                  }
                },
              ),
            ),
    );
  }
}
