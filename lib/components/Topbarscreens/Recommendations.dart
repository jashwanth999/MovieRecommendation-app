import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/components/wachlist/Addwatchlist.dart';
import 'package:flutter_app/navigations/Topbar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shimmer/shimmer.dart';

class Recommendations extends StatefulWidget {
  final id;
  final userid;
  final movie_name;
  final username;
  Recommendations(
      {Key key, @required this.id, this.movie_name, this.username, this.userid})
      : super(key: key);

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  List popularlist;
  List recommend;
  Future<void> _showMyDialog(movieid, moviename, posterpath) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Container(
                height: 140,
                width: 140,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Addwatchlist(
                                      userid: widget.userid,
                                      username: widget.username,
                                      movieid: movieid,
                                      moviename: moviename,
                                      posterpath: posterpath)));
                        },
                        child: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              AntDesign.plussquare,
                              color: Colors.red,
                              size: 30,
                            ),
                            Text(
                              "Add TO WATCHLIST",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  color: Colors.white),
                            ),
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

  void getpopularresponse() async {
    try {
      var response = await Dio().get("http://movie-bj-9.herokuapp.com/send/" +
          widget.movie_name.toString());
      var data = response.data;
      if (mounted) {
        setState(() {
          if (mounted) {
            popularlist = data;
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void getreommend() async {
    try {
      var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
          widget.id.toString() +
          "/recommendations?api_key=360a9b5e0dea438bac3f653b0e73af47&language=en-US&page=1");

      var data = response.data;
      if (mounted) {
        setState(() {
          recommend = data['results'];
        });
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    this.getpopularresponse();
    this.getreommend();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(children: [
          getallpopularmoviecard(),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 8,
            ),
            child: Text("MORE LIKE THIS 💙",
                style: TextStyle(
                    color: Color.fromRGBO(222, 49, 99, 1),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
          getallpopularmoviecards()
        ])));
  }

  Widget getallpopularmoviecard() {
    if (popularlist == null)
      return Container(
          margin: EdgeInsets.only(top: 10),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (130.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: 12,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: Colors.grey[700],
                  direction: ShimmerDirection.ltr,
                  highlightColor: Colors.grey[500],
                  child: Container(
                    height: 160,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                );
              }));
    else
      return Container(
          color: Colors.black,
          margin: EdgeInsets.only(top: 10),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (130.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: popularlist != null ? popularlist.length : 0,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black),
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Topbar(
                                            moviename: popularlist[index]
                                                ["title"],
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 160,
                              width: double.infinity,
                              child: popularlist[index]["poster_path"] == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage('images/loading.png')))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: FadeInImage.assetNetwork(
                                        image:
                                            "https://image.tmdb.org/t/p/w500" +
                                                popularlist[index]
                                                    ["poster_path"],
                                        placeholder: "images/loading.png",
                                        fit: BoxFit.cover,
                                      )),
                            )),
                        Positioned(
                          top: 3,
                          right: 0,
                          child: InkWell(
                              onTap: () {
                                _showMyDialog(
                                  popularlist[index]["id"],
                                  popularlist[index]["original_title"],
                                  popularlist[index]["poster_path"],
                                );
                              },
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ));
              }));
  }

  Widget getallpopularmoviecards() {
    if (popularlist == null)
      return Container(
          margin: EdgeInsets.only(top: 10),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (130.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: 12,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: Colors.grey[700],
                  direction: ShimmerDirection.ltr,
                  highlightColor: Colors.grey[500],
                  child: Container(
                    height: 160,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                );
              }));
    else
      return Container(
          color: Colors.black,
          margin: EdgeInsets.only(top: 0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (130.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: recommend != null ? recommend.length : 0,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black),
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Topbar(
                                            moviename: recommend[index]
                                                ["title"],
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 160,
                              width: double.infinity,
                              child: recommend[index]["poster_path"] == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage('images/loading.png')))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: FadeInImage.assetNetwork(
                                        image:
                                            "https://image.tmdb.org/t/p/w500" +
                                                recommend[index]["poster_path"],
                                        placeholder: "images/loading.png",
                                        fit: BoxFit.cover,
                                      )),
                            )),
                        Positioned(
                            top: 3,
                            right: 0,
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            )),
                      ],
                    ));
              }));
  }
}
