import 'package:flutter/material.dart';
import 'package:flutter_app/navigations/Topbar.dart';
import 'package:dio/dio.dart';

class Popular extends StatefulWidget {
  Popular({
    Key key,
  }) : super(key: key);

  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  List popularlist;
  Future getpopularresponse() async {
    var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
        "popular" +
        "?api_key=8b5da40bcd2b5fa4afe55c468001ad8a");
    var data = response.data;
    try {
      setState(() {
        popularlist = data["results"];
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    this.getpopularresponse();
  }

  @override
  Widget build(BuildContext context) {
    if (popularlist == null)
      return Container(
          height: 160, child: Center(child: CircularProgressIndicator()));
    else
      return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          height: 160.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularlist.length != null ? popularlist.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Topbar(
                                    moviename: popularlist[index]["title"],
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
                                height: 145,
                                width: 120,
                                child: FadeInImage.assetNetwork(
                                  image: "https://image.tmdb.org/t/p/w500" +
                                      popularlist[index]["poster_path"],
                                  placeholder: "images/loading.png",
                                  fit: BoxFit.cover,
                                )),
                            Positioned(
                                top: 3,
                                right: 0,
                                child: GestureDetector(
                                    onTap: () {
                                      Scaffold.of(context)
                                          .showBottomSheet<void>(
                                        (BuildContext context) {
                                          return Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.black),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                          child: Text(
                                                        "Add to watchlist",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25),
                                                      ))),
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                          child: Text(
                                                        "Close",
                                                        style: TextStyle(
                                                            color: Colors.pink,
                                                            fontSize: 20),
                                                      )))
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ))),
                          ],
                        )));
              }));
  }
}
