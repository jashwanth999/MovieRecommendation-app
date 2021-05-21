import 'package:flutter/material.dart';
import 'package:flutter_app/components/wachlist/Addwatchlist.dart';
import 'package:flutter_app/navigations/Topbar.dart';
import 'package:dio/dio.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Latest extends StatefulWidget {
  final url;
  final id;
  final username;
  Latest({Key key, @required this.url, this.id, this.username})
      : super(key: key);

  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  List val;
  List watchlist;
  bool add = false;

  Future getpostdata() async {
    final String url =
        "https://fast-tor-93770.herokuapp.com/watch/" + widget.id;
    try {
      var response = await Dio().get(url);
      return response.data['post'];
    } catch (e) {
      print(e);
    }
  }

  Future getresponse() async {
    var response = await Dio().get(widget.url);
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
    this.getpostdata().then((value) => {
          if (mounted)
            {
              if (value.length == 0)
                {
                  setState(() {
                    watchlist = value;
                  })
                }
              else
                {
                  setState(() {
                    watchlist = value[0]['watchlist'];
                  }),
                }
            }
        });
  }

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
                                      userid: widget.id,
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

  @override
  Widget build(BuildContext context) {
    if (val == null)
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 160.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: Colors.grey[700],
                  direction: ShimmerDirection.ltr,
                  highlightColor: Colors.grey[500],
                  child: Container(
                    width: 110,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                );
              }));
    else
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 160.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: val.length != null ? val.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Topbar(
                                    moviename: val[index]["original_title"],
                                    userid: widget.id,
                                    username: widget.username,
                                  )));
                    },
                    child: Container(
                        width: 110,
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 145,
                                width: 120,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: FadeInImage.assetNetwork(
                                      image: "https://image.tmdb.org/t/p/w500" +
                                          val[index]["poster_path"],
                                      placeholder: "images/loading.png",
                                      fit: BoxFit.cover,
                                    ))),
                            Positioned(
                              top: 3,
                              right: 0,
                              child: GestureDetector(
                                  onTap: () {
                                    _showMyDialog(
                                        val[index]["id"],
                                        val[index]["original_title"],
                                        val[index]["poster_path"]);
                                  },
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        )));
              }));
  }
}
