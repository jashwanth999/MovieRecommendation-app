import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/navigations/Topbar.dart';

class Recommendations extends StatefulWidget {
  final id;
  final movie_name;
  Recommendations({Key key, @required this.id, this.movie_name})
      : super(key: key);

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  List popularlist;

  void getpopularresponse() async {
    try {
      var response = await Dio().get("http://movie-bj-9.herokuapp.com/send/" +
          widget.movie_name.toString());
      var data = response.data;
      if (mounted) {
        setState(() {
          popularlist = data;
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(children: [getallpopularmoviecard()])));
  }

  Widget getallpopularmoviecard() {
    if (popularlist == null)
      return Center(child: CircularProgressIndicator());
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
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            )),
                      ],
                    ));
              }));
  }
}
