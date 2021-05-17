import 'package:flutter/material.dart';
import 'package:flutter_app/navigations/Topbar.dart';
import 'package:dio/dio.dart';
import 'package:shimmer/shimmer.dart';

class Latest extends StatefulWidget {
  final url;
  Latest({Key key, @required this.url}) : super(key: key);

  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  List val;
  Future getresponse() async {
    var response = await Dio().get(widget.url);
    var data = response.data;
    try {
      setState(() {
        val = data["results"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getresponse();
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
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                )),
                          ],
                        )));
              }));
  }
}
