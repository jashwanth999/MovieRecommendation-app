import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/navigations/Topbar.dart';
import 'package:shimmer/shimmer.dart';
//import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Popularviewall extends StatefulWidget {
  final url;
  final userid;
  final username;
  Popularviewall({Key key, @required this.url,this.userid,this.username}) : super(key: key);

  @override
  _PopularviewallState createState() => _PopularviewallState();
}

class _PopularviewallState extends State<Popularviewall> {
  List popularlist;
  void getpopularresponse() async {
    var response = await Dio().get(widget.url);

    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          popularlist = data["results"];
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
    return getallpopularmoviecard();
  }

  Widget getallpopularmoviecard() {
    if (popularlist == null)
      return Container(
          margin: EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (115.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: 100,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: Colors.grey[700],
                  direction: ShimmerDirection.ltr,
                  highlightColor: Colors.grey[500],
                  child: Container(
                    height: 170,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                );
              }));
    else
      return Container(
          margin: EdgeInsets.all(8.0),
          child: GridView.builder(
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (115.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: popularlist.length == 0 ? 0 : 18,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Topbar(
                                            moviename: popularlist[index]
                                                ["original_title"],
                                            userid: widget.userid,
                                            username: widget.username,
                                          )));
                            },
                            child: Container(
                                height: 170,
                                width: double.infinity,
                                child: popularlist[index]["poster_path"] == null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage("images/loading.png"),
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: FadeInImage.assetNetwork(
                                          image:
                                              "https://image.tmdb.org/t/p/w500" +
                                                  popularlist[index]
                                                      ["poster_path"],
                                          placeholder: "images/loading.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ))),
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
